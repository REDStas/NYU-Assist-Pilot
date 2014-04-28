//
//  REDInformationScreen2.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 09.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDInformationScreen2.h"
#import "REDInformationScreen3.h"

#import "REDFontManager.h"

@interface REDInformationScreen2 ()
{
    IBOutlet UILabel *firstQuestion;
    IBOutlet UILabel *secondQuestion;
    
    IBOutlet UILabel *firstAnswer;
    IBOutlet UILabel *secondAnswer;
    
    IBOutlet UIScrollView *mainScroll;
    
    REDInformationScreen3 *informationScreen3;
}

@end

@implementation REDInformationScreen2

- (void)viewDidLoad
{
    [super viewDidLoad];
    [firstQuestion setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:34.0]];
    [secondQuestion setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:34.0]];
    [firstAnswer setFont:[REDFontManager fontNamed:MuliRegular andSize:26.0]];
    [secondAnswer setFont:[REDFontManager fontNamed:MuliRegular andSize:26.0]];
    
    [mainScroll setContentSize:CGSizeMake(mainScroll.frame.size.width, 1335)];
    
    informationScreen3 = [[REDInformationScreen3 alloc] initWithNibName:@"REDInformationScreen3" bundle:nil];
}

- (IBAction)pressNextButton:(id)sender {
    [self.navigationController pushViewController:informationScreen3 animated:YES];
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
