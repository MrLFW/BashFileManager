#!/bin/bash
create_folder() {
    read -p "New folder name: " new_folder_name
    mkdir $new_folder_name
    #presence check not needed as already built into mkdir
}
create_file() {
    read -p "New file name + file extension: " new_file_name
    read -p "Would you like to edit your file now? Enter y/n: " y_n
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
move_feature() {
    read -p "Would you like to move a folder by it's tag? Enter y/n: " tag_bool
    if [ $tag_bool == "y" ]; then
        read -p "What tag would you like to move: " target_tag
        read -p "Where would you like to move it: " destination_tag
        #to get filepath use ${line%%;*}
        #to get tag use ${line##*;}
        while IFS= read -r line; do
            if [[ ${line##*;} == $target_tag ]]; then
                target_feature=${line%%;*} #finds the filepath of the target tag
            fi
            if [[ ${line##*;} == $destination_tag ]]; then
                destination_feature=${line%%;*} #finds the filepath of the destination tag
            fi
        done <$startingd/tags.txt
    else
        read -p "What feature would you like to move?: " target_feature
        read -p "Where would you like to move it?: " destination_feature
    fi
    mv $target_feature $destination_feature
    if [ $? -eq 0 ]; then #checks if move was completed successfully
        echo "Moved $target_feature to $destination_feature"
        if [ $tag_bool == "y" ]; then
            sed -i '' "/$target_tag/d" $startingd/tags.txt
            new_dir="$destination_feature/${target_feature##*/}"
            echo "$new_dir;$target_tag" >>$startingd/tags.txt #if successfully moved, this updates the directory of the tag in tags.txt
        fi
    else
        echo "Could not move. Aborting"
    fi
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
    git push --set-upstream origin master #this creates the remote repo on csgitlab
}
add_tag() {
    if [ -f ".pm_tag" ]; then #checks if already tagged
        echo "This folder is already tagged. Aborting"
        echo "Current tag: "
        cat .pm_tag
    else
        while true; do
            read -p "What would you like to tag this folder with: " tag
            if [[ ! "$tag" == *";"* ]]; then             #tag is invalid if it contains a ;
                echo $tag >.pm_tag                       #creates tag with user input inside
                echo "$(pwd);$tag" >>$startingd/tags.txt #adds to database of all tags and locations
                break
            else
                echo "Invalid tag. ; is not allowed."
            fi
        done
    fi
}
find_tag() {
    read -p "What tag would you like to find: " target_tag
    while IFS= read -r line; do #reads each line of tag database and tries to find match
        if [[ ${line##*;} == $target_tag ]]; then
            echo "Filepath of $target_tag folder:"
            tput setaf 2
            echo ${line%%;*}
            tput sgr0
        else
            echo No tag found
        fi
    done <$startingd/tags.txt
}
rename_feature() {
    read -p "Enter the filepath of the feature you would like to rename: " original_path
    read -p "Enter the new filepath and name " new_feature_name
    if [ -f "$new_feature_name" ] || [ -d "$new_feature_name" ]; then #file presence check
        echo "$new_feature_name already exists. Aborting"
    else
        mv $original_path $new_feature_name
    fi
}
edit_workload_data() {
    if [ -f ".pm_wle" ]; then #checks if workload estimate already exists
        hours=$(cat .pm_wle)
        echo "Current workload estimate: $hours hour(s) till completion"
    fi
    read -p "Enter workload estimate for this folder in hours: " hours
    echo $hours >.pm_wle #creates workload estimate
    echo "Workload estimate created"
}
view_workload_data() {
    if [ ! -f ".pm_wle" ]; then #checks if workload estimate already exists
        echo "There is no workload estimate for this folder"
    else
        hours=$(cat .pm_wle)
        echo "Current folder workload estimate: $hours hour(s) till completion"
    fi
    subhour=0
    dir=$(find $(pwd) -path '*/.pm_wle' -type f)
    a=($(dirname $dir | tr ',' '\n'))
    for element in "${a[@]}"; do
        cd $element
        temph=$(cat .pm_wle)
        subhour=$(($subhour + $temph))
    done
    echo "Total workload estimate including subtrees is $subhour hour(s)"
}
output_tree_diagram() {
    if [ -f "paths.txt" ]; then #file presence check
        rm paths.txt
    fi
    if [ -f "output.txt" ]; then #file presence check
        rm output.txt
    fi
    if [ -f "output.svg" ]; then #file presence check
        rm output.svg
    fi

    temp_tree_paths=$(find $(pwd) -not -path '*/\.*') #this part finds all files and folders and puts the paths into a text file
    for element in "${temp_tree_paths[@]}"; do
        echo "$element" >>paths.txt
    done
    echo "@startwbs" >>output.txt
    line=$(head -n 1 paths.txt)
    starting_depth=$(awk -F"/" '{print NF-1}' <<<"${line}")
    ((starting_depth -= 1))
    while IFS= read -r line; do
        depth=$(awk -F"/" '{print NF-1}' <<<"${line}")
        star_count=$(($depth - $starting_depth))
        for i in $(seq $star_count); do echo -n "*" >>output.txt; done
        echo -n " " >>output.txt
        end_of_line=$(basename $line | tr '\n' ' ')
        echo "$end_of_line" >>output.txt
    done <paths.txt
    echo "@endwbs" >>output.txt
    java -jar $plantuml_path output.txt -svg
    # java -jar /Applications/plantuml.jar output.txt -svg
    rm paths.txt
    rm output.txt
}

if [ ! -f "tags.txt" ]; then #file presence check
    echo "" >tags.txt        #creates new empty file with only "" inside
fi
echo "Enter filepath (including plantuml.jar) of plantuml.jar to enable tree diagrams to be outputted"
echo "Current filepath: $plantuml_path"
read -p "Filepath: " plantuml_path
startingd=$(pwd)
while :; do
    clear
    echo "The current working directory is: "
    tput setaf 2
    pwd
    tput sgr0
    echo ""
    echo "1) Create a new folder"
    echo "2) Create a new file"
    echo "3) Move a folder or file"
    echo "a) Rename a folder or file"
    echo "4) Change the current directory"
    echo "5) Initialise git repo"
    echo "6) Tag the current directory"
    echo "7) Search for a tag"
    echo "b) Edit or view workload estimate for current directory"
    echo "8) Output tree diagram"
    echo "c) Re-enter plantuml.jar filepath"
    echo "9) Quit"
    read -p "Please enter your choice: " opt
    case $opt in
    1)
        create_folder
        ;;
    a)
        rename_feature
        ;;
    2)
        create_file
        ;;
    3)
        move_feature
        ;;
    4)
        change_directory
        ;;
    5)
        git_init
        ;;
    6)
        add_tag
        ;;
    7)
        find_tag
        ;;
    8)
        output_tree_diagram
        ;;
    b)
        view_workload_data
        ;;
    c)
        echo "Enter filepath (including plantuml.jar) of plantuml.jar to enable tree diagrams to be outputted"
        read -p "Filepath: " plantuml_path
        ;;
    9)
        break
        ;;
    *) echo "invalid option $REPLY" ;;
    esac
    read -p "Press enter to continue" null
done
