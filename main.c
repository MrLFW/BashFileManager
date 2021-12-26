#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    char menu_option = 'z';

    char filepath[50] = "/Users/luke";

    do
    {
        system("clear");
        printf("------------------------------------------\n\n");
        printf("\n");
        printf("Current working directory: %s\n", filepath);
        printf("\n");
        printf("a. Create a new folder\n");
        printf("b. Create a new file\n");
        printf("c. Move a file in the current directory\n");
        printf("d. Change the current directory\n");
        printf("e. initialise git repo\n");
        printf("0. Quit.\n");
        printf(" Please enter an option from the main menu: ");

        scanf("%c", &menu_option);

        switch (menu_option)
        {
        case 'a':
        {
            int status = system("cd '/Users/luke/Documents/Computer Science/Programming in C:C++/coursework2'");
            int status2 = system("pwd");
            printf("%i", status);
        }
        case '0':
            _Exit(0);
        default:
            printf("invalid input\n");
        }

    } while (menu_option != '0');
}

// void newfolder(void){
// int status = system("newfolder.zsh");
// };