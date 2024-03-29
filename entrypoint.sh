#!/bin/bash -l

cd "${GITHUB_WORKSPACE}" || exit 1

git config --global --add safe.directory "${GITHUB_WORKSPACE}"

TOKEN="${INPUT_TOKEN}"
[ -z "${TOKEN}" ] && { echo "Error: Missing token"; exit 2; }

OWNER="${INPUT_OWNER:-$GITHUB_REPOSITORY_OWNER}"
[ -z "${OWNER}" ] && { echo "Error: no owner set"; exit 2; }

WORKING_DIRECTORY="${INPUT_WORKING_DIRECTORY:-.}"

function setup_credentials_file() {
  echo "Setting up access to RubyGems"
  mkdir -p ~/.gem
  touch ~/.gem/credentials
  chmod 600 ~/.gem/credentials
}

function auth_github() {
  echo "Logging in to GitHub Package Registry"
  echo ":github: Bearer ${1}" > ~/.gem/credentials
}

function build_and_push() {
  cd "${1}" || exit 1
  echo "Building gem"
  find . -name '*.gemspec' -maxdepth 1 -exec gem build {} \;
  echo "Pushing gem to GitHub Package Registry"
  find . -name '*.gem' -maxdepth 1 -exec gem push --key "${2}" --host "https://rubygems.pkg.github.com/${3}" {} \;
}

setup_credentials_file
auth_github "${TOKEN}"
build_and_push "${WORKING_DIRECTORY}" "github" "${OWNER}"
