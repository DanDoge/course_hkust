1. purpose of system call
    - allow user-level program request services of the os
2. five major activities of os with regard to process management
    - creation and deletion of user / system program
    - suspension and resumption of process
    - provision of mechannism for process syncchronizaiton
    - provision of mechannism for process communication
    - provision of mechannism for deadlock handling
3. three major activities of an os with regard to memory management
    - keep track of which parts of memory are used and by whom
    - decide which processes are to be loaded
    - allocate and deallocate memory space as needed
4. three major activities of an os with regard to secondary-storage management
    - free space management
    - storage allocation
    - disk scheduling
5. purpose of command interpreter, why is separate from the kernel
    - reads command from user / from a file, and execute them, usually turning them into system calls
    - since they are subject to changes
6. what system calls have to be executed by a shell to start a new process?
    - fork
7. purpose of system programs
    - a bundle of system calls
    - provide basic functionality to users so users do not need to write their own programs to solve common problems
8. main advantage of layered approach to system design, and disadvantages
    - easy to debug and modify
    - information kept within a defined and restrited area, bugs affecting these data limited to specific layer
9. five service provided by os, how is these convenient to users, in which case will it be impossible for user-level program to provide these services
    - program execution: user-level program cannot be trusted
    - io: user only need to specify the device, and cannot be trusted
    - file-system manipulation: details user need not to perform, protection and trust
    - communication: user-level program may receive packets from diff. program
    - error detection: hardware and software level, process independent error should be handled by global program, user program which catches all errors are redundant
10. some system  store on firmware, others on disk, why?
    - for pdas and cellular telephones, a disk with a file system may be not availble for the device, so the os should be on the firmware
11. how to allow a choice of os to boot, what should the bootstrap program do?
    - a special program determine which os to boot into
    - first run this boot manager when startup
    - store on certain location on harddisk, have a default system when user give no choise
