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

p212
