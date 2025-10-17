#!/bin/bash

#the things in the array are in one box
boxes=("Key" "Rolling Pin" "Notebook" "Birdhouse" "Dishwasher" "Toothbrush" "Chalkboard" "Shoelaces" "Colander" "Shopping Bag") 

#looping thru every array and printing the items
for item in "${boxes[@]}"; do
    echo "$item"
done

#while loop so wwe can pick what to do from a menu
while true; do
    echo ""
    echo "-- Bashing Boxes Menu --"
    echo "1) Print list"
    echo "2) Print item at X position in list"
    echo "3) Add item to list"
    echo "4) Remove last item from list"
    echo "5) Remove item- from X position"
    echo "6) Exit"
    read -p "Select an option: " choice

    if [ "$choice" -eq 1 ]; then
        for item in "${boxes[@]}"; do
            echo "$item"
        done
    elif [ "$choice" -eq 2 ]; then
        echo "Bye!"
        break
    else
        echo "Invalid choice"
    fi
done
