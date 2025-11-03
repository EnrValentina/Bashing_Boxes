#!/bin/bash

#the things in the array are in one box
boxes=("Key" "Rolling Pin" "Notebook" "Birdhouse" "Dishwasher" "Toothbrush" "Chalkboard" "Shoelaces" "Colander" "Shopping Bag") 

#looping thru every array and printing the items
for item in "${boxes[@]}"; do
    echo "$item"
done

#while loop so we can pick what to do from a menu
while true; do
    echo ""
    echo "-- Bashing Boxes Menu --"
    echo "1) Print list"
    echo "2) Print item at X position in list"
    echo "3) Add item to list"
    echo "4) Remove last item from list"
    echo "5) Remove item- from X position"
    echo "6) Exit"
    echo "7) Saving current box to a file"
    echo "8) Loading a previously saved box"
    echo "9) Listing existing saved boxes"
    echo "10) Deleting a saved box"
    read -p "Select an option: " choice

#option to print out the whole list of arrays
    if [ "$choice" -eq 1 ]; then
        echo "The full list is:"
        for item in "${boxes[@]}"; do
            echo "$item"
        done

#option to print an item at X position in the list
    elif [ "$choice" -eq 2 ]; then
        read -p "Enter position (1-${#boxes[@]}): " pos
        index=$((pos - 1))
        if [ "$index" -ge 0 ] && [ "$index" -lt "${#boxes[@]}" ]; then
            echo "Item #$pos: ${boxes[$index]}"
        else
            echo "Invalid position!"
        fi
#option to add an item to the list
    elif [ "$choice" -eq 3 ]; then
        read -p "What item would you like to add?: " new_item
        boxes+=("$new_item")
        echo "\"$new_item\" added."

#option to remove last item to the list
    elif [ "$choice" -eq 4 ]; then
        unset 'boxes[-1]'
        echo "Last item removed"


#option to remove item- from X position
    elif [ "$choice" -eq 5 ]; then
        read -p "Enter position to remove (1-${#boxes[@]}): " pos
        index=$((pos - 1))
        if [ "$index" -ge 0 ] && [ "$index" -lt "${#boxes[@]}" ]; then
            echo "Removing ${boxes[$index]}..."
            unset "boxes[$index]"
            boxes=("${boxes[@]}") #rebuild array
        else
            echo "Invalid position!"
        fi

#option to exit the list and the menu
    elif [ "$choice" -eq 6 ]; then
        echo "Bye!"
        break
    

#saved boxes options


#option to save current box to a file
    elif [ "$choice" -eq 7 ]; then
        if [ ! -d "data" ]; then
            mkdir data
            echo "Created data/ directory."
        fi

        read -p "Enter name for saved box: " name_of_file
        declare -p boxes > "data/${name_of_file}.sh"
        echo "Box saved as data/${name_of_file}.sh"

    fi

#option to load a previously saved box
    elif [ "$choice" -eq 8 ]; then
    if [ ! -d "data" ]; then
        echo "No saved boxes (no data/ folder)"
    else
        echo "Saved Boxes:"
        shopt -s nullglob #makes sure the files array is empty instead of containing a literal data/*.sh if there are no .sh files
        files=(data/*.sh)
        if [ ${#files[@]} -eq 0 ]; then
            echo "No saved boxes yet"
        else
            #list saved
            for file in "${files[@]}"; do
                echo "- ${file#data/}"
            done

            #ask which to load
            read -p "Enter name of file you want to see (wo .sh)" load_name
            filepath="data/${load_name}.sh"
            #check if real
            if [ -f "$filepath" ]; then
                source "$filepath"
                echo "Box '$load_name' loaded"
            else
                echo "Error file not found"
            fi
        fi
    fi
done
exit 0