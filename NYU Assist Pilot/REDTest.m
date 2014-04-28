//
//  REDTest.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 10.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDTest.h"
#import "REDDemographicsScreen.h"

@interface REDTest ()
{
    REDDemographicsScreen *vk6;
}

@end

@implementation REDTest

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
    vk6 = [[REDDemographicsScreen alloc] initWithNibName:@"REDDemographicsScreen" bundle:nil];
}

- (IBAction)pressNextButton:(id)sender {
    [self.navigationController pushViewController:vk6 animated:YES];
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
