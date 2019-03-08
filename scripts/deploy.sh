#!/usr/bin/env bash

# exit when any command fails
set -e

owner="ons"
giturl="git.algpoc.com/git"

while getopts "a:k:v:o:u:" option; do
    case "${option}" in
    a) algorithm=${OPTARG};;
    u) username=${OPTARG};;
    p) password=${OPTARG};;
    o) owner=${OPTARG};;
    g) giturl=${OPTARG};;
    *) echo "script usage: $(basename $0) [-a algorithm] [-u username] [-p password] [-o owner] [-u Algorithmia git api url]" >&2
       exit 1;;
    esac
done

echo "Deploying algorithm '${algorithm}'..."
echo

echo "Checking out Github master branch"
git checkout master

echo "Adding remote to Algorithmia Git repository"
git remote add algo https://${username}:${password}@${giturl}/${owner}/${algorithm}.git

echo "Pulling Algorithmia master branch"
git pull algo master

echo "Pushing changes to Algorithmia master branch"
git push algo master

echo
echo