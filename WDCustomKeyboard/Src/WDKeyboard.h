//
//  WDKeyboard.h
//  WDCustomKeyboard
//
//  Created by zhangyuchen on 15-8-12.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#ifndef __WDCustomKeyboard__WDKeyboard__
#define __WDCustomKeyboard__WDKeyboard__
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#endif /* defined(__WDCustomKeyboard__WDKeyboard__) */

/**
 键盘种类总数
 */
#define WDKeyboardTypeTotal 3


/**
 键盘类型定义,
 索引必须从0开始。
 */
typedef enum {
    WDKeyboardTypeNumeric = 0, // 数字键盘
    WDKeyboardTypeNormal,      // 普通键盘
    WDKeyboardTypeAlphabet,    // only 英文字母
} WDKeyboardType;


struct _WDKeyboard
{
    WDKeyboardType keyboardType;
    uint32_t flags;
    uint32_t keySize;
    char *keys;
    
} WDKeyboard;

typedef struct _WDKeyboard  * WDKeyboardRef;


/**
 *  根据键盘类型返回一个键盘定义的struct指针
 *  用完需要自己free掉。
 *
 *  @param type 键盘类型 WDKeyboardType
 *
 *  @return 新生成的键盘数据结构定义,用完记得free。
 */
extern
WDKeyboardRef
WDCreateKeyboardByType(WDKeyboardType type);

/**
 *  打乱按键顺序
 *
 *  @param keyboardRef keys里面的字符序列会被随机打乱
 */
extern
void
WDKeyboardShuffleKeys(WDKeyboardRef keyboardRef);

/**
 *  恢复打乱的顺序，按照默认排序
 *
 *  @param keyboardRef keys里面的字符序列会被随机打乱
 */
extern
void
WDKeyboardRecoverKeys(WDKeyboardRef keyboardRef);

/**
 * 释放WDKeyboardRef 资源
 */
extern
void
WDKeyboardRelease(WDKeyboardRef keyboardRef);


