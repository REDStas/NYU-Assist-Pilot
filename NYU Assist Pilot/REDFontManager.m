//
//  REDFontManager.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 08.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDFontManager.h"

@implementation REDFontManager

+ (UIFont *)fontNamed:(FontName)fontName andSize:(CGFloat)size
{
    switch (fontName) {
        case MuliItalic:
            return [UIFont fontWithName:@"Muli-Italic" size:size];
            break;
        case MuliLight:
            return [UIFont fontWithName:@"Muli-Light" size:size];
            break;
        case MuliLightItalic:
            return [UIFont fontWithName:@"Muli-LightItalic" size:size];
            break;
        case MuliRegular:
            return [UIFont fontWithName:@"Muli" size:size];
            break;
        case HammersmithOneRegular:
            return [UIFont fontWithName:@"HammersmithOne-Regular" size:size];
            break;
        case ZapfDingbatsStd:
            return [UIFont fontWithName:@"ZapfDingbatsStd" size:size];
            break;
            
        default:
            break;
    }
    return nil;
}

@end
