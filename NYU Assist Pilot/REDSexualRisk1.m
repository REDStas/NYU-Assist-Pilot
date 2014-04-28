//
//  REDSexualRisk1.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 17.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDSexualRisk1.h"
#import "REDSexualRisk2.h"

#import "REDFontManager.h"

@interface REDSexualRisk1 ()
{
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *firstParagraph;
    IBOutlet UILabel *secondParagraph;
    
    REDSexualRisk2 *sexualRisk2;
}

@end

@implementation REDSexualRisk1

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
    
    sexualRisk2 = [[REDSexualRisk2 alloc] initWithNibName:@"REDSexualRisk2" bundle:nil];
    
    [headerLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:48.0]];
    [firstParagraph setFont:[REDFontManager fontNamed:MuliRegular andSize:40.0]];
    [secondParagraph setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:40.0]];
}

- (IBAction)pressNextButton:(id)sender {
    [self.navigationController pushViewController:sexualRisk2 animated:YES];
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
