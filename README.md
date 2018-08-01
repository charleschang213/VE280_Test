# VE280_Test
+ Zhang Yichi
+ 2018.8.1

The repository contains some simple tests (scripts/cases) for Project 3,4,5 in VE280 course in UMJI, based on some simple usage of bash script and python.  
I originally intended to place this repository only on my ECS, so there will be no instructions on embedding these things on other servers. And because of my lack of knowledge in this realm, the service on my server are now open for some specific people.  
However you can still use the test case input files and the output files from some of the users as a reference to test your code. 

## Features  
1. Able to test whether your code can be successfully compiled.  
2. Able to compare the result of your code and others'
3. In Project 5 test, the test for memory leakage is introduced.  
4. In Project 4 and 5, the stat of your submission and compare records can be queried.  
5. In Project 4 and 5, your output files can be downloaded.

## Usage  
There are some who are registered for my server, but the number is very limited. So here the instruction on online/offline using will all be given.

### Online Using
1. To submit your code for Project x, go to directory Test_scripts/px and find test_px.sh. Compress the required files in px.tar and put it in the same directory with test_px.sh, then type in the command line:  
> ./test_px.sh \<your-user-name\>
2. To submit your code and compare the result with others, do almost the same thing as the previous but type the command as the line below, and it will get you a file with the differences between your code and others'.  
> ./test_px.sh \<your-user-name\> \<other-user-name\>  
3. To download all your output files, use the fetch.sh in the same directory.  
> ./fetch.sh \<your-user-name\>
4. To see the stats about your submissions and comparions, use the stat.sh in the same directory.  
> ./stat.sh \<your-user-name\>

### Offline Using
You can go to px/cases to find all test cases input files for Project x. You can call someone else to use the same input and compare your outputs or you can compile the outputs with the generated outputs of the users px/answers  

## Known Bugs  
1. For online users, the necessary requirement of comparing with another one is that "another one" must have submitted the code. But my scripts cannot check that.  
2. Originally I intended to avoid the risk of crushing when  multiple people run the scripts together, and I want to make it with "brute force". At the beginning of every single test, a **lock file** will be created, and this file will be removed when the test is over. Any other tests cannot start when the file exists. This might make the test transactions serialized, but if a certain test was broken by some unpredictable factors halfways, the lock file will not be deleted, thus no other tests can be run.  
3. The mechanism cannot block some dramatic things such as endless loop. Maybe a mechanism of clocking should be introduced. To avoid its influence on the space of the server, a mechanism of deleting the abnormally large files has already be introduced in Project 5.

## Other Things that can be Improved  
+ More transactions such as freely changing password for users should be introduced.
+ A more friendly UI can be made.  
+ Now the scripts blend the scp and ssh command to access the server, which might cause the users to input their password for many times. (ssh key pair method is temporarily not introduced because it is not so friendly for all users)

## Contact  
My email: <a href=mailto:charleschang213@sjtu.edu.cn> charleschang213@sjtu.edu.cn</a>