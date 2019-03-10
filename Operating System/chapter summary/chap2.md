### chapter two

#### TA's note

A high-level description of the OS interfaces, including system calls and system programs. Several important concepts including layered design, micro kernel, modular approach, and the policy / mechanism separation.

OS services
- OS provides an envirionment for the execution of programs by providing services to users and programs
- Three primary approaches for interacting with an OS: command interpreters, graphical user interfaces and touch-screen interfaces
- OS offers two categories of services and functions.
    - To enforce protection among different processes running concurrently in the system.
    - To provide functionality not supported directly by the hardware
- OS provides a wide range of services
    - UI
    - program execution
    - IO
    - file management
    - communicaiton
    - error detection
    - resource allocation, accounting, sercurity and protection
- At low level, OS provides system calls, through API, allowing running programs to request services from the OS
- System calls may be devided into
    - process control
    - file management
    - device management
    - information maintenance
    - communications
    - protection
- At high level, OS provides system program for users to issue requests without the need for writing programs
- Users requests vary in different levels. System call level provide basic functions. High level requests can be translated into a sequence of system calls

System calls
- System call interface of a programming language serves as a link to system calls. This interface intercepts funciton calls in the API, and invokes the necessary system calls
- Need to separating API and the underlying system call
    - program portability by using API
    - hide complex details in system calls
- Three general methods used to pass system call paramters to the OS
    - Registers
    - Block / Table of memory, and the address of the block passed in a register
    - Stack method, pushed into stack, and pop out by the OS

Linker and Loader
- Linker combines several relocatable object modules into a single binary executable file
- Loader loads an executable file into memory, where it becomes eligible to run on an availble CPU

Protection and Security
- Protection is concerned with controlling the uesr / process access to the resource of the computer system
- Security is to defend the system from internal or external attacks

Policy and Mechanism
- Policy defines what need to be done, while mechanism specifies how it is implemented
- This separation is necessary for flexibility, to minimize the changes needed when one of them is to be changed

OS Design
- Monolithic OS has no structure, all functionality is provided in a single, static binary file that runs in a single address space
    - difficult to modify
    - but efficient
- Modularity design divide funcitons into diff. modules
    - specify debugging and verification
    - interaction among these modules need to be specified
- Layered approach, a common type, each layer only
    - utilize the services provided by the lower layer
    - provide services for upper layers
    - the bottom is hardware interface, the top is UI
- Microkernel approach, remove all non-esssential components, and implement them as user level programs
    - smaller kernel(process, memory management)
    - easily ported from one hardware to another
    - communicaiton via message passing -> performance suffer
- Dynamically loaded modules, allow adding functionality to an OS while it is executing
- Modern OS adopts a hybrid approach, combines several diff. types of structures

Microkernel
- serveral advantages
    - add a new services do not modify the kernel
    - secure for more operations are in user mode
    - more reliable OS
- User programs and system programs interact by IPC mechanisms, like message passing
    - cons: overheads associated with IPC, frequent use of OS message functions

Loadable kernel modules
- Combine the benefits of layered and microkernel approach.
    - kernel need only to maintain the capability of performing the required functionality and know how to communicate with other modules
    - a kernel which contact with multiple modules is more fiexible than each module can communicate with each other
- Can add / remove functionality while running, no need to recompile or reboot the kernel

iOS and Android
- Similarities
    - based on existing kernels(linux and macosx)
    - adopt an architecture uses software stacks
    - provide framework for developers
- Differences
    - iOS: close-source; Objective-C; natively execute code
    - Android: open-source; JAva; uses a virtual machine

OS implementation
- advantages of using high-level languages
    - code written faster, more compact, easy to understand debug
    - modern compiler improves the generated code
    - OS far easier to port, to other hardware platform

### highlight from textbook

several view of the OS
- on the services it provides
- on the interface it makes availble to users and programs
- on its components and their interconnections

program execution: system should load a program into memory and run that, the program must be able to end its execution, either normally or abnormally

communications may be implemented via shared memory, or message passing

