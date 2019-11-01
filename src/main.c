#include "stdio.h"

// CG2028 Assignment
// (C) CK Tham, ECE, NUS

// Optimization routine written in assembly language
// Input parameters (signed integers):
//     xi : integer version of x
//     a, b, c : integer coefficients of f(x)
// Output : returns solution x (signed integer)
extern int optimize(int xi, int a, int b, int c);

int main(void)
{
    int a=3, b=4, c=-3, xsoli;
    int iter = 0;
    float fp, x, xprev, xsol, change, lambda=0.1;

    printf("Initial value of x (press [Enter] after keying in): "); // try x0 = -6.78
    scanf("%f", &x);

//  ARM ASM & Integer version
    printf("ARM ASM & Integer version:\n");
    xsoli = optimize((int) x * 100, a, 100 * b, &iter);
    xsol = xsoli / 100.0;
    printf("xsol : %f \n\n",xsol);
    printf("Number of iterations : %d\n\n", iter);

//  NOTE: You DO NOT need to modify the code below this line

//  C & Floating Point version
  	printf("C & Floating point version:\n",x);
    while (1)
    {
    	fp = 2*a*x + b;

    	xprev = x;
    	change = -lambda*fp;
    	x += change;

    	printf("x: %f, fp: %f, change: %f\n", x, fp, change);
    	if (x==xprev) break;
    }

    // Enter an infinite loop, just incrementing a counter
	// This is for convenience to allow registers, variables and memory locations to be inspected at the end
	volatile static int loop = 0;
	while (1) {
		loop++;
	}
}

