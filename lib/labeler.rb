require "json"
require "open3"
require "pry"
require "octokit"

class Labeler
  attr_reader :client, :config
  # @param client Octokit::Client
  # @param config String the relative path of the config file
  def initialize(client: nil, config: nil)
    @client = client || connect_client
    @config = load_config(config)
  end

  # lists all the categories in the labels hash
  def categories
    config[:label_categories].keys.map(&:to_s)
  end

  # @param repo String The repository, aka "pulibrary/figgy"
  # @return Array<Array<String, String>> a list of labels by name and color
  def list_labels(repo)
    client.labels(repo).map { |l| [l[:name], l[:color]] }
  end

  # @param repo String the repository to apply labels to
  def apply_labels(repo)
    config[:label_categories].values.each do |category|
      category[:labels].each do |label|
        if label.is_a?(String)
          client.add_label(repo, label, category[:color])
        elsif label.is_a?(Hash)
          client.add_label(repo, label[:name], category[:color], label.reject { |k| k == :name })
        end
      rescue Octokit::UnprocessableEntity => e
        update_label(repo, label, category) if already_exists_error?(e.message)
      end
    end
  end

  # ensure we pass the description if it's part of the label definition
  def update_label(repo, label, category)
    if label.is_a?(String)
      client.update_label(repo, label, { color: category[:color] })
    elsif label.is_a?(Hash)
      client.update_label(
        repo, label[:name],
        label.reject { |k| k == :name }.merge(color: category[:color])
      )
    end
  end

  # @param config_file String the file name to read configuration from
  def apply_labels_to_all
    repos_array = config[:repositories]
    repos_array.each do |repo|
      apply_labels(repo)
    end
  end

  # Delete all the labels and remove them from issues.
  # WARNING: only for initializing a new project.
  # @param repo String The repository, aka "pulibrary/figgy"
  def clear_labels(repo)
    labels = client.labels(repo)
    labels.each do |label|
      client.delete_label!(repo, label[:name])
    end
  end

  # Delete the labels from the repo
  # @param label String The name of the label, aka "on hold"
  # @return bool Whether it was deleted
  def delete_label(label)
    repos_array = config[:repositories]
    repos_array.map do |repo|
      client.delete_label!(repo, label)
    end
  end

  private

  def connect_client
    Octokit::Client.new(access_token: token, auto_paginate: true)
  end

  def token
    out, _st = Open3.capture2("lpass show hubot_github_token --notes")
    out
  end

  def load_config(file_path)
    return unless file_path
    file_string = File.read(file_path)
    JSON.parse(file_string, symbolize_names: true)
  end

  def already_exists_error?(message)
    message.split("\n")
           .map { |l| l.strip.split(":") }
           .select { |pair| pair.first == "code" }
           .flatten[1]
           .strip == "already_exists"
  end
end
