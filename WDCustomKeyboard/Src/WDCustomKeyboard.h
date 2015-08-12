//
//  WDCustomKeyboard.h
//  WDCustomKeyboard
//
//  Created by zhangyuchen on 15-8-12.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WDKeyboard.h"

//typedef enum : NSUInteger {
//    WDKeyboardTypeNumeric,
//    WDKeyboardTypeNormal,
//    WDKeyboardTypeAlphabet,
//} WDKeyboardType;
//
//
//struct
//{
//    WDKeyboardType keyboardType;
//    UInt32 flags;
//    UInt32 keySize;
//    char *keys;
//    
//} WDKeyboard;
//
//typedef struct WDKeyboard  * WDKeyboardRef;
//
//extern
//WDKeyboardRef
//WDCreateKeyboardByType(WDKeyboardType type);




@interface WDCustomKeyboard : UIView

@property (nonatomic, weak) UITextField *textfield;

- (instancetype)initWithTextField:(UITextField *)textfield;

@end