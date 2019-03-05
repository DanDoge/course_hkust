/*Huang Daoji, Student ID: 20623420
 * My solution basically follows the instruction given in the comments.
 * I refer to man page of some system calls.
 *
 * The comments more than one line are in this form:
 *     /*Name Date
 *      * comments
 *      *\/
 * in order not to confuse with the oringinal comments provided.
 *
 * Here，I use Foo() as the secure version of system call foo()
 * e.g. Close() is the secure version of close()
 * This naming style is inspired by CMU's course 15213(Intro. to OS)
 *
 * Coding style refered to Linux kernel coding style.
 *
 * Progress:
 *     27/02: read all files
 *     28/02: all tasks finished, tested
 *     28/02: comments added
 *     06/03: secure version of system call implemented
 * To do list:
 *     [x] read the helper functions
 *     [x] finish all tasks
 *     [x] run tests
 *     [x] comments and documentation
 *     [x] check the return value(if any) of all system calls
 *     [ ] test again
 *     [ ] format and beauty
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>
#include <wait.h>
#include <stdio.h>
#include <string.h>

// header file added, for the exit() function
#include <stdlib.h>

#include <expression.h>
#include <fd.h>

#define MAIN_BUF_LEN 1024

/* uncomment the next line when testing */
// #define DEBUG

/* Start of declaration of secure version of system calls
 * Implementations are at the end
 * ALl parameters and their names are consistant with their man page
 */
void Close(int fd);
pid_t Getpid(void);
ssize_t Write(int fd, const void* buf, size_t count);
int Open(const char* pathname, int flags, mode_t mode);
int Pipe(int pipefd[2]);
pid_t Fork(void);
pid_t Waitpid(pid_t pid, int* iptr, int options);
/* End of declaration */

void print_help()
{
    printf(
        "Usage: multical.out [infile] [outfile] [proc]\n"
        "\n"
        "infile:    input file path\n"
        "outfile:   output file path\n"
        "proc:      Number of child process to spawn\n");
}

// You can modify child_work parameters as you need
int child_work(int pipes[][2], int proc, int procid, int outfd)
{
    // Declare your variables here
    int i;
    pid_t mypid;
    Expression exp;
    float result;
    char buf[MAIN_BUF_LEN];

    // TASK 9 Close all other pipes (10 pts)
    //
    // The child only uses one reading end, the matching one the parent will use
    // to communicate with this child. Close all other reading ends of pipes
    // that is not used by this child.
    //
    // You don't need to close pipes here if it is already done in main.

    /*Huang Daoji 28/02
     * close all the reading ends except for its own, and all writing ends
     * after this block, only pipe[i][0], infile, outfile needs to handle
     */
    for (i = 0; i < proc; ++i)
    {
        Close(pipes[i][1]);
        if(i != procid){
            Close(pipes[i][0]);
        }
    }
    // ---------- END TASK 9 ----------

    // TASK 10 Get child pid to mypid (5 pts)
    mypid = Getpid();
    // ---------- END TASK 10 ----------

    // TASK 11 Child read pipe and calculate the expression and output (20 pts)
    //
    // Read from the pipe.
    // Calculate the expression and write to outfile for each expression.
    // Stop when EOF is reached, i.e. parent closed the pipe and read() returns
    // 0.


    /*Huang Daoji 28/02
     * using helper function exp_readln, and exp_cal
     * prepare the answer in buffer first, then write to the outfile
     * notice the "strlen(buf) + 1" part, which includes the final '\n'
     * close the last pipe here
     */

    while(read(pipes[procid][0], buf, sizeof(buf))){
        exp_readln(&exp, buf);
        sprintf(buf, "#%d %d %.3f\n", procid, mypid, exp_cal(&exp));
        Write(outfd, buf, strlen(buf) + 1);
    }
    Close(pipes[procid][0]);

    // ---------- END TASK 11 ----------

    return 0;
}

