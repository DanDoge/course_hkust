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
