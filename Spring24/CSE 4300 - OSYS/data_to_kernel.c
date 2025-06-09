#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// Global variables
pthread_mutex_t packets_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t packets_cond = PTHREAD_COND_INITIALIZER;
pthread_cond_t kernel_cond = PTHREAD_COND_INITIALIZER;

int packets_available;
int packets_served = 0;

void *user_thread_func(void *arg) {
  int my_id = *(int *)arg;

  // Randomness Delay within the thread
  usleep(10000 + 10000 * (my_id * 1000 % 5));

  while (1) {
    pthread_mutex_lock(&packets_mutex);

    // Turn and Packets available checker
    if (my_id < (packets_served + 1) || packets_available == 0) {
      printf("No packet available or not my turn to produce, user level thread "
             "%d going to sleep\n",
             my_id);
      pthread_cond_wait(&packets_cond, &packets_mutex);
    }

    // Produce data
    printf("User level thread %d is going to put data in a packet\n", my_id);

    packets_available--;

    pthread_mutex_unlock(&packets_mutex);
    pthread_cond_signal(&kernel_cond);
    pthread_exit(NULL);
  }
}

void *kernel_thread_func(void *arg) {
  int my_id = *(int *)arg;
  free(arg);

  // Randomness Delay within the thread
  usleep(10000 + 10000 * (my_id * 1000 % 5));
  pthread_cond_wait(&kernel_cond, &packets_mutex);
  while (1) {
    pthread_mutex_lock(&packets_mutex);

    // Wait if no packets available
    if (packets_available > 0) {
      printf("No data available, Going to sleep kernel thread %d\n", my_id);
      pthread_cond_wait(&kernel_cond, &packets_mutex);
    }

    // Serve user thread
    int servedId = my_id;
    printf("user thread %d getting served\n", servedId);

    packets_served++;
    packets_available++;

    pthread_mutex_unlock(&packets_mutex);
    pthread_cond_broadcast(&packets_cond);
    pthread_exit(NULL);
  }
}

int main(int argc, char *argv[]) {
  // Initialize parameters X = Number of Packets, N = Number of User Threads
  // (global variable), M = Number of Kernel Threads
  int X = atoi(argv[1]);
  int N = atoi(argv[2]);
  int M = atoi(argv[3]);

  packets_available = X;
  pthread_t user_threads[N];
  pthread_t kernel_threads[M];

  // Create User Threads then Kernel Threads
  for (int i = 0; i < N; i++) {
    pthread_create(&user_threads[i], NULL, user_thread_func, &i);
  }

  for (int i = 0; i < M; i++) {
    pthread_create(&kernel_threads[i], NULL, kernel_thread_func, &i);
  }

  // Join User Threads then Kernel Threads
  for (int i = 0; i < N; i++) {
    pthread_join(user_threads[i], NULL);
  }

  for (int i = 0; i < M; i++) {
    pthread_join(kernel_threads[i], NULL);
  }

  return 0;
}