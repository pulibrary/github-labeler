require "thor"
require_relative "labeler"

class LabelerCLI < Thor
  def self.exit_on_failure?
    true
  end

  desc "list_labels <org/repository>", "list all the labels in given repo"
  def list_labels(repo)
    Labeler.new.list_labels(repo).each do |pair|
      puts "#{pair[0]}, #{pair[1]}"
    end
  end

  desc "categories", "list all the category names"
  option :config, required: true, banner: "<relative_file_path>"
  def categories
    config_file = options[:config]
    labeler = Labeler.new(config: config_file)
    puts labeler.categories
  end

  desc "label_repo <org/repository> ", "apply all the labels to given repo"
  option :config, required: true, banner: "<relative_file_path>"
  def label_repo(repo)
    config_file = options[:config]
    labeler = Labeler.new(config: config_file)
    labeler.label_repo(repo)
  end

  desc "label_repos", "apply all the labels to repos found in given config file"
  option :config, required: true, banner: "<relative_file_path>"
  def label_repos
    config_file = options[:config]
    Labeler.new.label_repos(config_file)
  end

  desc "clear_labels <org/repository>", "delete all labels from the given repo"
  def clear_labels(repo)
    Labeler.new.clear_labels(repo)
  end

  desc "delete_label <label>", "delete the label from the configured repos"
  option :config, required: true, banner: "<relative_file_path>"
  def delete_label(label)
    config_file = options[:config]
    puts Labeler.new.delete_label(config_file, label)
  end
end

LabelerCLI.start(ARGV)
