#include <math.h>
#include <stdio.h>
#include <time.h>
extern double calcularAreaASM(double *arrx, double *arry, int nVertices);
double calcularAreaC(double *arrx, double *arry, int nVertices);

int main(){
    int nVertices = 6;
    double areaCalculadaC = 0.0,areaCalculadaASM = 0.0;
    int n;
    printf("Ingrese la cantidad de vertices: \n");
    scanf("%d",&n);
    printf("Ingrese los vertices: \n");
    double arrx[n], arry[n];
    for( int i=0;i<n;i++){
        printf("Ingrese las coordenas del primer vertices: \n");
        scanf("%lf %lf",&arrx[i], &arry[i]);
    }
    struct timespec ti, tf;
	double elapsed1, elapsed2;
    //printf("%lf",arrx[0]);
    //double arrX[] = {3.0,5.5,6.0, 4.5,3.5,6}, arrY[] = {0.2,2.0,4.5,6,3.5,4.5};
    clock_gettime(CLOCK_REALTIME, &ti);
    areaCalculadaC  = calcularAreaC(arrx, arry, n);
    clock_gettime(CLOCK_REALTIME, &tf);
	elapsed1 = (tf.tv_sec - ti.tv_sec) * 1e9 + (tf.tv_nsec - ti.tv_nsec);
    printf("El area calculada en C es %lf \n", areaCalculadaC);
    printf("el tiempo en nanosegundos que toma la función en C es %lf\n", elapsed1);
    clock_gettime(CLOCK_REALTIME, &ti);
    areaCalculadaASM = calcularAreaASM(arrx, arry, n);
    clock_gettime(CLOCK_REALTIME, &tf);
	elapsed2 = (tf.tv_sec - ti.tv_sec) * 1e9 + (tf.tv_nsec - ti.tv_nsec);
	printf("el tiempo en nanosegundos que toma la función en ASM es %lf\n", elapsed2);
    printf("El area calculada en ASM es %lf \n", areaCalculadaASM);
    double speedUp = elapsed1 / elapsed2;
	printf("El speedUp entre C y ASM es: %.4lf\n", speedUp);
    printf("\n Finalmente podemos demostrar que la funcion mas optima de utilizar es la implementada en la de ASM, ya que como sabemos es mucho mas eficiente al trabajar directamente con registros, y nos podemos sustentar debido a su SPEEDUP FAVORABLE respecto a la funcion en C\n");
    return 0;
}




double calcularAreaC(double *arrx, double *arry, int nVertices){
    double areaCalculada  = 0.0;
    double valorParcialPrimero = 0.0;
    for(int i=0;i<nVertices;i++){
        if(i==nVertices -1){
            valorParcialPrimero += (arrx[i]*arry[0] -arrx[0]*arry[i]);
        }else{
            valorParcialPrimero += (arrx[i]*arry[i+1] - arrx[i+1]*arry[i]);
        }
    }
    areaCalculada  = valorParcialPrimero/2;

    return areaCalculada;
}