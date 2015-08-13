//
//  WDCSkinsManager.m
//  WDCustomKeyboard
//
//  Created by zhangyuchen on 8/13/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "WDCSkinsManager.h"

@implementation WDKeyboardSkinTheme

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.keyFont = [UIFont systemFontOfSize:22.0f];
        self.keySize = CGSizeMake(30, self.keyFont.lineHeight + 5);
        self.keyBgBorderColor = [UIColor blackColor];
        self.keyBgColor = [UIColor colorWithRed:193.0f / 255.f green:113.0f / 255.f blue:2.0f / 255.f alpha:1.0f];
        self.keyColor = [UIColor whiteColor];
    }
    return self;
}

@end

@interface WDCSkinsManager ()
{
    WDKeyboardSkinTheme *m_currentTheme;
}

@end

@implementation WDCSkinsManager

+ (instancetype)sharedInstance
{
    static WDCSkinsManager *_self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _self = [WDCSkinsManager new];
    });
    
    return _self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self _initialize];
    }
    return self;
}

- (void)_initialize
{
    self->m_currentTheme = [WDKeyboardSkinTheme new];
}


- (WDKeyboardSkinTheme *)theme
{
    switch (self.skin) {
        case WDCKeyboardSkinDefault1:
        {
            m_currentTheme.keyFont = [UIFont systemFontOfSize:22.0f];
            m_currentTheme.keySize = CGSizeMake(40, m_currentTheme.keyFont.lineHeight + 5);
            m_currentTheme.keyBgBorderColor = [UIColor colorWithRed:193.0f / 255.f green:113.0f / 255.f blue:2.0f / 255.f alpha:1.0f];
            m_currentTheme.keyBgColor = [UIColor colorWithRed:193.0f / 255.f green:113.0f / 255.f blue:2.0f / 255.f alpha:1.0f];
            m_currentTheme.keyColor = [UIColor whiteColor];
        }
            break;
        case WDCKeyboardSkinDefault2:
        {
            m_currentTheme.keyFont = [UIFont systemFontOfSize:22.0f];
            m_currentTheme.keySize = CGSizeMake(50, m_currentTheme.keyFont.lineHeight + 5);
            m_currentTheme.keyBgBorderColor = [UIColor lightGrayColor];
            m_currentTheme.keyBgColor = [UIColor whiteColor];
            m_currentTheme.keyColor = [UIColor blackColor];
        }
            break;
        case WDCKeyboardSkinDefault3:
        {
            m_currentTheme.keyFont = [UIFont boldSystemFontOfSize:22.0f];
            m_currentTheme.keySize = CGSizeMake(100, m_currentTheme.keyFont.lineHeight + 5);
            m_currentTheme.keyBgBorderColor = [UIColor lightGrayColor];
            m_currentTheme.keyBgColor = [UIColor blackColor];
            m_currentTheme.keyColor = [UIColor whiteColor];
        }
            break;
            
        default:
            break;
    }
    
    return m_currentTheme;
    
}

@end
