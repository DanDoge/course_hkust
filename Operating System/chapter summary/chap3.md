### chap three

#### TA's note

process is a program in execution and is considered a unit of work on a modern time-sharing system. all processes execute concurrently, with CPU switching.

process
- a process captures the entire duration of a program execution
- life cycle: new, ready, waiting, terminated
- resources: CPU, memory, registers, files, IO, cooperating with other processes
- while a program is a static entity, a text part on disk
- represented on th eOS by a PCB: pid, and others
- a process can be interpreted as a thread represented by a PC, registers, and stack, address space(data, text, and heap)
- state of process represented by queues: ready queue, io queue
- scheduling algorithms needed to manage the competition and facilitate resource sharing: long-term, medium-term and short-term
- concurrency: within in a period of time, multiple processes run on the CPU / make progress / executions are interleaved or lultiplexed
- process -> heavy-weight process, no concurrency within the process: one thread of execution, instrutions executed sequentially
- context switch occurs when CPU switches from one running process to another, save the state, and load the new

dual mode
- distinction between kernel mode and user mode provides a rudimentary form of protection: privileged instructions only executed in kernel mode; hardware can be accessed only in kernel mode; user program has limited capability
- transitions: system calls, trap, interrupts

multitasking in mobile systems
- limited resource on mobile systems: processing capability, memory space, battery: only single foreground process running on the display hwile background processes remains in the memory. types of apps can run in ios are restricted, while no such restriction in android, in which a background app must use a service running on behalf of a background process

operations on process
- creation and termination, parent paocess and child process
    - actions taking during creating a enw process: constructing a new PCB, allocating memory space, copying data from parent, io states
- return all resources to OS, OS deallocate resources, parent may have to wait for children

fork() system call
- creates a new process, cpoying the address space from its parent
- no parameter, but return things
    - <0 if fails, 0 in child, pid in parent
- two process both run the codes after the fork(): copy PCB including PC
- concurrently executing, no assumption about executing order
- CreateProcess() in windows loading a new program, >= 10 parameters, zeromemory() for memory allocation, WaitForSingleObject(handle of child) <- wait()

process termination
- zombie: terminated but parent has not yet called wait(), OS do nothing, waiting for parent call wait()
- orphan: parent terminates without calling wait(), child assigned to init, init periodically calls wait()

IPC
- benefits from cooperating with other processes: information sharing, computation speedup, modularity, and convienience
- two basic modes of IPC: shared memory, and message passing
    - shared memory: implicit passing message
    - direct communication: identity of the sender and receiver need to eb known before communication
    - indirect communication: send a message to a mailbox, no need to reveal the identity of the sender and receiver

client and server communications
- sockets, remote procedure calls, or pipes
- socket: an endpoint of communications, specified by an ip address, port number
- only clients initiate communications, server waiting for clients to contact them
- socket number smaller than1024, reserved / predefined for server

pipes
- ordinary pipe: allow two processes to communicate in a standard Producer and Consumer fashion, unidirectional
- cannot be accessed from outside the process that creates the pipe. typically a parent creates a pipe and communicate with its child
- pipe(int fd[2]), can be accessed by read and write system calls
- named pipe are bidirectional and does not require parent-child relationship, allows multiple processes to use it for communication
- named pipe referred to FIFOs, mkfifo() system call, appears as typical files in the file system
- named pipe still exist even if the process using it terminated, while ordinary pipe cease to exist if the process terminated

# highlight from textbook

a process is a program in execution, the unit of work in modern compuitng system.

an OS have to support its own internal programmed activities.

memory of a process: text, data, heap, stack, the first two's sizes are fixed. activation record: parameters, local variables, return address, in stack. OS ensure stack and heap do not overlap with each other.

a program by itself is not a process
- program is a passive entity
- a process is an active entity, with a PC, a set of associated resources
- a program becomes a process when loaded into memory
- only one process can be running on any processor core

PCB
- process state
- program counter
- CPU registers: include accumulators, index registers, stack pointers, general-purpose registers, condition-code infromation
- CPU scheduling infromation: process priority, pointer to scheduling queues, other parameters
- memory management information: base and limit of registers and page tables, segment tables
- accounting informaiton: amount of CPU and real time used, time limits, account numbers, job numbers
- IO informations

threads
- a process can have multiple threads of execution at a time
- PCB is expand to include information for each thread

