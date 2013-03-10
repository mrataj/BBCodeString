//
//  BBCodeStringTests.h
//  BBCodeStringTests
//
//  Created by Miha Rataj on 10. 03. 13.
//  Copyright (c) 2013 Miha Rataj. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "BBCodeStringDelegate.h"

@interface BBCodeStringTests : SenTestCase <BBCodeStringDelegate> {
    BOOL _userTagFontRequested;
    BOOL _fileTagFontRequested;
    BOOL _userTagColorRequested;
    BOOL _fileTagColorRequested;
}

@end
