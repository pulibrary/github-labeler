# DLS GitHub Labeler

This project contains a script that can delete and create labels for github
repositories. We run the label creation command on any new DLS github
repository. This gives us consistency between our project repositories.

## Running this code
### Setup

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

### Run

To allow this tool to fetch the github token from lastpass, you have to log in
to lastpass each time you want to use it.

```
$ lpass login <email@email.com>
```

Create labels in one repository: to apply all the labels from labels.json to a single DLS repository, do, e.g.:

```
$ bin/labeler apply_labels pulibrary/dpul-collections
```

Create labels in many repositories: to apply all the labels from labels.json to all DLS repositories, do, e.g.:

```
$ bin/labeler apply_labels pulibrary/figgy,pulibrary/dpul,pulibrary/pulmap,pulibrary/pulfalight,pulibrary/lae-blacklight
```

To delete a label from all of the DLS repositories, do:

```
$ bin/labeler delete_label pulibrary/figgy,pulibrary/dpul,pulibrary/pulmap,pulibrary/pulfalight,pulibrary/lae-blacklight [label]
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

