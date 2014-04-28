//
//  REDNextButton.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 08.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDNextButton.h"

#import "REDFontManager.h"

@implementation REDNextButton

- (void)awakeFromNib
{
//    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"Welcome"];
//    UIFont *font = [UIFont fontWithName:@"Avenir-Light" size:60];
//    [title addAttribute:NSParagraphStyleAttributeName value:font range:NSMakeRange(0, title.length)];
//    titleView.attributedText = title;
    [self.titleLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:25.0]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