process scheduling
- the number of process in memory is the degree of multiprogramming
- ready queue / wait queue(s) -> queueing diagram
- process *dispatched* from ready queue to an availble CPU, removed for, say, time slice expired
- swapping: reduce the degree of multiprogramming, when memory has been overcommitted
- the context of a process is represented in the PCB of the process
    - context switch: a state save and restore
- multitasking in mobile systems: system tasks can multitask well for they are written by Apple, in Android, a separate service runs on behalf of the background process

operation on process
- a tree of processes
- pid provides a unique value for each process in the system
- the first user process created when system boots: systemd(pid = 1)
- parent may have to partition / share its resources among its children
- two possibilities for the new process
    - a duplicate of the parent process
    - a new program loaded into
- fork
    - the new process consists of copy of the address space of the original process, which can be replaced by exec() system call
    - parent issue a wait() system call to move itself off the ready queue
    - exec() does not return control unless an error occurs
    - wait(): return a status value to its waiting parent
- cascading termination: happends in some system which do not allow a child to exist after its parent's termination
- zombie and orphans

android process hierarchy
- foreground process: visible on the screen
- visible process: performing an activity that the foreground process is referring to
- service process: performing an activity that is apparent to the user
- background process: performing an activity but is not apparent to the user
- empty process: no active components

interprocess communication
- independent process: shares no data with any other process
- cooperating process: can be affected / affect other process
- reasons for process cooperation
    - information sharing, computation speedup(only for multiple processing cores), modularity
- two model of IPC: shared memory, message passing
    - message passing: smaller amount of data, easier to implement
    - shared memory: faster

IPC in shared-memory system
- attach the shared memory segment to its address space to communicate
- OS remove the restriction that one process cannot access the others memory -> process are responsible for synchronizaiton issues
- generally: server -> producer, client -> consumer, must be synchronized
- unbounded buffer, no space limit on the size of the buffer, while the bounded buffer assumes a fixed size, wait if the buffer is empty / full

IPC in message passing systems
- the OS to provide the means for cooperating processes to communicate
- tradeoff throughout the OS design: message of fix size or variabile size
- direct communication: each process must explictly name the recipient or sender
    - A link between every pair of process, a link to exactly TWO processes
- symmetry in addressing: the sender and receiver has to name the other
- asymmetry: only the sender has to name the recipient
- disadvantage in both schemes: limited modularity of resulting process definitions
- indirect communication
    - a process can communicate via a number of different mailboxes
    - two process can communicate if they share a mailbox
    - a link between processes(may be more than two) that share a mailbox, multiple links may between two processes
- a mailbox owned by a process(mailbox is part of the address space), distinguish between the owner and user
- a mail box ownde by the OS is independent, can be assigned to a program, can be passed to other proceses via system calls

synchronizaiton
- message passing may be blocking or non-blocking(synchronous and asynchronous)
- rendezvous: send and receive are blocking

buffering
- zero capacity: sender must block until recipient receives
- bounded: if full, still have to wait

examples of IPC systems
- posix shared memory
    - associate the region of shared memory with a file(shm_open(return a fd) -> ftruncate(configure the size) -> mmap(establishes a memory-mapped file) -> shm_unlink)
- mach message passing
    - message sent to finite in size unidirectional *ports*
    - poor performance caused by copying messages
    - avoid cpoy operation by virtual memory, but only works for intrasystem messages
- windows
    - a port object, server process publish port object visible to all processes, create a channel and return a handle to the client
    - small message: message queue, larger: section object, too large: read and write directly into address space

pipes
- half duplex(data can travel one way at a time), full duplex(both directions at the same time)
- ordinary pipes
    - standard producer-consumer fashion
    - unidirectional, one-way communication
    - anonymous pipes in Windows, specify which attributes the child processs will inherit
- named pipes
    - several processes can use it for communication
    - continue to exist after communicating processs finished
    - appear as typicial files in the file system
    - only half-duplex, while bidirectional
    - on Windows, full-duplex

communication in client-server systems
- sockets: endpoint for communication
- idnetified by an IP address concatenated with a port number
- below 1024 considered well known, used to implement standad services
- server blocks on the accept()
- RPC: well structured messages, an RPC deamon listening to a port on the remote system, specify the function / parameters to execute, send back output
- parameter marshaling: address the issue of data representation
- ensure messages acted exactly once
    - first: attach a timestamp -> at most once
    - send a ACK for a call
