
newFolder() 
{
        pwd
        echo "Target file path of new folder/file: "
        read filepath
        cd filepath
        echo "New folder name: "
        read newfolder
        mkdir newfolder
}

clear
echo "---------------------------------\n"
echo "The current working directory is:\n"
pwd
echo "\n"
PS3='Please enter your choice: '
options=("Create a new folder" "Create a new file" "Move a file in the current directory" "Change the current directory" "Quit")
select opt in "${options[@]}"; do
        case $opt in
        "Create a new folder")
                newFolder
                ;;
        "Create a new file")
                echo "you chose choice 2"
                ;;
        "Move a file in the current directory")
                echo "you chose choice $REPLY which is $opt"
                ;;
        "Change the current directory")
                ;;
        "Initialise git repo") 
                ;;
        "Quit")
                break
                ;;
        *) echo "invalid option $REPLY" ;;
        esac
done
