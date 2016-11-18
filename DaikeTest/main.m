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




int main(int argc, const char * argv[]) {
    
    my_productTest();
    
    return 0;
}
