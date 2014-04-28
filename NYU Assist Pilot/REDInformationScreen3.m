//
//  REDInformationScreen3.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 10.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDInformationScreen3.h"
#import "REDViewController5.h"
#import "REDCloseScreen3.h"

#import "REDFontManager.h"
#import "REDSettings.h"

@interface REDInformationScreen3 ()
{
    IBOutlet UILabel *firstQuestion;
    IBOutlet UILabel *secondQuestion;
    IBOutlet UILabel *thirdQuestion;
    
    IBOutlet UILabel *firstAnswer;
    IBOutlet UILabel *secondAnswer;
    
    IBOutlet UIButton *yesButton;
    IBOutlet UIButton *noButton;
    
    IBOutlet UIScrollView *mainScroll;
    
    REDViewController5 *vk5;
    REDCloseScreen3 *closeScreen3;
}

@end

@implementation REDInformationScreen3

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [firstQuestion setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:34.0]];
    [secondQuestion setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:34.0]];
    [thirdQuestion setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:34.0]];
    
    [firstAnswer setFont:[REDFontManager fontNamed:MuliRegular andSize:26.0]];
    [secondAnswer setFont:[REDFontManager fontNamed:MuliRegular andSize:26.0]];
    
    [yesButton.titleLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:20.0]];
    [noButton.titleLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:20.0]];
    
    [mainScroll setContentSize:CGSizeMake(mainScroll.frame.size.width, 1150)];
    
    vk5 = [[REDViewController5 alloc] initWithNibName:@"REDViewController5" bundle:nil];
    closeScreen3 = [[REDCloseScreen3 alloc] initWithNibName:@"REDCloseScreen3" bundle:nil];
}

- (IBAction)pressYesButton:(id)sender {
    [[REDSettings sharedSettings] setConsent:@"Yes"];
    [self.navigationController pushViewController:vk5 animated:YES];
}

- (IBAction)pressNoButton:(id)sender {
    [[REDSettings sharedSettings] setConsent:@"No"];
    [self.navigationController pushViewController:closeScreen3 animated:YES];
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
