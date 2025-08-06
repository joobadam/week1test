#!/bin/bash

PACKAGE_FILE="packages.txt"
touch "$PACKAGE_FILE"
read -rp "Enter the package name: " PACKAGE
PACKAGE=$(echo "$PACKAGE" | xargs)


if [[ -z "$PACKAGE" ]]; then
  echo "Error: Package name cannot be empty."
  exit 1
fi

if grep -Fxq "$PACKAGE" "$PACKAGE_FILE"; then
  grep -Fxv "$PACKAGE" "$PACKAGE_FILE" > "${PACKAGE_FILE}.tmp" && mv "${PACKAGE_FILE}.tmp" "$PACKAGE_FILE"
  echo "Package '$PACKAGE' has been removed from the list."
else
  echo "$PACKAGE" >> "$PACKAGE_FILE"
  echo "Package '$PACKAGE' has been added to the list."
fi