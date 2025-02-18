# Coursework 2 - a project manager tool

Using the file system as the main datastore, this tool helps manage work breakdown methodology,
milestones and time management.

The core elements will be strongly guided, and completion of them equates to approximately 40% of the marks.
Beyond that, students should  problem solve, in a graded hierarchy of difficulty and completion to achieve
higher marks.

__It is unrealistic to expect to meet all the feature criteria listed__

Part of the task therefore involves deciding which elements to implement in order to maximise your mark.

Some of the features may be best implemented using shell (bash or zsh) scripting, or could be done directly in C.

Tests will be provided for 1...10, which will also define the command line arguments required (including the sub-command name
for the features, where appropriate e.g. pm feature feature_name or pm feature move new_feature_name ).

Coursework submission will include creating project documentation (using doxygen) so code _**must**_ be well commented.  Any shell scripts or make files included in the solution _**must**_ be included in the documentation.  The submission itself _**must**_ be the URL of the CSGitLab repository used.

## Core functionality:

### Must (up to 10% for each top level feature)
4.  Feature management
    3. _**Should**_ include setting up git branch as appropriate

### Should (up to 10% for each top level feature)

9. Time/workload added to output diagram
    1. _**Could**_ also produce Gantt chart (using plantuml)

### Could (up to 10% for each top level feature)

10. Output diagram includes links (when used in browser, for example)
    1. _**Should**_ use plantuml to do this
11. Dependencies information across tree branches
    1. _**Must**_ identify relevant other paths in tree to do this


### Elite challenges ("Won't do" in MoSCoW terms) (up to 20% for each top level feature)

12. Guided work breakdown wizard (Slightly advanced, would require interactive questions/answer handling)
    1. Needs a number of sub-features, such as minimum time allocation threshold, user input parsing 
13. Multi-user (Advanced, would require some form of permissions model)
    1. may be best done using a traditional SQL database, but can use flat files.  Complex task.
14. Available as web application (Advanced, probably easiest creating a simple embedded server)
    1. sample code for simple communications between applications will be covered
15. GOAP recommendation of suitable pathway (Advanced, can use existing GOAP library, however)
    1. GOAP uses a 'heap' data structure