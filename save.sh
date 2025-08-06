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

current_branch=$(git rev-parse --abbrev-ref HEAD)

if ! git add .; then
  echo "❌ Error: Failed to add files to staging area."
  exit 1
fi

if ! git commit -m "$commit_message"; then
  echo "❌ Error: Commit failed."
  exit 1
fi

if ! git push; then
  echo "⚠️ Warning: Commit was successful, but push failed on branch '$current_branch'."
  exit 1
fi

if [ -n "$2" ]; then
  new_branch="$2"

  if git checkout -b "$new_branch"; then
    echo "🔀 Switched to new branch: $new_branch"
  else
    echo "❌ Error: Could not create new branch '$new_branch'."
    exit 1
  fi

  if ! git push -u origin "$new_branch"; then
    echo "⚠️ Warning: New branch '$new_branch' created, but push failed."
    exit 1
  fi

  echo "✅ New branch '$new_branch' successfully created and pushed."
fi

echo "✅ Changes saved and pushed on branch '$current_branch'."