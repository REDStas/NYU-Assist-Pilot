//
//  REDCloseScreen3.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 09.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDCloseScreen3.h"

#import "REDFontManager.h"

@interface REDCloseScreen3 ()
{
    IBOutlet UILabel *headerLabel;
    
}

@end

@implementation REDCloseScreen3

- (void)viewDidLoad
{
    [super viewDidLoad];
    [headerLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:34.0]];
}

- (IBAction)restart:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pressPrevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden // in iOS 7
{
    return YES;
}

@end
