        clear
        echo "--------------------------------------------"
        echo "a. Create a new folder"
        echo "b. Create a new file"
        echo "c. Move a file in the current directory"
        echo "d. Change the current directory"
        echo "e. initialise git repo"
        echo "0. Quit."
        echo " Please enter an option from the main menu: "

pwd
echo "Target file path of new folder/file: "
read filepath
cd filepath
echo "New folder name: "
read newfolder
mkdir newfolder

