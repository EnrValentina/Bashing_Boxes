#!/bin/bash

# The things in the array are in one box
boxes=("Key" "Rolling Pin" "Notebook" "Birdhouse" "Dishwasher" "Toothbrush" "Chalkboard" "Shoelaces" "Colander" "Shopping Bag")

# Loop through every item in the array and print them
for item in "${boxes[@]}"; do
    echo "$item"
done

# While loop for interactive menu
while true; do
    echo ""
    echo "-- Bashing Boxes Menu --"
    echo "1) Print list"
    echo "2) Print item at X position in list"
    echo "3) Add item to list"
    echo "4) Remove last item from list"
    echo "5) Remove item from X position"
    echo "6) Exit"
    echo "7) Save current box to a file"
    echo "8) Load a previously saved box"
    read -p "Select an option: " choice

    # Option 1: Print all items
    if [ "$choice" -eq 1 ]; then
        echo "The full list is:"
        for item in "${boxes[@]}"; do
            echo "$item"
        done

    # Option 2: Print item at X position
    elif [ "$choice" -eq 2 ]; then
        read -p "Enter position (1-${#boxes[@]}): " pos
        index=$((pos - 1))
        if [ "$index" -ge 0 ] && [ "$index" -lt "${#boxes[@]}" ]; then
            echo "Item #$pos: ${boxes[$index]}"
        else
            echo "Invalid position!"
        fi

    # Option 3: Add new item
    elif [ "$choice" -eq 3 ]; then
        read -p "What item would you like to add?: " new_item
        boxes+=("$new_item")
        echo "\"$new_item\" added."

    # Option 4: Remove last item
    elif [ "$choice" -eq 4 ]; then
        unset 'boxes[-1]'
        echo "Last item removed."

    # Option 5: Remove item from X position
    elif [ "$choice" -eq 5 ]; then
        read -p "Enter position to remove (1-${#boxes[@]}): " pos
        index=$((pos - 1))
        if [ "$index" -ge 0 ] && [ "$index" -lt "${#boxes[@]}" ]; then
            echo "Removing ${boxes[$index]}..."
            unset "boxes[$index]"
            boxes=("${boxes[@]}") # rebuild array to remove empty slot
        else
            echo "Invalid position!"
        fi

    # Option 6: Exit
    elif [ "$choice" -eq 6 ]; then
        echo "Bye!"
        break

    # Option 7: Save current box
    elif [ "$choice" -eq 7 ]; then
        if [ ! -d "data" ]; then
            mkdir data
            echo "Created data/ directory."
        fi
        read -p "Enter name for saved box: " name_of_file
        declare -p boxes > "data/${name_of_file}.sh"
        echo "Box saved as data/${name_of_file}.sh"

    # Option 8: Load saved box
    elif [ "$choice" -eq 8 ]; then
        if [ ! -d "data" ]; then
            echo "No saved boxes (no data/ folder)"
        else
            echo "Saved Boxes:"
            shopt -s nullglob
            files=(data/*.sh)
            if [ ${#files[@]} -eq 0 ]; then
                echo "No saved boxes yet."
            else
                for file in "${files[@]}"; do
                    echo "- ${file#data/}"
                done
                read -p "Enter name of file to load (without .sh): " load_name
                filepath="data/${load_name}.sh"
                if [ -f "$filepath" ]; then
                    source "$filepath"
                    echo "Box '$load_name' loaded."
                else
                    echo "Error: file not found."
                fi
            fi
        fi

    

done

exit 0
