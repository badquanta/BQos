#include <stdlib.h>

void swap(void*l, void*r,size_t size){
   char t;
   for(size_t idx = 0; idx<size;idx++){
      t = ((char*) l)[idx];
      ((char*)l)[idx]=((char*)r)[idx];
      ((char*)r)[idx]=t;
   }
}

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
      sort((char*)array, size, cmp, 0, (nitems-1)*size);
   }
}


#ifdef TEST

int main(){
    return 1;
}
#endif