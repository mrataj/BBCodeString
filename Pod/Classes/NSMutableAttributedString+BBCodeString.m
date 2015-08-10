//
//  NSMutableAttributedString+BBCodeString.m
//  MRAttributedStringRendering
//
//  Created by Miha Rataj on 2. 03. 13.
//  Copyright (c) 2013 Miha Rataj. All rights reserved.
//

#import "NSMutableAttributedString+BBCodeString.h"

@implementation NSMutableAttributedString (BBCodeString)

- (void)setFont:(UIFont *)font
{
    NSRange range = NSMakeRange(0, [self.string length]);
    [self addAttribute:NSFontAttributeName
                 value:font
                 range:range];
}

- (void)setColor:(UIColor *)color
{
    NSRange range = NSMakeRange(0, [self.string length]);
    [self addAttribute:NSForegroundColorAttributeName
                 value:color
                 range:range];
}

@end
