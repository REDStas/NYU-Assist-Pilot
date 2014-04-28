//
//  REDViewController5.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 08.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDViewController5.h"
#import "REDTest.h"
#import "REDTestNavigationController.h"
#import "REDMainQuestion.h"
#import "REDDemographicsScreen.h"

#import "REDFontManager.h"

@interface REDViewController5 ()
{
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *bodyLabel;
    IBOutlet UILabel *firstOptionParagraph;
    IBOutlet UILabel *secondOptionParagraph;
    IBOutlet UILabel *firstOptionLabel;
    IBOutlet UILabel *secondOptionLabel;
    
    REDTest *vk6;
    REDDemographicsScreen *demographicsScreen;
    
    REDMainQuestion *mainQuestion;
    REDTestNavigationController *testNavigationController;
}

@end

@implementation REDViewController5

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTest) name:@"finishTesting" object:nil];

    vk6 = [[REDTest alloc] initWithNibName:@"REDTest" bundle:nil];
    demographicsScreen = [[REDDemographicsScreen alloc] initWithNibName:@"REDDemographicsScreen" bundle:nil];
    
    
    [headerLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:36.0]];
    [bodyLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:25.0]];
    [firstOptionParagraph setFont:[REDFontManager fontNamed:MuliRegular andSize:25.0]];
    [secondOptionParagraph setFont:[REDFontManager fontNamed:MuliRegular andSize:25.0]];
    [firstOptionLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:26.0]];
    [secondOptionLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:26.0]];
}

- (IBAction)pressNextButton:(id)sender {
    mainQuestion = [[REDMainQuestion alloc] initWithNibName:@"REDMainQuestion" bundle:nil];
    testNavigationController = [[REDTestNavigationController alloc] initWithRootViewController:mainQuestion];
    [self presentViewController:testNavigationController animated:YES completion:^{
        
    }];
}

- (void)closeTest
{
    if (testNavigationController) {
        [testNavigationController dismissViewControllerAnimated:NO completion:^{
            [self.navigationController pushViewController:demographicsScreen animated:YES];
        }];
    }
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
