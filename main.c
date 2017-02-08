#include <stdio.h>
#include <unistd.h>
#include <pthread.h>

void *thrfun(void *arg){
        sleep(1);//使得主线程先退出
        printf("new thread\r\n");

        printf("chile exit\r\n");

        pthread_exit(0);
}


int main() {
        printf("Hello, World!\n");

        pthread_t pid;

        pthread_create(&pid,NULL,thrfun,NULL);

        pthread_join(pid,NULL);

        while (1){
                sleep(3);

                printf("father alive\r\n");
        }

        printf("father exit\r\n");

        return 0;
}