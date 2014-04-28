//
//  REDMainQuestionCell.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 14.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDMainQuestionCell.h"

#import "REDFontManager.h"

@implementation REDMainQuestionCell
{
    IBOutlet UIButton *noButton;
    IBOutlet UIButton *yesButton;
}

- (IBAction)pressCheckBox:(id)sender {
    [noButton setSelected:NO];
    [yesButton setSelected:NO];
    [sender setSelected:YES];
    if (sender == noButton)
        _isPositive = NO;
    else
        _isPositive = YES;
    
    if (_delegate) {
        [_delegate changeSubparagraphActivity:_isPositive atIndex:self.tag];
    }
}

- (void)awakeFromNib
{
    [_titleLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
}
     
- (void)changeActivity
{
    [noButton setSelected:NO];
    [yesButton setSelected:NO];
    if (_isPositive)
        [yesButton setSelected:YES];
    else
        [noButton setSelected:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
