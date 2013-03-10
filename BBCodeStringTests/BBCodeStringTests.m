//
//  BBCodeStringTests.m
//  BBCodeStringTests
//
//  Created by Miha Rataj on 10. 03. 13.
//  Copyright (c) 2013 Miha Rataj. All rights reserved.
//

#import "BBCodeStringTests.h"
#import "BBCodeString.h"
#import "BBElement.h"

@implementation BBCodeStringTests

#define kUserTag @"user"
#define kFileTag @"file"

- (void)tearDown
{
    [super tearDown];
    
    STAssertTrue(_userTagFontRequested, @"User font not requested");
    STAssertTrue(_fileTagFontRequested, @"File font not requested");
    STAssertTrue(_userTagColorRequested, @"User color not requested");
    STAssertTrue(_fileTagColorRequested, @"File color not requested");
}

- (void)testMakeAttributedString
{
    NSString *bbCode = @"[user id=\"42\"]Mary Jones[/user] sent file [file id=\"23\"]Report.pdf[/file].";
        
    BBCodeString *bbCodeString = [[BBCodeString alloc] initWithBBCode:bbCode andLayoutProvider:self];
    STAssertNotNil(bbCodeString, @"Cannot be nil");
    
    NSString *expectedString = @"Mary Jones sent file Report.pdf.";
    STAssertTrue([bbCodeString.attributedString.string isEqualToString:expectedString], @"Invalid string");
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

@end
