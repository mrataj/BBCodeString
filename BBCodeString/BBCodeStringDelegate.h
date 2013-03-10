//
//  BBCodeStringDelegate.h
//  BBCodeString
//
//  Created by Miha Rataj on 10. 03. 13.
//  Copyright (c) 2013 Miha Rataj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBElement;

@protocol BBCodeStringDelegate <NSObject>

- (UIFont *)getFont:(BBElement *)element;
- (UIColor *)getTextColor:(BBElement *)element;
- (NSArray *)getSupportedTags;

@end
