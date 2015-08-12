//
//  WDCustomKeyboard.m
//  WDCustomKeyboard
//
//  Created by zhangyuchen on 15-8-12.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import "WDCustomKeyboard.h"

@implementation WDCustomKeyboard

- (instancetype)initWithTextField:(UITextField *)textfield
{
    self = [super init];
    if (self) {
        _textfield = textfield;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.frame = (CGRect){0,0,320,300};
        textfield.inputView = self;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
//    [@"Hello keyboard" drawInRect:rect
//                   withAttributes:nil];
    [[UIColor redColor] setFill];
    [@"Hello keyboard" drawAtPoint:CGPointMake(rect.size.width / 2, rect.size.height/2)
                          withFont:[UIFont systemFontOfSize:10.f]];
    
    WDKeyboardRef numKeyboard = WDCreateKeyboardByType(WDKeyboardTypeAlphabet);
    
    WDKeyboardShuffleKeys(numKeyboard);

}

@end
