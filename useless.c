/* comment started at line: 18
*comment ended at line: 20
 */
#include <stdio.h>
#include <stdlib.h>
#include<string.h>
#include "teaclib.h" 

 const int N = 100;
 int a, b;
 
int  cube  (int i) {
  return i * i * i ;
}
 
int  add  (int n, int k) {
  int j;
 j = (N - n) + cube(k);
 writeInt(j);
 return j ;
}

 int main() {
a = readInt();
 b = readInt();
 add(a, b);
 return 0 ;

}