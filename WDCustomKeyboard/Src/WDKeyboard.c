//
//  WDKeyboard.c
//  WDCustomKeyboard
//
//  Created by zhangyuchen on 15-8-12.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#include "WDKeyboard.h"

#include <time.h>

#include <mach/mach.h>
#include <mach/mach_types.h>
#include <mach/mach_time.h>
#ifdef DEBUG

#endif


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
        .numKeySize = AlphabetKeySize,
        .keys = AlphabetKeySet,
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

void
WDKeyboardShuffleKeys(WDKeyboardRef keyboardRef)
{
    if (keyboardRef == NULL) {
        return;
    }
    
    uint32_t keyCount = keyboardRef->keySize;
    char keys[keyCount];
    
    memcpy(keys, keyboardRef->keys, keyCount);
    
    
    printf("keys before shuffle:\n--------->");
    for (int i = 0; i<keyCount; i++) {
        printf(" %c ", keys[i]);
    }
    printf("<---------\n");
    
    mach_timebase_info_data_t info;
    mach_timebase_info(&info);
    uint64_t startTime = mach_absolute_time();
    uint32_t stepCounter = keyCount * 10;
    // how to shift in-place without hit mem/cpu bound ??
    while (stepCounter > 0) {
        u_int32_t srcIdx = arc4random() % keyCount;
        u_int32_t dstIdx = arc4random() % keyCount;
        while (dstIdx == srcIdx) {
            dstIdx = arc4random() % keyCount;
        }
        // replace use xor
        keys[srcIdx] = keys[srcIdx] ^ keys[dstIdx];
        keys[dstIdx] = keys[dstIdx] ^ keys[srcIdx];
        keys[srcIdx] = keys[srcIdx] ^ keys[dstIdx];
        stepCounter--;
    }
    uint64_t endTime = mach_absolute_time();
    uint64_t elapsed = endTime - startTime;
    /* Convert to nanoseconds */
    elapsed *= info.numer;
    elapsed /= info.denom;
    
    printf("keys after shuffle:\n--------->");
    for (int i = 0; i<keyCount; i++) {
        printf(" %c ", keys[i]);
    }
    printf("<---------\n");
    printf("elapsedTime :%llu nanoseconds", (elapsed));
}





