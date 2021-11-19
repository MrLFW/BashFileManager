#include <dirent.h>
#include <stdio.h>
#include <string.h>

#define _DIR 1
#define _FILE 2
#define MAX_NUM 100
#define NAME_LENGTH 100

const char* slash ="/";                                           //this is just a constant character 'variable' to support the make_path function
void make_path(char result[], char path[], char fname[])          //we only call this once from in the code, but it looks tidier to have it as a separate function, even though the program will run very slightly slower as a result.
{
                  strcpy(result, path);                           //put the existing path in our output (e.g. ./here)
                  strcat(result, slash);                          //pop a slash on the end (now ./here/)
                  strcat(result, fname);                          //and then put the filename (actually a directory name) on the end (e.g. ./here/subfolder1)

}
int list_file_type(char type, char result[MAX_NUM][NAME_LENGTH],int index, char path[])     //Still asking for the type to look for, and returning the result in an array.  Index and path are used to keep track of where we are, and where to store the output
{
  DIR *d;                                                         //same comments as in the single layer version, above
  struct dirent *dir_entry;
  d = opendir(path);
  if (d)
  {
    while ((dir_entry = readdir(d)) != NULL) {
          if (type == _DIR && dir_entry->d_type == DT_DIR)
          {
                if (dir_entry->d_name[0] != '.')                  //We DO NOT want to look in "." (infinite recursion) or ".." (looking up the tree, instead of down, will search entire file system!)
                {
                  char temp[NAME_LENGTH];                        //If we have deeply nested folders, or long names, this will come back to bite us
                  make_path(temp, path, dir_entry->d_name);      //call the helper function we defined above
                  strcpy(result[index++],temp);                  //put the name, with the path, in to the results array
                  index=list_file_type(_DIR, result, index, temp);  //look at the subfolder we found, putting the results in our array, and - critically - not forgetting to update the index
                }
          }
          if (type == _FILE && dir_entry->d_type == DT_REG)         //this is just the same as for the 'flat' version - just reports on the files in this folder
          {
                strcpy(result[index++],dir_entry->d_name);
          }
    }
    closedir(d);
  }
  return(index);
}

int main(void)
{
  char typ=_DIR;
  char result_list[MAX_NUM][NAME_LENGTH];
  int num_found;
  printf("Directories\n");
  num_found= list_file_type(typ, result_list, 0, ".");              //basically the same as the way we called it before, but we have to say to record the results at the beginning of the results array, and to look in the current folder ".".
  for (int i=0;i<num_found;i++)
    printf("%s\n",result_list[i]);

  printf("\nFiles\n");
  typ=_FILE;
  num_found= list_file_type(typ, result_list, 0, ".");
  for (int i=0;i<num_found;i++)
    printf("%s\n",result_list[i]);
}