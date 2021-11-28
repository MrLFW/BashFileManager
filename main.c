#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    char menu_option;
    char filepath[50];
    char buffer[101];

    printf("Enter your name: ");
    // Stores the name into auxiliary memory
    scanf(" %100[^\n]", buffer);
    // Creates a dynamic string
    char *name = (char *)malloc(strlen(buffer) + 1);
    // Sets the value
    strcpy(name, buffer);

    printf("Your name is %s", name);
    // Frees the memory
    free(name);

    printf("------------------------------------------\n\n");

    do
    {
        printf("Selection menu\n");
        printf("\n");
        printf("Current working directory: \n");
        printf("\n");
        printf("a. Create a new folder\n");
        printf("b. Create a new file\n");
        printf("c. initialise git repo\n");
        printf("0. Quit.\n");
        printf(" Please enter an option from the main menu: ");

        // loop menu
        // each time an action is complete the main menu will show again
        // have the option to do the function to the current working directory
        // or you can enter a file path

        scanf("%c", &menu_option);

        if (menu_option = "a")
        {
            int status = system("./newfolder.zsh");
        }
        else if (menu_option = "b")
        {
        }
        else if (menu_option = "c")
        {
        }
        else if (menu_option = "0")
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