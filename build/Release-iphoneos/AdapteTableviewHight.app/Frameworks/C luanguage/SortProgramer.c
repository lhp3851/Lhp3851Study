//
//  SortProgramer.c
//  AdapteTableviewHight
//
//  Created by lhp3851 on 2016/10/23.
//  Copyright © 2016年 lhp3851. All rights reserved.
//

#include "SortProgramer.h"
#include <stdlib.h>
#include <string.h>

#pragma  mark 冒泡排序
void bubble_sort(int a[], int n)
{
    int i, j, temp;
    for (j = 0; j < n - 1; j++)
        for (i = 0; i < n - 1 - j; i++)
        {
            if(a[i] > a[i + 1])
            {
                temp = a[i];
                a[i] = a[i + 1];
                a[i + 1] = temp;
            }
        }
}

#pragma mark 插入排序
int issort(void *data,int size,int esize,int (*compare)(const void *key1,const void *key2)){
    char *a=data;
    void *key;
    int  i,
    j;
    if ((key=(char *)malloc(esize))==NULL) {
        return -1;
    }
    
    for (j=1; j<size; j++) {
        memcpy(key,&a[j*esize],esize);
        i=j-1;
        
        while (i>0 && compare(&a[i*esize],key)>0) {
            memcpy(&a[(i+1)*esize], &a[i*esize], esize);
            i--;
        }
        memcpy(&a[(i+1)*esize], key, esize);
        
    }
    //free the storage allocated for sorting;
    free(key);
    
    return 0;
}

#pragma  mark 快速排序
//比较两个数的大小
static int compare_int(const void *int1,const void *int2){
    if (*(const int *)int1 > *(const int *)int2)
        return 1;
    else if (*(const int *)int1 < *(const int *)int2)
        return -1;
    else
        return 0;
}

//partion,To find the medium
static int partion(void *data,int esize,int i,int k,int(* compare)(const void *key1,const void *key2)){
    char *a=data;
    void *pval,
         *temp;
    int   r[3];
    
    if ((pval=malloc(esize))==NULL) {
        return -1;
    }
    
    if ((temp=malloc(esize))==NULL) {
        free(pval);
        return -1;
    }
    
    r[0]=(rand() % (k-i+1))+i;
    r[1]=(rand() % (k-i+1))+i;
    r[2]=(rand() % (k-i+1))+i;
    
    issort(r, 3, sizeof(int), compare_int);
    
    memcpy(pval, &a[r[1]*esize], esize);
    
    i--;
    k++;
    
    while (1) {
        do {
            k--;
        } while (compare(&a[k*esize],pval)>0);
        
        do {
            i++;
        } while (compare(&a[i*esize],pval)<0);
        
        if (i>=k) {
            break;
        }
        else{
            memcpy(temp, &a[i*esize], esize);
            memcpy(&a[i*esize], &a[k*esize], esize);
            memcpy(&a[k*esize], temp, esize);
        }
    }
    
    free(pval);
    free(temp);
    
    return k;
}

int qksort(void *data,int size,int esize,int i,int k,int(* compare)(const void *key1,const void *key2))
{
    int j;
    while (i<k) {
        if ((j=partion(data, esize, i, k, compare))<0) {
            return -1;
        }
        
        if (qksort(data, size, esize, i,j,compare)<0) {
            return -1;
        }
        
        i=j+1;
    }
    return 0;
}






