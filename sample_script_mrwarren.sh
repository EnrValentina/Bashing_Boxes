#!/bin/bash 

my_array_of_things=("thing1" "thing2" "thing3")

user_input="Error: could not retrieve user selection."

display_main_menu(){
	clear
	echo -e "
	| Main Menu |
	_____________
	|
	| 1) print all objects
	| 2) Print item at X position in list
	| 3)
	| 4)
	| 5)
	| 6)
	| 7) save or load objects
	| 8) exit app
	-------------
	"
	get_user_input
	check_main_menu_selection
}

display_save_load_menu(){
	clear
	echo -e "
	| Save & Load Menu |
	_____________
	|
	| 1) Save current box
	| 2) Load a Box
	| 3) Go back to main menu
	| 4) exit app
	-------------
	"
	get_user_input
	check_save_menu_selection
}

print_all_items_in_box(){
	echo ${my_array_of_things[@]}
}

print_item_at_x_position(){
	:
}

remove_item_at_x_position(){
	:
}

save_current_box(){
	:
}

load_box_from_data(){
	:
}

get_user_input(){
	read -p "Enter selection: " user_input
}

check_main_menu_selection(){
	case $user_input in
		1) print_all_items_in_box
			;;
		2) echo "option two from MAIN menu"
			;;
		3) display_save_load_menu
			;;
		Leave) exit
			;;
		*) display_main_menu
			;;
	esac
}

check_save_menu_selection(){
		case $user_input in
		1) print_all_items_in_box
			;;
		2) echo "the other menus option 2"
			;;
		3) display_main_menu
			;;
		A|a) exit
			;;
		*) display_save_load_menu
			;;
	esac
}


display_main_menu
