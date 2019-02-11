#### chapter one

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
