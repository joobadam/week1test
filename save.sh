#!/bin/bash


if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "❌ Error: This is not a Git repository."
  exit 1
fi

if [ -z "$1" ]; then
  read -p "Enter commit message: " commit_message
else
  commit_message="$1"
fi

if [ -z "$commit_message" ]; then
  echo "❌ Error: Commit message is required."
  exit 1
fi

if ! git add .; then
  echo "❌ Error: Failed to add files to staging area."
  exit 1
fi

if ! git commit -m "$commit_message"; then
  echo "❌ Error: Commit failed."
  exit 1
fi

if ! git push; then
  echo "⚠️ Warning: Commit was successful, but push failed. Please check your network or remote repository settings."
  exit 1
fi

echo "✅ Changes successfully saved and pushed to remote repository."