int main(int argc, char **argv)
{
    if (argc != 4)
    {
        print_help();
        return 0;
    }

    const char *infile;  // Name of infile
    const char *outfile; // Name of outfile
    int proc;            // Number of child process to fork

    // Save arguments to variables
    infile = argv[1];
    outfile = argv[2];
    sscanf(argv[3], "%u", &proc);

#ifdef DEBUG
    printf("infile: %s, outfile: %s, proc: %d\n", infile, outfile, proc);
#endif


    int pipes[proc][2]; // Pipes to be created
    pid_t child_pids[proc];

    int i; // Loop counter

    char buf[MAIN_BUF_LEN];
    Expression exp;

    // Declare your variables here

    // TASK 1 Open the files. (5 points)
    //
    // Open infile with readonly, outfile with write and append.

    /*Huang Daoji 28/02
     * reference: http://man7.org/linux/man-pages/man2/open.2.html
     * we use open instread of fopen for the former returns a file descripter
     * which consists with the helper function fd_readln
     * otherwise we need to implement the read function
     * O_RDONLY and O_WRONLY stands for readonly and writeonly, respectively
     * O_APPEND
     */

    int in_file = Open(infile, O_RDONLY);
    int out_file = Open(outfile, O_WRONLY | O_APPEND);
    // ---------- END TASK 1 ----------

    // TASK 2 Get parent pid and print to outfile (5 pts)
    pid_t parent_pid = Getpid();
    sprintf(buf, "%d\n", parent_pid);

#ifdef DEBUG
    printf("parent pid is: %s", buf);
#endif

    Write(out_file, buf, strlen(buf) + 1);
    // ---------- END TASK 2 ----------

    // TASK 3 Create pipes (10 pts)
    //
    // $proc pipes should be created and saved to pipes[proc][2]

    /*Huang Daoji 28/02
     * pipe() receives a int[2] array, which is exactly pipes[i]'s type
     * returns with the two ends stored in pipes[i][0], and pipes[i][1]
     * which are file descripters(not FILE*!)
     * return value != 0 indicates error
     * reference: http://man7.org/linux/man-pages/man2/pipe.2.html
     */
    for (i = 0; i < proc; ++i)
    {
        Pipe(pipes[i]);
    }
    // ---------- END TASK 3 ----------

#ifdef DEBUG
    printf("make pipe end\n");
#endif

    // TASK 4 Create child processes (10 pts)
    //
    // $proc child processes should be created.
    // Call child_work() immediately for each child.

    /*Huang Daoji 28/02
     * creating children using fork(), and check the return value, if error
     * occurs, print the error message in the command line
     * close the file descripters left open
     * better close in/out file here, for these files are invisible to
     * child_work() function, and children can exit without any problem
     */
    for (i = 0; i < proc; ++i)
    {
        pid_t child_pid = Fork();
        if(child_pid > 0){
            // parent
            child_pids[i] = child_pid;
        }else if(child_pid == 0){
            // child
            child_work(pipes, proc, i, out_file);
            Close(in_file);
            Close(out_file);
            exit(0);
        }else{
            printf("error in creating children #%d!\n", i);
            exit(-1);
        }
    }
    // ---------- END TASK 4 ----------

#ifdef DEBUG
    printf("child process created\n");
#endif

    // TASK 5 Close reading end of pipes for parent (5 pts)

    /*Huang Daoji 28/02
     * close all the reading ends(pipes[*][0])
     * using system call int close(int fd), return 0 when success
     * reference: http://man7.org/linux/man-pages/man2/close.2.html
     */
    for (i = 0; i < proc; ++i)
    {
        Close(pipes[i][0]);
    }
    // ---------- END TASK 5 ----------

    // TASK 6 Read from file and distribute to children (20 pts)
    //
    // Read lines and distribute the calculations to children in round-robin
    // style.
    // Stop when a empty line is read.
    // Close all the pipes when the task ends.

    /*Huang Daoji 28/02
     * read line by line using helper function fd_readln()
     * which returns the length of chars read(not include the final '\n'?)
     * the next_child variable indicates which child should parse the next line
     * increment by one once a line has been handled over to a child
     * close all the writing ends of pipes
     */

    int next_child = 0;
    int data_length = 0;

#ifdef DEBUG
    printf("parent pid is: %s\n", buf);
#endif

    while(data_length = fd_readln(in_file, buf, MAIN_BUF_LEN)){

#ifdef DEBUG
    printf("Read a new line: %s\n", buf);
#endif

        Write(pipes[next_child][1], buf, data_length);
        // re-initialize the temp variables
        data_length = 0;
        next_child = (next_child + 1) % proc;
    }

    for(i = 0; i < proc; i += 1){
        Close(pipes[i][1]);
    }

    // ---------- END TASK 6 ----------

    // TASK 7 Wait for children (5 pts)

    /*Huang Daoji 28/02
     * since we have got the pid of each child, better use waitpid() here
     * parent process will check the return status of each child
     */
    for (i = 0; i < proc; ++i)
    {
        int status = 0;
        Waitpid(child_pids[i], &status, 0);
    }
    // ---------- END TASK 7 ----------

    // TASK 8 Write last \n (5 pts)

    /*Huang Daoji 28/02
     * write last...
     * yes, but remember to close all the files we opened
     */
    Write(out_file, "\n", 1);
    Close(out_file);
    Close(in_file);
    // ---------- END TASK 8 ----------

    return 0;
}


/* Definition of the secure version of system calls */

void Close(int fd){
    if(close(int fd) < 0){
        printf("Error in closing file, fd: %d\n", fd);
        exit(-1);
    }
}

pid_t Getpid(void){
    // "These functions are always successful." -- man getpid(2)
    return getpid();
}

ssize_t Write(int fd, const void* buf, size_t count){
    ssize_t tmp;
    if(tmp = write(fd, buf, count) < 0){
        printf("Error in write %s to file %d\n", buf, fd);
        exit(-1);
    }
    return tmp;
}

int Open(const char* pathname, int flags, mode_t mode){
    int tmp;
    if(tmp = open(pathname, flags, mode) < 0){
        printf("Error in open file %s\n", pathname);
        exit(-1);
    }
    return tmp;
}

int Pipe(int pipefd[2]){
    int tmp;
    if(tmp = pipe(pipefd) < 0){
        printf("Error in create pipe\n");
        exit(-1);
    }
    return tmp;
}

pid_t Fork(void){
    pid_t pid;
    if(pid = fork() < 0){
        printf("Error in fork()\n");
        exit(-1);
    }
    return pid;
}

pid_t Waitpid(pid_t pid, int* iptr, int options){
    pid_t child_pid;
    if(child_pid = waitpid(pid, iptr, options) < 0){
        printf("Error in waiting for child %d\n", pid);
        exit(-1);
    }
    return child_pid;
}

/* End of definition of secure version of system calls */
