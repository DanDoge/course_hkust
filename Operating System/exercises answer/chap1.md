1. three main purposes of an os
    - to provide an environment for a computer user to execute programs on cmoputer hardware in convenient and efficient manner
    - to allocate the separate resources of the computer as needed to solve the problem given, as fair and efficient possible
    - as a control program, it serves two major functions
        - supervision of the execution of user programs to prevent errors and imporper use of the computer, and
        - management of the operation adn control of io divices
2. when is it appropriate to waste resources, why is such a system not wasteful?
    - answer from the book: maximize use of system for the user, e.g. GUI waste cpu cycles but optimizes users interaction with the system
    - answer of mine: for reliability, e.g. duplicate an important file when necessary, which improves the reliability of the system
3. main difficulty in writing os for real-time environment?
    - within the fixed time constraint, or it may cause a breakdown. e.g. make sure one's scheduling schemes donot allow response time exceed the time constraint
4. argue both that a web browser should be included into os(which means whether it should be part of the kernel)
    - for: embedded within the os, the browser can run faster
    - against: apps are apps; the performance benefit may be offset by security vulnerabilities; leads to a bloated os
5. how does dual mode serve as a rudimentary form of protection system?
    - certain instrustions can only be executed in kernel mode
    - control over interrupts(enable and disable) is possible only in kernel mode
    - so, cpu in user mode has limited capability, and thus protects critical resources
6. which should be privileged / in kernel mode?
    - issue a trap and switch into kernel mode must not be privileged, for otherwise system has to be in kernel mode to fall from user mode into kernel mode
    - read * should be in user mode
7. some computers store os in a memory partition that could not be modified even the os itself. describe two difficulties
    - data required by os would be in / passed through unprotected memory
    - thus be accessible to unauthorized users
8. more than two modes of operation, two possible uses?
    - finer-grained security policy
    - provide different distinctions within kernel code
9. how timers could be accomplished?
    - using timer interrupts, set a timer then sleep until awakened by the interrupt, update its local state / counter
10. two reasons why caches are useful; what problems do they solve / cause? why not replace the device it caches
    - reasons: providing a buffer for devices of diff. speeds to transfer data; no need to wait if cache hit
    - solve: data transfer
    - cause: data consistance
    - can replace, only if: affordale and equivalent state-saving capacity
11. diff. between client-server and p2p models of distribute systems
    - client-server model distinguishes the role of client adn server
    - p2p donot have such rules

**not complete**
