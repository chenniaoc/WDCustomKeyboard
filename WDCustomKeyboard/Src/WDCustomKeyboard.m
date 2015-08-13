//
//  WDCustomKeyboard.m
//  WDCustomKeyboard
//
//  Created by zhangyuchen on 15-8-12.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import "WDCustomKeyboard.h"


extern inline NSArray *
WDC_GetKeyListFromKeyboardRef(WDKeyboardRef kbr);

extern inline UIImage*
WDC_DrawKeyWithChar(NSString *keyStr);





@interface WDCustomKeyboard ()
{
    WDKeyboardRef m_currentKeyboardRef;
    NSMutableArray *m_currentKeysButtons;
}


@end

@implementation WDCustomKeyboard

- (void)_initialze
{
    m_currentKeyboardRef = NULL;
    m_currentKeysButtons = [NSMutableArray arrayWithCapacity:26];
    
    self.frame = (CGRect){0,0,320,300};
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (instancetype)initWithTextField:(UITextField *)textfield
{
    self = [super init];
    if (self) {
        [self _initialze];
        _textfield = textfield;
        textfield.inputView = self;
        textfield.inputAccessoryView = [self p_createToolbarView];
    }
    return self;
}


#pragma mark TopToolBar
- (UIView *)p_createToolbarView
{
    UIFont *titleFont = [UIFont systemFontOfSize:14.0f];
    UIView *toolbarView = [[UIView alloc] initWithFrame:(CGRect){0,0,[UIScreen mainScreen].bounds.size.width,50}];
    UIColor *titleColor = [UIColor darkGrayColor];
    
    const NSInteger buttonTotal = 4;
    
    CGFloat buttonWidth = toolbarView.frame.size.width / buttonTotal;
    
    toolbarView.backgroundColor = [UIColor colorWithRed:232.0f/255
                                                  green:240.0f/255
                                                   blue:248.0f/255
                                                  alpha:1.0f];
    
    CGFloat offsetX = 0;
    UIButton *changeTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeTypeButton.frame = CGRectMake(offsetX, 0, buttonWidth, 50);
    changeTypeButton.titleLabel.font = titleFont;
    [changeTypeButton setTitleColor:titleColor forState:UIControlStateNormal];
    [changeTypeButton setTitle:@"Change Type" forState:UIControlStateNormal];
    [changeTypeButton addTarget:self action:@selector(p_changeType:) forControlEvents:UIControlEventTouchUpInside];
    [toolbarView addSubview:changeTypeButton];
    
    
    offsetX += buttonWidth;
    UIButton *changeSkinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeSkinButton.frame = CGRectMake(offsetX, 0, buttonWidth, 50);
    changeSkinButton.titleLabel.font = titleFont;
    [changeSkinButton setTitleColor:titleColor forState:UIControlStateNormal];
    [changeSkinButton setTitle:@"Change Skin" forState:UIControlStateNormal];
    [changeSkinButton addTarget:self action:@selector(p_changeSkins:) forControlEvents:UIControlEventTouchUpInside];
    [toolbarView addSubview:changeSkinButton];
    
    
    offsetX += buttonWidth;
    UIButton *recoverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    recoverButton.frame = CGRectMake(offsetX, 0, buttonWidth, 50);
    recoverButton.titleLabel.font = titleFont;
    [recoverButton setTitleColor:titleColor forState:UIControlStateNormal];
    [recoverButton setTitle:@"Recover Keys" forState:UIControlStateNormal];
    [recoverButton addTarget:self action:@selector(p_recoverKeys:) forControlEvents:UIControlEventTouchUpInside];
    [toolbarView addSubview:recoverButton];
    
    
    offsetX += buttonWidth;
    UIButton *shuffleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shuffleButton.frame = CGRectMake(offsetX, 0, buttonWidth, 50);
    shuffleButton.titleLabel.font = titleFont;
    [shuffleButton setTitleColor:titleColor forState:UIControlStateNormal];
    [shuffleButton setTitle:@"Random Keys" forState:UIControlStateNormal];
    [shuffleButton addTarget:self action:@selector(p_randomKeys:) forControlEvents:UIControlEventTouchUpInside];
    [toolbarView addSubview:shuffleButton];
    
    
    return toolbarView;
}

- (void)p_changeSkins:(UIButton *)button
{
    WDCKeyboardSkin currentSKin = [WDCSkinsManager sharedInstance].skin;
    WDCKeyboardSkin nextSkin = (currentSKin + 1) % WDCKeyboardSkinTotal;
    [[WDCSkinsManager sharedInstance] setSkin:nextSkin];
    
    [self p_setupButtonsWithKeyboardRef:m_currentKeyboardRef];
    [self setNeedsDisplay];
}


- (void)p_randomKeys:(UIButton *)button
{
    WDKeyboardShuffleKeys(m_currentKeyboardRef);
    [self p_setupButtonsWithKeyboardRef:m_currentKeyboardRef];
    [self setNeedsDisplay];
}


- (void)p_changeType:(UIButton *)button
{
    
    WDCKeyboardType nextType;//= _keyboardStyle;
    nextType = ((_keyboardType + 1) % WDKeyboardTypeTotal);
    self.keyboardType = nextType;
    [self setNeedsDisplay];
}

- (void)p_recoverKeys:(UIButton *)button
{
    WDKeyboardRecoverKeys(m_currentKeyboardRef);
    [self p_setupButtonsWithKeyboardRef:m_currentKeyboardRef];
    [self setNeedsDisplay];
    
}


#pragma mark Style

- (void)setKeyboardType:(WDCKeyboardType)keyboardType
{
    if (_keyboardType != keyboardType) {
        _keyboardType = keyboardType;
        
        if (m_currentKeyboardRef) {
            WDKeyboardRelease(m_currentKeyboardRef);
        }
        
        switch (keyboardType) {
            case WDCKeyboardTypeNormal:
            {
                m_currentKeyboardRef = WDCreateKeyboardByType(WDKeyboardTypeNormal);
            }
                break;
            case WDCKeyboardTypeNumeric:
            {
                m_currentKeyboardRef = WDCreateKeyboardByType(WDKeyboardTypeNumeric);
            }
                break;
            case WDCKeyboardTypeAlphabet:
            {
                m_currentKeyboardRef = WDCreateKeyboardByType(WDKeyboardTypeAlphabet);
            }
                break;
                
            default:
                break;
        }
        
        [self p_setupButtonsWithKeyboardRef:m_currentKeyboardRef];
        
    }
}

- (void)p_setupButtonsWithKeyboardRef:(WDKeyboardRef)kbr
{
    NSArray *keysList = WDC_GetKeyListFromKeyboardRef(kbr);
    // reuse button if existed
    if (m_currentKeysButtons.count > 0) {
        [m_currentKeysButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
    }
    
    
    [keysList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *keyStr = obj;
        BOOL isReuse = idx < m_currentKeysButtons.count;
        
        UIButton *b = nil;
        if (isReuse) {
            b = [m_currentKeysButtons objectAtIndex:idx];
        } else {
            b = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        
        UIImage *keyImage = WDC_DrawKeyWithChar(keyStr);
        [b setImage:keyImage forState:UIControlStateNormal];
        b.frame = CGRectMake(0, 0, keyImage.size.width, keyImage.size.height);
        b.tag = idx;
        [b addTarget:self
              action:@selector(keyButtonPressed:)
    forControlEvents:UIControlEventTouchUpInside];
        
        if (isReuse) {
            return;
        } else {
            [m_currentKeysButtons addObject:b];
        }
        
    }];
    
    NSUInteger diff = (m_currentKeysButtons.count - kbr->keySize);
    if (diff > 0) {
        [m_currentKeysButtons removeObjectsInRange:NSMakeRange(m_currentKeysButtons.count - diff, diff)];
    }

}



- (void)drawRect:(CGRect)rect
{
    [[WDCSkinsManager sharedInstance].theme.keyBgColor setFill];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextFillRect(ctx, rect);
    
    [self arrangeKeyButtonsInRect:rect];
}

- (void)arrangeKeyButtonsInRect:(CGRect)rect
{
 
    
    UIButton *testButon = [m_currentKeysButtons objectAtIndex:0];
    
    CGFloat tailSpace = 30;
    __block CGFloat offsetY = 0;
    __block CGFloat offSetx = -testButon.bounds.size.width;
    
    // may be config layout by keyboard type
    
    
    
    // reuse button if existed
    [m_currentKeysButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = obj;
        if (button.superview != self) {
            [self addSubview:button];
        }
        
        CGRect f = button.frame;
        if ((offSetx + testButon.frame.size.width * 2 + tailSpace) > rect.size.width) {
            // line break
            offSetx = 0;
            offsetY += testButon.frame.size.height;
        } else {
            offSetx += testButon.frame.size.width;
        }
        f.origin.x = offSetx;
        f.origin.y = offsetY;
        
        button.frame = f;
    }];
    
}

- (void)keyButtonPressed:(UIButton *)button
{
    NSUInteger keyIdx = button.tag;
    
    char pressedKey = m_currentKeyboardRef->keys[keyIdx];
    
    _textfield.text = [NSString stringWithFormat:@"%@%c", _textfield.text, pressedKey];
}


@end


inline NSArray *
WDC_GetKeyListFromKeyboardRef(WDKeyboardRef kbr)
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:30];
    
    for (int i = 0; i<kbr->keySize; i++) {
        char k = kbr->keys[i];
        NSString *keyStr = [NSString stringWithFormat:@"%c", k];
        [array addObject:keyStr];
    }
    
    return array;
}




inline UIImage*
WDC_DrawKeyWithChar(NSString *keyStr)
{
    UIImage *resultImg = nil;
    WDKeyboardSkinTheme *keyboardSkin = [WDCSkinsManager sharedInstance].theme;
    UIFont *keyFont = keyboardSkin.keyFont;
    CGSize keySize = keyboardSkin.keySize;
    CGRect keyBounds = CGRectMake(0, 0, keySize.width, keySize.height);
    
    UIGraphicsBeginImageContextWithOptions(keySize, YES, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    // draw key background
    [keyboardSkin.keyBgColor setFill];
    [keyboardSkin.keyBgBorderColor setStroke];
    CGContextFillRect(ctx, keyBounds);
    CGContextStrokeRect(ctx, keyBounds);
    
    
    // draw key character
    [keyboardSkin.keyColor setFill];
    [keyStr drawInRect:keyBounds
              withFont:keyFont
         lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    // retrive image object
    resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImg;
}

