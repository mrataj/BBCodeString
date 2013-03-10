//
//  BBCodeStringTests.m
//  BBCodeStringTests
//
//  Created by Miha Rataj on 10. 03. 13.
//  Copyright (c) 2013 Miha Rataj. All rights reserved.
//

#import "BBCodeStringTests.h"
#import "BBCodeString.h"

@implementation BBCodeStringTests

- (void)testMakeAttributedString
{
    NSString *bbCode = @"[user id=\"42\"]Mary Jones[/user] sent file [file id=\"23\"]Report.pdf[/file] to professor [user id=\"43\"]Gary Durkheim[/user] this morning.\nI hope you see this before afternoon.";
        
    BBCodeString *bbCodeString = [[BBCodeString alloc] initWithBBCode:bbCode];
    STAssertNotNil(bbCodeString, @"Cannot be nil");
}

@end
