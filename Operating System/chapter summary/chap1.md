### chapter one

#### TA's note

main purposes of os
- user convenience: for users / programmers to execute programs in a convenient, safe, protected and efficient mannner
- resource allocation: in a fair and efficient manner; resources include: cpu, main mem., signal and lock

storage hierachy
- according to speed and cost, expensive and fast on the high level
- main mem.: volatile, the only storage processor can access directly, holds programs and data
- cache: based on temporal and spatial locality, holds a subset of frequently used items
- non volatile storage: holds large quantities of data premanently; hard disks

interrupt
- a key way hardwar interacts with os. hardware device triggers an interrupt by sending a signal to cpu
- interrupt handler / interrupt service routine handle an specific interrupt; context switch
- all modern os: interrupt-driven
- trap: software-generated interrupt; can be used to call os routines

dma
- move large amount of data between io devices and main mem., cpu initiates a dma controller, which instructs a deviec controller to move data between device and main mem.
- slow devices generates onr interrupt per byte, cpu responsible

multiprocessor sys.
- each cpu contain several computing cores; throughput, relability and scalability
- smp: all processors equals, while asymmetric multiprocessing has one master cpu and slave cpus, master distributes tasks among slaves, and most of io
- save cost, quick, relability, but more complex

muitiprogramming: several jobs in mem.; multitasking / time-sharing: cpu scheduling algorithms. switch between processes, providing a fast response time

virtulization, cloud computing
- emulation: src cpu type diff. form target cpu type; compiled apps can run on diff. architectures. slow, for translating each machine-level instructions
- virtulization: os as an app. within another os, abstracting hardware onto diff. exec. environments
- virtual machine: creates an illuison that each process thinks it runs on a dedicate cpu and mem.
- cloud computing: computing / storage / app services on-demand over network; often uses virtulization; public, private or hybrid; offer apps, platforms, or sys. infra.

#### highlight from textbook

Definition: OS is software that manages a computer's hardware.
- OS controls the hardware and coordinates its use among the various application programs for the various users.
- From system view, OS as a resource allocator. As a control program, manages the execution of user programs to prevent errors and improper use of the computer.
- The common functions of controlling and allocating resources are brought together into the OS.
- OS is the one program running all the time on the computer.
- In summary, for our porposes, OS includes the always-running kernel, middleware frameworks that ease app. dev. and provide features, and sys. programs that aid in managing the system while it's running.

Computer system organization
- A device controller maintains some local buffer storage and a set of special-purpose registers.
- OS have a device driver for each device controller.
- Hardware may trigger an interrupt at any time by sending a signal to CPU by sys. bus.
- Interrupt must transfer control to the appropriate interrupt service routine.
- A table of pointers to interrupt routines can be used to provide the necessary speed.
- The device controller *raises* an interrupt by asserting a signal on the interrupt request line, CPU *catches* the interrupt and *dispatches* it to the interrupt handler, and the handler *clears* the interrupt by serving the device.
- CPU have two interrupt lines: nonmaskable interrupt reserved for events like unrecoverable memory errors, an maskable interrupt line which can be turned off by CPU before critical instructions that cannot be interrupted
- In case we have more devices than the length of interrupt vector, use interrupt chaining, each element in the interrupt vector points to the head of a list of interrupt handlers
- firmware: storage that is infrequently written to and is nonvolatile
- The top four levels of mem.(registers, cache, main memory, nonvolatile memory) are constructed using semiconductor memory
- Volatile memory referred t oas memory
- Nonvolatile storage retains the contents, referred to as NVS
    - Two diff types, Mechanical and electrical(referred to as NVM)
- Only one interrupt is generated per block in DMA.

Computer system architecture
- main cpu capable of executing a general-purpose instructions set, while special-purpose processors run a limited instruction set adn do not run process
- SMP(symmetric multiprocessing), each peer cpu processor perform all tasks, including user / os processes
- processor: a physical chip that contains one or more cpus
- NUMA(non-uniform memory access): each cpu has its own local memory accessed via a small, fast bus; cpus are connected by a shared system interconnect. The memory space remains the same.
- cluster systems: composed of two or more individual systems joined together, each node is typically a multicore system

Operating system operations
- bootstrap program initializes all aspects of the system, from registers to device controller to memory contents; it must locate the os kernel and load it into memory
- system daemons: run the entire time the kernel is running, a service provided outside the kernel provided by system programs
- system call: a specific request from a user program that an os service be performed by executing a special operation called system call
- two separate modes: user mode and kernel mode
- at boot time, the hardware starts in kernel mode. the os is then loaded and starts user apps in user mode.
- privileged instructions only be executed in kernel mode
- initial control resides in the os, in kernel mode. control given to user app, set to user mode. control switched back to kernel mode via an interrupt, a trap, or a system call
- system call is treated by the hardware as a software interrupt
- trap transfer control through the interrupt vector to the os, like an interrupt
- every time the clock ticks, the counter is decremented. when reaches zero, an interrupt occurs.

resource management
- a program is a passive entity, whereas a process is an active entity
- data transfer from the cache to cpu and registers is usually a hardware function, with no os intervention.
- data from the disk to memory is usually controlled by the os.
- protection is any mechanism for controlling the access of the processes or users to the resources defined by a computer system
- many os maintain a list of usernames and associated user identifiers
- group functionality can be implemented as a system-wide list of group names and group identifier

virtulization
- emulation: simulating computer hardware in software
- vmm runs the guest os, manages their resource use and protect each guest from the others

distributed systems
- a lan connects computers within a room, building or a campus. a wan links buildings cities or countries

computing environments
- in p2p computing, a node joins a network, then
    - registers its service with a centralized lookup service on the network
    - or broadcasting a request for the service to all other nodes in the network
- PaaS, provides a software stack
- embedding system, a real-time os is used when rigid time requirements have been placed on the operation of a processor or teh flow of data.

free and open source os
- some open source software is not free
