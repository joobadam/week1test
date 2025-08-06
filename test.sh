#!/bin/bash


while true; do
    echo "What should I do?"
    read -r user_input

    if [[ "$user_input" == "exit" ]]; then
        exit 0
    fi

    if [[ "$user_input" == "create shell" ]]; then
        echo "Provide a name:"
        read -r script_name
        ./scripts/create_new_shell_script.sh "$script_name"
    fi
done