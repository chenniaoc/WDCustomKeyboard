//
//  WDCSkinsManager.h
//  WDCustomKeyboard
//
//  Created by zhangyuchen on 8/13/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



#define WDCKeyboardSkinTotal 3

typedef NS_ENUM(NSInteger, WDCKeyboardSkin)
{
    WDCKeyboardSkinDefault1,
    WDCKeyboardSkinDefault2,
    WDCKeyboardSkinDefault3,
};

@class WDKeyboardSkinTheme;

@interface WDCSkinsManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) WDCKeyboardSkin skin;

@property (nonatomic, strong, readonly) WDKeyboardSkinTheme *theme;

@end


@interface WDKeyboardSkinTheme : NSObject

@property (nonatomic, strong) UIFont *keyFont;

@property (nonatomic, strong) UIColor *keyBgColor;

@property (nonatomic, strong) UIColor *keyBgBorderColor;

@property (nonatomic, strong) UIColor *keyColor;

@property (nonatomic, assign) CGSize keySize;

@end
