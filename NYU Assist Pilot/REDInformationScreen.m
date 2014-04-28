//
//  REDInformationScreen.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 09.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDInformationScreen.h"
#import "REDInformationScreen2.h"

#import "REDFontManager.h"

@interface REDInformationScreen ()
{
    IBOutlet UILabel *textLabel;
    
    IBOutlet UIScrollView *mainScroll;
    
    REDInformationScreen2 *informationScreen2;
}

@end

@implementation REDInformationScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    informationScreen2 = [[REDInformationScreen2 alloc] initWithNibName:@"REDInformationScreen2" bundle:nil];
    [textLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:26.0]];
    
    [mainScroll setContentSize:CGSizeMake(mainScroll.frame.size.width, 1020)];
}

- (IBAction)pressNextButton:(id)sender {
    [self.navigationController pushViewController:informationScreen2 animated:YES];
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
