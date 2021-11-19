#include <stdio.h>

int main (void)
{
    char menu_option;
    int difficulty;

    printf("------------------------------------------\n\n");

    do{
    printf("Main Menu\n");
    printf("a. Learn about how to use program.\n");
    printf("b. Enter your initials (3 individual letters).\n");
    printf("c. Difficulty Selection.\n");
    printf("d. Start a new sequence of problems.\n");
    printf("e. Save and quit.\n");
    printf(" Please enter an option from the main menu: ");
    scanf("%c",&menu_option);

    switch(menu_option){

    case 'a':
        break;
    case 'b':
        break;
    case'c':
        printf("case c");
        break;
    case'd':
        break;
    case'e':
        break;
    default:
        printf("invalid input");
            break;
    }

    }while(menu_option !='e');

    }