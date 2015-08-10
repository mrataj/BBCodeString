//
//  BBCodeStringDelegate.h
//  BBCodeString
//
//  Created by Miha Rataj on 10. 03. 13.
//  Copyright (c) 2013 Miha Rataj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BBElement;

@protocol BBCodeStringDelegate <NSObject>

@optional

/** Deprecated. Returns the font for the given BBCode element. **/
- (UIFont *)getFont:(BBElement *)element;

/** Deprecated. Returns the text color for the given BBCode element. **/
- (UIColor *)getTextColor:(BBElement *)element;

@required

/** Returns the whitelist of the BBCode tags your code supports. **/
- (NSArray *)getSupportedTags;

/** Returns the attributes for the part of NSAttributedString which will present the given BBCode element.  **/
- (NSDictionary *)getAttributesForElement:(BBElement *)element;

@end
