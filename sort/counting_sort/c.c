#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <limits.h>

#define MILLION 1000000

/* From wikipedia */
long compare_ints(const void *p, const void *q) {
  long x = *(const long *)p;
  long y = *(const long *)q;

  /* Avoid return x - y, which can cause undefined behaviour
     because of signed integer overflow. */
  if (x < y)
    return -1;  // Return -1 if you want ascending, 1 if you want descending order.
  else if (x > y)
    return 1;   // Return 1 if you want ascending, -1 if you want descending order.

  return 0;
}

void stdlib_sort(long *a, size_t n) {
  qsort(a, n, sizeof *a, compare_ints);
}

/* ************* */

long* copy_array(long *a, size_t size) {
  long* result = malloc(size * sizeof(long));
  for(long i = 0; i < size; i++) {
    result[i] = a[i];
  }

  return result;
}

void counting_sort(long *a, size_t n) {
  long max = a[0];
  long min = a[0];
  for(size_t i = 1; i < n; i++) {
    if(max < a[i]) max = a[i];
    if(min > a[i]) min = a[i];
  }

  long* counters = calloc((max - min) + 1, sizeof(long));
  for(long i = 0; i < n; i++) {
    counters[a[i] - min]++;
  }

  long i = 0;
  for(long number = min; number <= max; number++) {
    while(counters[number - min] > 0) {
      a[i] = number;
      counters[number - min]--;
      i++;
    }
  }
}

void benchmark(char* msg, void (*f)(long*, size_t), long *a, size_t n) {
  printf(msg);
  long* copy = copy_array(a, n);
  time_t t = clock();
  f(copy, n);
  printf("%f millisec\n", (double)(clock() - t) / CLOCKS_PER_SEC * 1000);
  free(copy);
}

int main() {
  /* long tmp[10] = {20, 9, 8, 7, 6, 5, 4, 4, 4, 4};
     counting_sort(tmp, 10);
     for(int i = 0; i < 10; i++) {
       printf("%ld ", tmp[i]);
     }
     printf("\n"); */

  long size = 1000 * MILLION;

  printf("Init data...");
  fflush(stdout);
  long* random = calloc(size, sizeof(long));
  for(long i = 0; i < size; i++) {
    random[i] = rand() % 100;
  }
  long* reverse_range = calloc(size, sizeof(long));
  for(long i = 0; i < size; i++) {
    reverse_range[i] = size - i;
  }
  printf("Ok\n\n\n");


  printf("[Random] 10K\n");
  benchmark("Counting: ", counting_sort, random, 10000);
  benchmark("qsort: ", stdlib_sort, random, 10000);
  printf("\n");

  printf("[Reverse] 10K\n");
  benchmark("Counting: ", counting_sort, reverse_range, 10000);
  benchmark("qsort: ", stdlib_sort, reverse_range, 10000);
  printf("\n\n");


  printf("[Random] 1 million\n");
  benchmark("Counting: ", counting_sort, random, MILLION);
  benchmark("qsort: ", stdlib_sort, random, MILLION);
  printf("\n");

  printf("[Reverse] 1 million\n");
  benchmark("Counting: ", counting_sort, reverse_range, MILLION);
  benchmark("qsort: ", stdlib_sort, reverse_range, MILLION);
  printf("\n\n");


  printf("[Random] 100M\n");
  benchmark("Counting: ", counting_sort, random, 100 * MILLION);
  benchmark("qsort: ", stdlib_sort, random, 100 * MILLION);
  printf("\n");

  printf("[Reverse] 100M\n");
  benchmark("Counting: ", counting_sort, reverse_range, 100 * MILLION);
  benchmark("qsort: ", stdlib_sort, reverse_range, 100 * MILLION);
  printf("\n\n");

  printf("[Random] 500M\n");
  benchmark("Counting: ", counting_sort, random, 500 * MILLION);
  benchmark("qsort: ", stdlib_sort, random, 500 * MILLION);
  printf("\n");

  printf("[Reverse] 500M\n");
  benchmark("Counting: ", counting_sort, reverse_range, 500 * MILLION);
  benchmark("qsort: ", stdlib_sort, reverse_range, 500 * MILLION);
  return 0;
}
