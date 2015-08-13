//
//  WDCSkinsManager.h
//  WDCustomKeyboard
//
//  Created by zhangyuchen on 8/13/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WDCKeyboardSkin)
{
    WDCKeyboardSkin1,
    WDCKeyboardSkin2,
    WDCKeyboardSkin3,
};

@interface WDCSkinsManager : NSObject

@property (nonatomic, assign) WDCKeyboardSkin skin;

@end