protection and security: extends to defending external IO devices, including network adapters

command interpreters
- as a special program running when a process is initiated or when a user first logs on
- contains the code to execute the command, or merely uses the command to identify a file to be loaded into memory and executed
- shell scripts

system calls
- as functions written in C and C++
- possible error conditions for ach system call must be handled
- API
    - a set of functions that are available to an application programmer
    - access an API via a library of code provided by the OS -> libc in C
    - API invoke the system call on behalf of the application programmer
    - benefits: program portability and hide the difficulty of system call
    - RTE, the full suite of software needed to execute apps written in a given language, including compliers or interpreters as well as other software(libraries and loaders)
    - RTE provides the system call interface as the link to system call
- a number is associated with each system call, and the system call interface maintains a table indexed according to these numbers
- most details of the OS interface are hidden by the API and menaged by the RTE
- methods to pass the parameters to the OS
    - registers
    - stored in a block / table, pass the address of the block in a register
    - pushed onto a stack by the program, popped off by the OS

OS transfer control to the invoking command interpreter, under either normal or abnormal circumstances. define a normal termination as an error at level 0, to automatically determine the next action. save the memory image of the existing program if control to be returned to the existing program. provide system call to lock shared data

a callable system program can be considered an API by other system programs

an OS which allows unmanaged access to devices may cause contention and deadlock for device

strace: lists each system call as a program is executed

single step: a trap is executed by the CPU after every instruction

communication
- a connection must be opened before communication take place
- special purpose deamons are awakened when a connection is made
- shared memory requires the two / more process agree to remove the restriction that one process accessing the others memory, the process are responsible for not writing to the same location simultaneously
- message passing is useful for small amount of data: no conflicts need to avoid, easier to implement
- shared memory allows maximum speed and convenience of communication, but lack of protection and synchronization

system services
- hardware -> OS -> system services -> application program
- some system services are simply UI to system calls, while others are more complex
- background services
    - launching at boot time
    - some terminate after completing their tasks, while others continue until systme halted
    - services / subsystems / daemons
    - maybe important activities in a OS which has a small kernel
- application and system programs shape the users' view of the OS

linker and loaders
- program must be brought into memory and placed in the contedxt ofa process to be eligible to run
- relocatable file: designed to be load into any physical memory location
- relocation: asssigns final address to the program parts and adjusts code and data in the program to match those address
- libs are conditionally linked, for some part of it may not be used into an executable file
- dynamically linked libraries are shared

```shell
file main.o # ELF relocatable file

file main # ELF executable, has the program's evtry point
```

OS-specific apps
- each OS provides a unique set of system calls
- app may be able to run on multiple OS
    - written in an interpreted language, which has an interpreter availble for multiple OS; performance suffers, limited feature sets
    - written in a language includes a virtual machine
    - use a standard language or API, the compiler generates binaries in a machine and OS specific language
- lack of app mobility
    - libs provided by diff. OS contain diff. APIs
    - each OS has a binary format for apps
    - CPU have varying instruction sets
    - system call varies
- ELF file format is not tied to any specific computer architecture, not guarantee a file will run across diff. hardware architecture
- application binary interface
    - define how diff. components of binary code can interface for a given OS on a given architecture
    - including addredd width, methods of passing parameters to system calls, organization of run-time stack, binary form of the system libraries, size of data types
    - specified for a given architecture

OS design and implementation
- no complete solutions to such problems
- define goals and specifications
    - user goals and system goals
- separation of policy and mechanism
    - mechanism flexible enough to work across a range of policies
    - a change in policy require redifinition of only certain parameters
    - microkernel: implementing a basic set of primitive building blocks(policy free), take the separation to one exterme
    - important for all resource allocation
- implementation
    - use of higher-level language: code written faster, more compact, easier to understant and debug
    - simple recompile if improvement in complier technology
    - easier to port to diff. hardware
    - but reduce speed and increased storage requirements
- major performance improvement from: better data structure and algorithms and a small amount of code is critical

##### 2.8
