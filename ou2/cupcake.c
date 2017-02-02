
#include <stdio.h>

int happiness(int cupcakes){
return cupcakes == 0 ? 0 : 3 + happiness(cupcakes-1);
}

int main (){

printf("%d\n", happiness(3));
}




