//
//  WDKeyboard.c
//  WDCustomKeyboard
//
//  Created by zhangyuchen on 15-8-12.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#include "WDKeyboard.h"


#define NumericKeySet "1234567890"
#define NumericKeySize strlen(NumericKeySet)

#define AlphabetKeySet "abcdefghijklmnopqrstuvwxyz"
#define AlphabetKeySize strlen(AlphabetKeySet)



typedef struct _KeyInfo
{
    uint32_t numKeySize;
    char *keys;
}KeyInfo;


//struct
//{
//    KeyInfo keyboards[WDKeyboardTypeTotal];
//    
//}
KeyInfo KeyInfoTable[WDKeyboardTypeTotal] =
{
//    .keyboards[WDKeyboardTypeNumeric] =
    {
        .numKeySize = NumericKeySize,
        .keys = NumericKeySet,
    },
//    .keyboards[WDKeyboardTypeNormal] =
    {
        .numKeySize = AlphabetKeySize,
        .keys = AlphabetKeySet,
    },
//    .keyboards[WDKeyboardTypeAlphabet] =
    {
        
    },

};



WDKeyboardRef
WDCreateKeyboardByType(WDKeyboardType type)
{
    WDKeyboardRef keyboardRef = malloc(sizeof(WDKeyboard));
    
    KeyInfo keyinfo = KeyInfoTable[type];
    keyboardRef->keyboardType = type;
    keyboardRef->keySize = keyinfo.numKeySize;
    keyboardRef->keys = keyinfo.keys;
    
    
    switch (type) {
        case WDKeyboardTypeNormal:
        {
            
        }
            break;
            // to do
        default:
            break;
    }
    
    return keyboardRef;
}