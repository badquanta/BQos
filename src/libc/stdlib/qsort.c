#include <stdlib.h>

static void sort(char *array, size_t size, int (*cmp)(void*,void*), int begin, int end) {
   if (end > begin) {
      void *pivot = array + begin;
      int l = begin + size;
      int r = end;
      while(l < r) {
         if (cmp(array+l,pivot) <= 0) {
            l += size;
         } else if ( cmp(array+r, pivot) > 0 )  {
            r -= size;
         } else if ( l < r ) {
            swap(array+l, array+r, size);
         }
      }
      l -= size;
      swap(array+begin, array+l, size);
      sort(array, size, cmp, begin, l);
      sort(array, size, cmp, r, end);
   }
}

void qsort(void *array, size_t nitems, size_t size, int (*cmp)(void*,void*)) {
   if (nitems > 0) {
      sort(array, size, cmp, 0, (nitems-1)*size);
   }
}