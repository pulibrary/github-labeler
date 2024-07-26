# DLS GitHub Labeler

This project contains a script that can delete and create labels for github
repositories. We run the label creation command on any new DLS github
repository. This gives us consistency between our project repositories.

## Initial Setup

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
### Create labels in one repository
Example: To apply all the labels from labels.json to the dpul-c repository, do:

```
$ bin/labeler apply_labels pulibrary/dpul-collections
```

### Create labels in many repositories
Example: To apply all the labels from labels.json to all DLS repositories, do:

```
$ bin/labeler apply_labels pulibrary/figgy,pulibrary/dpul,pulibrary/pulmap,pulibrary/pulfalight,pulibrary/lae-blacklight
```

### Delete a label from many repositories
Example: To delete the label 'silly-ideas' from all the DLS repositories, do:

```
$ bin/labeler delete_label pulibrary/figgy,pulibrary/dpul,pulibrary/pulmap,pulibrary/pulfalight,pulibrary/lae-blacklight silly-ideas
```

## Updating the labels configuration

Labels have a color and a name. In this repository, labels are defined as
belonging to some category. Labels in the same category have the same color.
This helps us quickly recognize that type of label we're looking at even before
we read its name. Categories, their labels, and their colors are defined and
maintained in [labels.json](labels.json)

Labels should be lower case and use dashes, not underscores.

## Reference
* Code uses the [Octokit Client](https://octokit.github.io/octokit.rb/Octokit/Client/Labels.html)
* Styleguide originated from the [Drupal labels style guide](https://github.com/pulibrary/pul_library_drupal/wiki/Issues-Label-Style-Guide)

