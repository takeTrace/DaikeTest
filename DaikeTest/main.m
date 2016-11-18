//
//  main.m
//  DaikeTest
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 TakeTrace. All rights reserved.
//

#import <Foundation/Foundation.h>

//  ********************      ******************************   //

/**
 *   1. Product array     */
int * my_product(int *arr, int n)
{
    
    //  prod[i] = (x[0] * x[1] * … * x[i-1] ) * (x[i+1] * …. * x[n-1] )
    
    
    if (arr == NULL) return NULL;
    if (n == 0) return NULL;
    
    int *prod = (int *)malloc(sizeof(int)* n);
    
    //  左边, 顺便当做是最后的结果
    prod[0] = 1;
    
    for (int i = 1; i < n; i++) {
        //  累积算出左边的值数组
        prod[i] = prod[i - 1] * arr[i - 1];
    }
    
    //  右边初始化1
    int right = 1;
    for (int j = n - 1; j >=0; j--) {
        //  最后结果:
        prod[j] = prod[j] * right;
        //  算出下一个倒数的右边, 下个循环用来计算
        right = right * arr[j];
    }
    
    //  返回结果
    return prod;
}

//  测试
void my_productTest()
{
    int arr[] = {1, 2, 3, 4, 5};
    //  测试数组结果应为
    int arrTest[] = {120, 60, 40, 30, 24};
    int n = sizeof(arr)/sizeof(arr[0]);
    int *b = my_product(arr, n);
    
    printf("\n [");
    for (int i=0; i<n; i++) {
        printf(" %d  ", b[i]);
        if (b[i] != arrTest[i]) {
            printf("计算错误");
        }
    }
    printf(" ] \n");
}


//  ********************      ******************************   //

/**
 *   2. Number first 
        双索引, 遍历的时候遇到0就停止自增, 非0时 i 的位置赋值给 j 的位置, 最后再把剩下的补0
 */
void numberFirst(int *arr, int count)
{
    if (arr == NULL || count == 0) return;
    
    int idx = 0;
    for (int i = 0; i<count; i++) {
        if (arr[i] != 0) {
            arr[idx] = arr[i];
            idx++;
        }
    }
    
    for (; idx<count; idx++) {
        arr[idx] = 0;
    }
}

void numberFirstTest()
{
    int arr[] = {1, 3, 5, 12, 0, 0, 15, 0};
    int testArr[] = {1, 3, 5, 12, 15, 0, 0, 0};
    int n = sizeof(arr)/sizeof(arr[0]);
    numberFirst(arr, n);
    
    printf("\n [");
    for (int i=0; i<n; i++) {
        printf(" %d  ", arr[i]);
        
        if (arr[i] != testArr[i]) {
            printf("移动0到后面的函数失败");
        }
    }
    
    printf(" ] \n");
    
}

//  ********************      ******************************   //

/**
 *   4. Simple root square 
     使用牛顿迭代法
 */
double my_sqrt(double x) {
    if (x == 0) return 0;
    double last = 0.0;
    double res = 1.0;
    while (res != last)
    {
        last = res;
        res = (res + x / res) / 2;
    }
    return res;
}

void squareTest()
{
    double n = my_sqrt(9);
    if (n != 3) {
        printf("开方失败");
    }
    
    double m = my_sqrt(2);
    if (m > 0) {
        printf("\n%g \n", m);
    }
}

int main(int argc, const char * argv[]) {
    
    //  1. Product array
    my_productTest();
    
    //  2. Number first
    numberFirstTest();
    
    //  4. Simple root square
    squareTest();
    

    
    return 0;
}
