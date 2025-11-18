#!/bin/bash 

my_array_of_things=("Key" "Rolling Pin" "Notebook" "Birdhouse" "Dishwasher" "Toothbrush" "Chalkboard" "Shoelaces" "Colander" "Roblox")

user_input="Error: could not retrieve user selection."

my_array_of_things
green_s="\033[0;32m"
green_e="\033[0m"

format_line(){
	echo "-----------------------------"
}

display_main_menu(){
	clear
	echo -e "
	| My Array of Things
	____________________________
	|
	| 1) Key
	| 2) Rolling Pin
	| 3) Notebook
	| 4) Birdhouse
	| 5) Dishwasher
	| 6) Toothbrush
	| 7) Chalkboard
	| 8) Shoelaces
	| 9) Colander
	| 10) Roblox
	|
	-----------------------------"
	echo -e "
	| Main Menu |
	______________________________________
	|
	| 1) Print all objects
	| 2) Print item at X position in list
	| 3) Add item to list
	| 4) Remove last item from list
	| 5) Remove item from X position
	| 6) Save or Load Boxes Menu
	| 7) Exit app
	|
	--------------------------------------
	"
	get_user_input
	check_main_menu_selection
}

display_save_load_menu(){
	clear
	echo -e "
	| Save & Load Menu |
	___________________________
	|
	| 1) Save current box
	| 2) See all saved boxes
	| 3) Load a Box
	| 4) Go back to main menu
	| 5) Exit app
	|
	---------------------------
	"
	get_user_input
	check_save_menu_selection
}

print_all_items_in_box(){
	echo "Current box contents:"
    echo "${my_array_of_things[@]}"
    echo "$item"
    read -p "Press Enter to go back..."
    display_main_menu
}

print_item_at_x_position(){
	read -p "Enter position number: " pos
	echo "${my_array_of_things[$((pos-1))]}"
	read -p "Press Enter to go back..."
    display_main_menu	
}

my_array_of_things

add_item_to_list(){
	read -p "What item would you like to add?: " new_item
        my_array_of_things+=("$new_item")
        echo "$new_item added."
    read -p "Press Enter to go back..."
    display_main_menu    
}

remove_last_item(){
	unset 'my_array_of_things[${#my_array_of_things[@]}-1]'
    echo "Last item removed."
    read -p "Press Enter to go back..."
    display_main_menu
}

remove_item_from_x_position(){
	read -p "Enter position to remove: " pos
	unset 'my_array_of_things[$((pos-1))]'
	my_array_of_things=("${my_array_of_things[@]}") # reindex
	echo "Item removed."
	read -p "Press Enter to go back..."
    display_main_menu
}

my_array_of_things

save_current_box(){
	mkdir -p data
	echo "Created data /directory"
	read -p "Enter name of file to save: " filename
	declare	-p boxes > "data/${filename}.sh"
	echo "Box saved as data/${filename}.txt"
	read -p "Press Enter to go back..."
    display_save_load_menu
fi
}

load_box_from_data(){
	read -p "Enter file you want to load: " filename
	mapfile -t my_array_of_things < "${filename}.txt" 2>/dev/null
	format_line
	echo -e $green_s"Loaded Box: '${filename}.txt'"$green_e
	format_line
	for item in "${my_array_of_things[@]}"; do
		echo " - $item"
	done
	option_sort_current_box_abc
	read -p "Press Enter to go back..."
	display_save_load_menu
}

option_sort_current_box_abc(){
	read -p "Do you want to sort this box alphabetically? (Y/N): " user_input
	mapfile -t my_array_of_things < <(printf '%s\n' "${my_array_of_things[@]}" | sort)
	echo "${my_array_of_things[@]}"
}

see_all_saved_boxes(){
	clear
	echo -e "
| All Saved Boxes |
____________________________________________________________
		"
		ls *.txt 2>/dev/null || echo "No saved boxes found."
	echo -e "
------------------------------------------------------------
	"
	read -p "Press Enter to go back..."
	display_save_load_menu
}

get_user_input(){
	read -p "Enter selection from Menu: " user_input
}

check_main_menu_selection(){
	case $user_input in
		1) print_all_items_in_box
			;;
		2) print_item_at_x_position
			;;
		3) add_item_to_list
			;;
		4) remove_last_item
			;;
		5) remove_item_from_x_position
			;;
		6) display_save_load_menu
			;;
		7) exit
			;;
		*) display_main_menu
			;;
	esac
}

check_save_menu_selection(){
		case $user_input in
		1) save_current_box
			;;
		2) see_all_saved_boxes
			;;
		3) load_box_from_data
			;;
		4) display_main_menu
			;;
		5) exit
			;;
		*) display_save_load_menu
			;;
	esac
}

check_sort_current_box_abc(){
		case $user_input in
		Y) option_sort_current_box_abc
			;;
		y) option_sort_current_box_abc
			;;
		N) display_save_load_menu
			;;
		n) display_save_load_menu
			;;
	esac
}

display_main_menu