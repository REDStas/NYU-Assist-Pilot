//
//  REDValidation.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 09.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDValidation.h"

@implementation REDValidation

+ (BOOL)isNumber1And99Between:(NSString*)numberString
{
    NSString *expression = @"^(([1-9][0-9]?)|100)?$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:numberString options:0 range:NSMakeRange(0, [numberString length])];
    
    if (numberOfMatches == 0)
        return NO;
    else
        return YES;
}

@end
