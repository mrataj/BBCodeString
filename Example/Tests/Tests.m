//
//  BBCodeStringTests.m
//  BBCodeStringTests
//
//  Created by Miha Rataj on 04/07/2015.
//  Copyright (c) 2014 Miha Rataj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "BBCodeStringDelegate.h"
#import "BBCodeString.h"
#import "BBElement.h"

@interface BBCodeStringTests : XCTestCase <BBCodeStringDelegate> {
    BOOL _userTagFontRequested;
    BOOL _fileTagFontRequested;
    BOOL _userTagColorRequested;
    BOOL _fileTagColorRequested;
}

@end

@implementation BBCodeStringTests

#define kUserTag @"user"
#define kFileTag @"file"

- (void)tearDown
{
    [super tearDown];
    
    XCTAssertTrue(_userTagFontRequested, @"User font not requested");
    XCTAssertTrue(_fileTagFontRequested, @"File font not requested");
    XCTAssertTrue(_userTagColorRequested, @"User color not requested");
    XCTAssertTrue(_fileTagColorRequested, @"File color not requested");
}

- (void)testMakeAttributedString
{
    NSString *bbCode = @"[user id=\"42\"]Mary Jones[/user] sent file [file id=\"23\"]Report.pdf[/file].";
    
    BBCodeString *bbCodeString = [[BBCodeString alloc] initWithBBCode:bbCode andLayoutProvider:self];
    XCTAssertNotNil(bbCodeString, @"Cannot be nil");
    
    NSString *expectedString = @"Mary Jones sent file Report.pdf.";
    XCTAssertTrue([bbCodeString.attributedString.string isEqualToString:expectedString], @"Invalid string");
}

- (UIFont *)getFont:(BBElement *)element
{
    if ([element.tag isEqualToString:kUserTag])
        _userTagFontRequested = YES;
    
    if ([element.tag isEqualToString:kFileTag])
        _fileTagFontRequested = YES;
    
    return [UIFont systemFontOfSize:16.0];
}

- (UIColor *)getTextColor:(BBElement *)element
{
    if ([element.tag isEqualToString:kUserTag])
        _userTagColorRequested = YES;
    
    if ([element.tag isEqualToString:kFileTag])
        _fileTagColorRequested = YES;
    
    return [UIColor darkGrayColor];
}

- (NSArray *)getSupportedTags
{
    return [NSArray arrayWithObjects:
            kUserTag,
            kFileTag,
            nil];
}

- (NSDictionary *)getAttributesForElement:(BBElement *)element
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor redColor], NSForegroundColorAttributeName,
                                nil];
    return dictionary;
}

@end