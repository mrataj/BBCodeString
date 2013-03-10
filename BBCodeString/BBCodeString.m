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

- (id)init
{
    @throw @"Call initWithBBCode:andLayoutProvider: instead.";
}

- (id)initWithBBCode:(NSString *)bbCode andLayoutProvider:(id<BBCodeStringDelegate>)layoutProvider
{
    self = [super init];
    if (self)
    {
        _bbCode = bbCode;
        
        _layoutProvider = layoutProvider;
        
        [self make];
    }
    return self;
}

- (void)make
{
    _attributedString = [[NSMutableAttributedString alloc] init];
    
    BBCodeParser *parser = [[BBCodeParser alloc] initWithTags:[self.layoutProvider getSupportedTags]];
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
    
    [string setFont:[self.layoutProvider getFont:element]];
    [string setColor:[self.layoutProvider getTextColor:element]];
    
    [_attributedString appendAttributedString:string];
}

@end
