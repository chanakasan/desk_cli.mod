main() {
    local desk_dir="$HOME/.desk"
    local all_file="$desk_dir/_all"

    # Create _all file if it doesn't exist
    touch "$all_file" || {
        echo "Error: Unable to create file $all_file"
        return 1
    }

    # Clear the existing content of _all file
    > "$all_file"

    # Loop through each file in ~/.desk
    for file_path in "$desk_dir"/*; do
        if [ -f "$file_path" ] && [[ "$(basename "$file_path")" != _* ]]; then
            # Read content of file and trim trailing whitespaces
            content=$(<"$file_path")
            content=$(echo -n "$content" | sed 's/[[:space:]]*$//')
            # Append content to _all file
            echo "$content" >> "$all_file"
        fi
    done
}

main