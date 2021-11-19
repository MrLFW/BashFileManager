#include <dirent.h>             //this is the library which has the readdir function, and defines a struct which is used to return the information.
#include <stdio.h>
#include <string.h>

#define _DIR 1                  //this is using a macro definition to provide a constant to let us say whether we want to list directories or files (1 for directories - an arbitrary choice)
#define _FILE 2                 //this is using a macro definition to provide a constant to let us say whether we want to list directories or files (2 for files - an arbitrary choice)
#define MAX_NUM 100             //avoiding using dynamically allocated memory, and thus pointers, by using fixed length arrays - why might this not be the best option?
#define NAME_LENGTH 100

int list_file_type(char type, char result[MAX_NUM][NAME_LENGTH])
{
  DIR *d;                       //we cannot avoid pointers altogether, because the opendir function returns a pointer to the DIR data structure                           
  struct dirent *dir;           //similarly, readdir returns a pointer
  d = opendir(".");             //d can now be used to refer to the directory entry (in this case, it always looks at the current directory, ".")
  int count=0;                  //we want to count how many files or directories we find, and return this value
  if (d)
  {
    while ((dir = readdir(d)) != NULL) {                             //calling the library function - if it runs out of entries, it returns NULL
          if (type == _DIR && dir->d_type == DT_DIR)                 //if we asked for directories (_DIR), then only return the directories we find, and not other files
          {
                strcpy(result[count++],dir->d_name);                 //copy the name of the directory from the data structure in to our results array
          }
          if (type == _FILE && dir->d_type == DT_REG)                //if we asked for files (_FILE), then only return regular files (not directories or symbolic links, etc)
          {
                strcpy(result[count++],dir->d_name);                 //copy the name of the file from the data structure in to our results array
          }
    }
    closedir(d);                                                     //always close resources after you've finished with them
  }
  return(count);                                                     //report back how many we found, so the calling code knows how many to look for in the results
}

int main(void)
{
  char typ=_DIR;                                                     //First, let's report on the directories in the current folder
  char result_list[MAX_NUM][NAME_LENGTH];                            //make some space for the results to go in
  int num_found;                                             
  printf("Directories\n");                                  
  num_found= list_file_type(typ, result_list);                       //call our function, asking for typ (_DIR) and telling it where to put the results
  for (int i=0;i<num_found;i++)
    printf("%s\n",result_list[i]);

  printf("\nFiles\n");
  typ=_FILE;
  num_found= list_file_type(typ, result_list);                       //call our function, asking for typ (_FILE) and telling it where to put the results.  Is overwriting the results array a good idea?
  for (int i=0;i<num_found;i++)
    printf("%s\n",result_list[i]);
}