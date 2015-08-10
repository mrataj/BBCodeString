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
    
    _root = parser.element;
    
    [self appendElement:_root];
}

- (BBElement *)getElementByIndex:(NSInteger)characterIndex
{
    return [_root elementAtIndex:characterIndex];
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
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    // Backwards compatibility for version 0.1.0
    if ([self.layoutProvider respondsToSelector:@selector(getFont:)])
    {
        [attributedString setFont:[self.layoutProvider getFont:element]];
    }
    
    // Backwards compatibility for version 0.1.0
    if ([self.layoutProvider respondsToSelector:@selector(getTextColor:)])
    {
        [attributedString setColor:[self.layoutProvider getTextColor:element]];
    }
    
    // This condition is just because of backwards compatibility for version 0.1.0
    if ([self.layoutProvider respondsToSelector:@selector(getAttributesForElement:)])
    {
        NSDictionary *attributes = [self.layoutProvider getAttributesForElement:element];
        for (NSString *attributeName in attributes.allKeys)
        {
            NSRange range = NSMakeRange(0, attributedString.string.length);
            [attributedString addAttribute:attributeName
                                     value:[attributes objectForKey:attributeName]
                                     range:range];
        }
    }
    
    [_attributedString appendAttributedString:attributedString];
}

@end
