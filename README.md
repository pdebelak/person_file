# Person File

This program reads and writes information about people to files. It has a command line interface and a web api.

## Usage

1. `git clone` this repository and run `bundle install`
2. run `./bin/parse_person_file create a_filename more_filenames` passing in some files with person data. 

It expects a record with last name, first name, gender, favorite color, and birthday fields separated by a space, a pipe (`|`) or commas. The date should be in month/day/year format.

Now that the dataset has been created, you can interact with it.

## Command Line

* `./bin/parse_person_file sort_by_gender` returns the records sorted by gender, then last name
* `./bin/parse_person_file sort_by_birthday` returns the records sorted by birthday
* `./bin/parse_person_file sort_by_last_name_descending` returns the records... you get the idea

## Web API

* `POST`ing to `/records` creates a new record. You can use any of the delimiters mentioned previously.
* `GET`ing `/records/gender` returns the records sorted by gender as an array of `JSON` objects
* `GET` `/records/birthdate` sorts by birthday, also as `JSON`
* `GET` `/records/name` returns the records sorted by last name, descending, also as `JSON`

## Dependencies

The [grape gem](https://github.com/intridea/grape) is used for the api.