//
//  main.m
//  DaikeTest
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 TakeTrace. All rights reserved.
//

#import <Foundation/Foundation.h>

//  ********************      ******************************   //
#pragma mark- 1. Product array
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
#pragma mark- 2. Number first
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
#pragma mark- 4. Simple root square
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

//  ********************      ******************************   //
#pragma mark- 5. Power
/**
 *   5. Power
        使用折半传参, 递归调用
 */
double my_power(double x, int n)
{
    if (0 == n) {
        return 1;
    }
    if (1 == n) {
        return x;
    }
    
    //  折半递归
    double temp = my_power(x, n/2);
    
    if (n % 2) {    //  奇次方多乘一个自己
        //  <0 的话返回倒数
        return n > 0 ? (temp * temp * x) : 1/(temp * temp * x);
        
    } else  //  偶次方
    {   //  <0 的话返回倒数
        return n > 0 ? (temp * temp) : 1/(temp * temp);
    }
    
}

void my_powerTest()
{
    double powerResult = my_power(100, 2);
    NSLog(@"\n%g \n", powerResult);
    
    if (powerResult != 10000) {
        printf("求次方函数失败");
    }
}

//  ********************      ******************************   //
#pragma mark- 3. Game of Life
/**
 *   3. Game of Life     */
void gameLife(int *board, int m, int n)
{
    
    printf("\n");
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d", *(board + i*n + j));
        }
        
        printf(",\n");
    }
    printf("\n");
    for(int i = 0; i < m; i++){
        for(int j = 0; j < n; j++){
            int lives = 0;
            // 判断上边
            if(i > 0){
                lives += *(board + i*n - n + j) == 1 || *(board + i*n - n + j) == 2 ? 1 : 0;
            }
            // 判断左边
            if(j > 0){
                lives += *(board + i*n + j - 1) == 1 || *(board + i*n + j - 1) == 2 ? 1 : 0;
            }
            // 判断下边
            if(i < m - 1){
                lives += *(board + i*n + n + j) == 1 || *(board + i*n + n + j) == 2 ? 1 : 0;
            }
            // 判断右边
            if(j < n - 1){
                lives += *(board + i*n + j + 1) == 1 || *(board + i*n + j + 1) == 2 ? 1 : 0;
            }
            // 判断左上角
            if(i > 0 && j > 0){
                lives += *(board + i*n - n + j - 1) == 1 || *(board + i*n - n + j - 1) == 2 ? 1 : 0;
            }
            //判断右下角
            if(i < m - 1 && j < n - 1){
                lives += *(board + i*n + n + j + 1) == 1 || *(board + i*n + n + j + 1) == 2 ? 1 : 0;
            }
            // 判断右上角
            if(i > 0 && j < n - 1){
                lives += *(board + i*n - n + j + 1) == 1 || *(board + i*n - n + j + 1) == 2 ? 1 : 0;
            }
            // 判断左下角
            if(i < m - 1 && j > 0){
                lives += *(board + i*n + n + j - 1) == 1 || *(board + i*n + n + j - 1) == 2 ? 1 : 0;
            }
            // 根据周边存活数量更新当前点，结果是0和1的情况不用更新
            if(*(board + i*n + j) == 0 && lives == 3){
                *(board + i*n + j) = 3;
            } else if(*(board + i*n + j) == 1){
                if(lives < 2 || lives > 3) *(board + i*n + j) = 2;
            }
        }
    }
    // 解码
    for(int i = 0; i < m; i++){
        for(int j = 0; j < n; j++){
            *(board + i*n + j) = *(board + i*n + j) % 2;
        }
    }
}

void lifeTest()
{
    int arr[][12] = {{1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1},
        {1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0},
        {1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0}};
    
    //  这里用 C 的情况下确实不太懂怎么测试, 我是在打印的里面看该死的细胞有没有死掉, 该活的细胞有没有活着
    for (int i = 0; i < 10; i++) {
        gameLife(*arr, 3, 12);
    }
}




//  ********************   主函数   ******************************   //

#pragma mark- main 函数
int main(int argc, const char * argv[]) {
    
    //  1. Product array
    printf("\n\nProduct array");
    my_productTest();
    
    //  2. Number first
    printf("\n\nNumber first");
    numberFirstTest();
    
    //  4. Simple root square
    printf("\n\nsquare");
    squareTest();
    
    //  5. Power
    printf("\n\nPower");
    my_powerTest();
    
    //  3. Game of Life
    printf("\n\nGame of Life");
    lifeTest();
    
    return 0;
}
