#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    char menu_option;
    char filepath[50];

    printf("------------------------------------------\n\n");

    do
    {
        printf("Main Menu\n");
        printf("1. Create a new folder\n");
        printf("2. Create a new file\n");
        printf("3. initialise git repo\n");
        printf("0. Quit.\n");
        printf(" Please enter an option from the main menu: ");

        // loop menu
        // each time an action is complete the main menu will show again
        // have the option to do the function to the current working directory
        // or you can enter a file path

        scanf("%c", &menu_option);

        switch (menu_option)
        {

        case 'a':
                    int status = system("./newfolder.zsh");
        case 'b':
            break;
        case 'c':
            printf("case c");
            break;
        case 'd':
            break;
        case '0':
            _Exit(0);
        default:
            printf("invalid input");
            break;
        }

    } while (menu_option != '0');

}

// void newfolder(void){
// int status = system("newfolder.zsh");
// };