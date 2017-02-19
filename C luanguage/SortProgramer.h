//
//  SortProgramer.h
//  AdapteTableviewHight
//
//  Created by lhp3851 on 2016/10/23.
//  Copyright © 2016年 lhp3851. All rights reserved.
//

#ifndef SortProgramer_h
#define SortProgramer_h

#include <stdio.h>
//冒泡排序
void bubble_sort(int a[], int n);

/**
 插入排序

 @param data    要排序的data
 @param size    data 的数据个数
 @param esize   每个数据元素的大小
 @param compare 指向用户定义的比较函数，比较大小

 @return 插入排序结果
 */
int issort(void *data,int size,int esize,int (*compare)(const void *key1,const void *key2));



/**
 快速排序

 @param data    要排序的data
 @param size    data 的数据个数
 @param esize   每个数据元素的大小
 @param i       排序区i
 @param k       排序区k
 @param compare 指向用户定义的比较函数，比较大小

 @return 快速排序结果
 */
int qksort(void *data,int size,int esize,int i,int k,int(* compare)(const void *key1,const void *key2));

#endif /* SortProgramer_h */
