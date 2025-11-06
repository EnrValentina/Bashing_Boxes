#!/bin/bash 

my_array_of_things=("Key" "Rolling Pin" "Notebook" "Birdhouse" "Dishwasher" "Toothbrush" "Chalkboard" "Shoelaces" "Colander" "Shopping Bag")

user_input="Error: could not retrieve user selection."

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
	| 10) Shopping Bag
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
	| 2) Load a Box
	| 3) Go back to main menu
	| 4) exit app
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
}

print_item_at_x_position(){
	read -p "Enter position number: " pos
	echo "${my_array_of_things[$((pos-1))]}"
	
}

add_item_to_list(){
	read -p "What item would you like to add?: " new_item
        my_array_of_things+=("$new_item")
        echo "$new_item added."    
}

remove_last_item(){
	unset 'my_array_of_things[${#my_array_of_things[@]}-1]'
    echo "Last item removed."
}

remove_item_from_x_position(){
	read -p "Enter position to remove: " pos
	unset 'my_array_of_things[$((pos-1))]'
	my_array_of_things=("${my_array_of_things[@]}") # reindex
	echo "Item removed."
}

save_current_box(){
	read -p "Enter name of file to save: " filename
	printf "%s\n" "${my_array_of_things[@]}" > "$filename"
	echo "Box saved as $filename"
}

load_box_from_data(){
	read -p "Enter file you want to load: " filename
	mapfile -t my_array_of_things < "$filename" 2>/dev/null
	echo -e "\nBox "$filename" loaded"
	echo "-----------------------------"
	for item in "${my_array_of_things[@]}"; do
		echo " - $item"
	done
	echo "-----------------------------"
}

get_user_input(){
	read -p "Enter selection from Main Menu: " user_input
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
		2) load_box_from_data
			;;
		3) display_main_menu
			;;
		4) exit
			;;
		*) display_save_load_menu
			;;
	esac
}

display_main_menu