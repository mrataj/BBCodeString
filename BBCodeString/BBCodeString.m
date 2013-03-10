//
//  BBCodeString.m
//  BBCodeString
//
//  Created by Miha Rataj on 10. 03. 13.
//  Copyright (c) 2013 Miha Rataj. All rights reserved.
//

#import "BBCodeString.h"
#import "BBCodeParser.h"
#import "NSMutableAttributedString+BBCodeString.h"

@implementation BBCodeString

- (id)initWithBBCode:(NSString *)bbCode
{
    self = [super init];
    if (self)
    {
        self.bbCode = bbCode;
        
        [self make];
    }
    return self;
}

// todo move outside
- (NSArray *)getTags
{
    return [NSArray arrayWithObjects:
            @"user",
            @"file",
            nil];
}

- (void)make
{
    BBCodeParser *parser = [[BBCodeParser alloc] initWithTags:[self getTags]];
    [parser setCode:self.bbCode];
    [parser parse];
    
    [self appendElement:parser.element];
}

- (void)appendElement:(BBElement *)element
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[BBCodeParser tagRegexPattern]
                                                                           options:0
                                                                             error:nil];
    
    NSArray *matches = [regex matchesInString:element.format options:0 range:NSMakeRange(0, [element.format length])];
    if ([matches count] < 1)
    {
        [self createLabel:element.text forElement:element];
        return;
    }
    
    NSInteger previousIndex = 0;
    for (NSTextCheckingResult *match in matches)
    {
        NSRange range = [match range];
        
        NSString *word = [element.format substringWithRange:NSMakeRange(previousIndex, range.location - previousIndex)];
        [self createLabel:word forElement:element];
        
        NSString *tag = [element.format substringWithRange:range];
        
        NSRegularExpression *tagIndexRegex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+"
                                                                                       options:0
                                                                                         error:nil];
        
        NSTextCheckingResult *tagIndexResult = [[tagIndexRegex matchesInString:tag options:0 range:NSMakeRange(0, tag.length)] objectAtIndex:0];
        NSInteger index = [[tag substringWithRange:tagIndexResult.range] integerValue];
        
        BBElement *subelement = [element.elements objectAtIndex:index];
        [self appendElement:subelement];
        
        previousIndex = range.location + range.length;
    }
    
    NSString *word = [element.format substringFromIndex:previousIndex];
    if ([word length] > 0)
        [self createLabel:word forElement:element];
}

- (void)createLabel:(NSString *)text forElement:(BBElement *)element
{
    if ([text length] == 0)
        return;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    
    // todo move outside
    [string setFont:[UIFont systemFontOfSize:16.0]];
    [string setColor:[UIColor colorWithWhite:0.1 alpha:1.0]];
    
    [self appendAttributedString:string];
}

@end
