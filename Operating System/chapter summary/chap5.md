### chapter 05

#### TA's note

#### highlight from textbook

it is kernel-level threads that are being scheduled by the OS

CPU burst distribution: a large number of short CPU bursts and a small number of long CPU bursts.

schedule algorithm
- nonpreeemptive / cooperative: only schedule when a process terminates, or a process trun into waiting status, once a process allocated, it keeps the CPU untiil it terminates or waiting
- otherwise(a process become ready from running, or from waiting) -> preemptive, results in race conditions when data shared among several processes


kernel execution model is a poor one for supporting real-time computing. the code affected by interrupts must be guarded from simutaneous use.

dispatcher should be as fast as possible, since it is invoked during every context switch

important to minimize the varience in the response time

convoy effect: all the other processes will wait for the one big process to get off the CPU

SJF: depends on the length of the next CPU burst of a process, rather than its total length
- exponential average: $\tao_{n+1} = \alpha t_{n} + (1 - \alpha)\tao_{n}$
- nonpreeemptive / preemptive: choice when a new process arrives at the ready queue while a previous process is running, latter called SRTF

RR
- treat the ready queue as a circular queue
- process release the CPU volutarily if tis CPU burst time less than one time quantum
- rule of thumb: 80% of CPU burst shorter than the time quantum

priority scheduling
- CPU allocated to the process with highest priority
- equal-priority process scheduled in FCFS order
- external priority set by criteria outside the OS
- preemptive version: when priority of the new arrived process is higher
- indefinit blocking, starvation -> aging: gradually increasing the priority of process that waiting for a long time

multilevel queue scheduling
- different type of processes have different response time requirements -> different scheduling needs
- time-slice among the queues

MFQS(multilevel feedback queue scheduling)
- allows a process to move between queues, moved to low level queue if use too much CPU time, moved to high level queueif waits for too long

thread scheduling
- user-level thread msut ultimately mapped to kernel-level threads
- process contention scope: thread library schedules user-level threads to run on an availble LWP
- system contention scope: decide which kernel-level thread to schedule onto a CPU
- OS with one-to-one mapping use only SCS

multiprocessor scheduling
- possible race condition on the shared ready queue
- memory stall: modern processors operate much faster than memory -> assign two hardware threads to each core: chip multithreading -> provides an illusion that OS has 2n logical CPUS
- OS scheduler, if made aware of sharing of processor resources, can make more effective scheduling decisions

load balancing
- keep the workload evenly distributed across all processors in an SMP system
- especially necessary on systems where each processor has its own private queue of eligiblethreads to execute
- push migration: a special task periodically checks the load on each processor
- pull migration: an idle processor pulls a waiting task from a busy processor

processor affinity
- attempt to keep a thread running on the same processor
- processor affinity: a process has an affinity for the processor on which it is currently running
- per-processor ready queue provides processor affinity ofr free
- soft affinity: attempting to keep a process running ong the same processor, but not guaranteeing to do so
- hard affinity: allowing a process to specify a subset fo processors on which it can run
- load balancing counteracts the benefits of processor affinity

real time CPU scheduling
- soft real-time systems: no guaranteeing as to when a critical real-time process will be scheduled
- hard real-time systems: a task must be serviced by its deadline
- event latency: time from an event occurs to it is serviced
- interrupt latency: time from the arrival fo an interrupt to the start of the routine that services the interrupt. the time kernel data being updated may contribute to interrupt latency, for interrupts are disabled
- dispatch latency: the time required for the scheduling dispatcher to stop one process and start another
- scheduler of real time OS must support a priority based algorithm with preemption
- t < d < p
- rate monotonic scheduling
    - priority inversely based on tis period, with preemption
    - the worst-case CPU utilization for scheduling N processes is $N(2^{1/n} - 1)$
- earlist deadline first scheduling
    - priority dynamically according to deadline
    - does not require a process to be periodic
    - theoretically optimal
- proportional share scheduling: deny process if sums larger than 100

algorithm evaluation
- deterministic modeling: takes a particular predetermined workload, defines the performance of each algorithm for that workload. requires exact number for input, answers only apply to these cases
- queueing models: if the system is in a steady state, the number of processes leaving teh queue must be equal to the number of prcesses arrive 
