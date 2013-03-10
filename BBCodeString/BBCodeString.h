//
//  BBCodeString.h
//  BBCodeString
//
//  Created by Miha Rataj on 10. 03. 13.
//  Copyright (c) 2013 Miha Rataj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBCodeString : NSMutableAttributedString

@property (nonatomic, copy) NSString *bbCode;

- (id)initWithBBCode:(NSString *)bbCode;

@end
