create_folder() {
    read -p "New folder name: " new_folder_name
    mkdir $new_folder_name
    #presence check not needed as already built into mkdir
}
create_file() {
    read -p "New file name + file extension: " new_file_name
    read -p "Would you like to edit your file now? Y/N: " y_n

    if [ -f "$new_file_name" ]; then #file presence check
        echo "$new_file_name already exists. Aborting"
    else
        if [[ $y_n == "y" ]]; then
            cat >$new_file_name #opens cat editor if user inputs "y"
        else
            echo "" >$new_file_name #creates new empty file with only "" inside
        fi
    fi
}
move_file() {
    read -p "What file would you like to move?: " target_file
    read -p "Where would you like to move it?: " destination
}
change_directory() {
    read -p "Enter new directory: " new_directory
    cd $new_directory
    echo "New working directory is"
    pwd
}
git_init() {
    read -p "Enter a name for your git repo: " repo_name
    git init $repo_name
    cd $repo_name
    read -p "Have you already configured your git account? Enter y/n: " git_config_bool
    if [ $git_config_bool == "n" ]; then
        read -p "Enter your email: " email
        git config --local user.email “$email” #using --local instead of --global for the sake of this project, need to keep my credentials how they are to access remote.
        read -p "Enter your username: " name
        git config --local user.name “$name” #using --local instead of --global for the sake of this project, need to keep my credentials how they are to access remote.
    fi
    url="https://csgitlab.reading.ac.uk/$name/$repo_name.git"
    git remote add origin $url
    echo "" >readme.md
    git add readme.md
    git commit -m "Project created"
    git push --set-upstream origin master
}

# output_tree_diagram(){
#     requires tree walk
#     exclude folders that start with a '.'
#     use plantuml
#     could implement from scratch (much harder but more marks)
# }

while :; do
    clear
    echo "---------------------------------\n"
    echo "The current working directory is:\n"
    tput setaf 2
    pwd
    tput sgr0
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
    read -p "Press enter to continue" null
done
