create_folder(){
    read -p "New folder name: " new_folder_name
    mkdir $new_folder_name
}
create_file(){
    read -p "New file name + file extension: " new_file_name
    read -p "Would you like to edit your file now? Y/N: " y_n
    if [[ $y_n == "y" ]]
    then
        cat > $new_file_name
    else
        echo "" > $new_file_name
    fi
}
move_file(){
    read -p "What file would you like to move?: " target_file
    read -p "Where would you like to move it?: " destination
}
change_directory(){
    read -p "Enter new directory: " new_directory
    cd $new_directory
    echo "New working directory is"
    pwd
}
git_init(){
    git init
}

while :
do
    clear
    echo "---------------------------------\n"
    echo "The current working directory is:\n"
    tput setaf 2; pwd; tput sgr0
    echo ""
    echo "1) Create a new folder"
    echo "2) Create a new file"
    echo "3) Move a file"
    echo "4) Change the current directory"
    echo "5) Initialise git repo"
    echo "6) Quit"
    read -p "Please enter your choice: " opt
    case $opt in
        1)
            create_folder
        ;;
        2)
            create_file
        ;;
        3)
            move_file
        ;;
        4)
            change_directory
        ;;
        5)
            git_init
        ;;
        6)
            break
        ;;
        *) echo "invalid option $REPLY" ;;
    esac
done