//
//  REDResultCell.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 09.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDResultCell.h"

#import "REDFontManager.h"

@implementation REDResultCell

- (void)awakeFromNib
{
    [_categoryTitle setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:23.0]];
    [_riskValue setFont:[REDFontManager fontNamed:MuliRegular andSize:23.0]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
