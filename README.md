# pulibrary GitHub Labeler

This project contains a script that can delete and create labels for github repositories. This gives us consistency between our project repositories.

## Example usage

On the DLS team, after creating a new repository, we run `clear_labels`
and then `apply_labels` to initialize the repository with our standard
set of labels. 

## Initial Setup

Ensure your team has a config file in the config directory. config/dls-labels.json can be used as a reference. A label can be just the label name as a string, or a hash with `name` and `description` keys.

Install external dependencies:
```
$ brew install lastpass-cli
```
Ensure you have access to Shared-ITIMS-Passwords in your lastpass account.

Clone this repository following github's instructions provided in the `Code` dropdown on the main page of this repo.

Install bundled dependencies:
```
$ bundle install
```

### Authorization

Each time you use this tool, you must log in to lastpass. This allows the code to fetch the github token from lastpass.

```
$ lpass login <email@email.com>
```

## Running Commands
For usage instructions run:
```
$ bin/labeler help
```

### Delete all labels in one repository 
A newly-created repository has a handful of default labels, which we like to delete before adding our own. 

Example: To delete all labels from the dpul-c repository, do:

```
$ bin/labeler clear_labels pulibrary/dpul-collections
```

### Create labels in one repository
Example: To apply all the labels from config/dls-labels.json to the dpul-c repository, do:

```
$ bin/labeler apply_labels pulibrary/dpul-collections --config=config/dls-labels.json
```

### Create labels in many repositories
Example: To apply all the labels from config/dls-labels.json to all DLS repositories, do:

```
$ bin/labeler apply_labels_to_all --config=config/dls-labels.json
```

### Delete a label from many repositories
Example: To delete the label 'silly-ideas' from all the DLS repositories, do:

```
$ bin/labeler delete_label --config=config/dls-labels.json "silly-ideas"
```

## About the labels configuration

Labels have a color and a name. In this repository, labels are defined as
belonging to some category. Labels in the same category have the same color.
This helps us quickly recognize the type of label we're looking at even before
we read its name. Categories, their labels, and their colors are defined and
maintained in json config files in the config directory.

Labels should be lower case and use dashes, not underscores.

## Reference
* Code uses the [Octokit Client](https://octokit.github.io/octokit.rb/Octokit/Client/Labels.html)
* Styleguide originated from the [Drupal labels style guide](https://github.com/pulibrary/pul_library_drupal/wiki/Issues-Label-Style-Guide)

