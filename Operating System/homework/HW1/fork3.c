#include <stdlib.h>
#include <stdio.h>
#include <semaphore.h>
#include <unistd.h>
#include <fcntl.h>

int main(){

    sem_t* mutex = sem_open("mutex", O_CREAT | O_EXCL, 0644, 0);

    if(fork()){
        sem_wait(mutex);
        printf("goodbye\n");
    }else{
        printf("hello\n");
        sem_post(mutex);
	exit(0);
    }

    sem_unlink("mutex");
    sem_close(mutex);

    return 0;
}
