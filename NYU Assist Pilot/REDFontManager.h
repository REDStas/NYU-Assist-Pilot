//
//  REDFontManager.h
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 08.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FontName) {
    MuliLight,
    MuliLightItalic,
    MuliRegular,
    MuliItalic,
    HammersmithOneRegular,
    ZapfDingbatsStd,
};

@interface REDFontManager : NSObject

+ (UIFont *)fontNamed:(FontName)fontName andSize:(CGFloat)size;

@end
