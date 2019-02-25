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
