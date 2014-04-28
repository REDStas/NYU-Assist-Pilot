//
//  REDDetailsQuestion.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 16.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDDetailsQuestion.h"

#import "REDFontManager.h"
#import "REDSettings.h"
#import "REDQuestionManager.h"

@interface REDDetailsQuestion ()
{
    NSString *questionKey;
    IBOutlet UILabel *questionText;
    IBOutlet UILabel *subparagraphText;
    
    IBOutlet UIButton *yesButton;
    IBOutlet UIButton *noButton;
    IBOutlet UIButton *dkRefButton;
    IBOutlet UILabel *yesLabel;
    IBOutlet UILabel *noLabel;
    IBOutlet UILabel *dkRefLabel;
    
    NSString *answer;
    NSString *ansverText;
    NSArray *answersArray;
}

@end

@implementation REDDetailsQuestion

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
    answer = @"0";
    ansverText = @"";
    [self customizeElements];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeElements
{
    [questionText setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:34.0]];
    [subparagraphText setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:24.0]];
    [yesLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
    [noLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
    [dkRefLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
}

- (void)fillData:(NSDictionary *)data
{
    questionKey = [data objectForKey:@"questionKey"];
    [questionText setText:[data objectForKey:@"mainQuestion"]];
    [subparagraphText setText:[data objectForKey:@"mainSubparagraph"]];
    answersArray = [data objectForKey:@"answers"];
    
    //NSLog(@"question key :: %@", questionKey);
}

- (IBAction)pressCheckbox:(id)sender {
    [yesButton setSelected:NO];
    [noButton setSelected:NO];
    [dkRefButton setSelected:NO];
    [sender setSelected:YES];
    
    if (sender == yesButton)
    {
        answer = [answersArray objectAtIndex:0];
        ansverText = yesLabel.text;
    } else if (sender == noButton)
    {
        answer = [answersArray objectAtIndex:1];
        ansverText = noLabel.text;
    }
    else if (sender == dkRefButton)
    {
        answer = [answersArray objectAtIndex:2];
        ansverText = dkRefLabel.text;
    }
}

- (IBAction)pressNextButton:(id)sender {
    NSLog(@"questionKey %@", questionKey);
    [[REDSettings sharedSettings] addAnswer:ansverText ofQuestionKey:questionKey];
    UIViewController *viewController = (UIViewController *)[[REDQuestionManager sharedQuestionManager] nextQuestionWithLastQuestionKey:questionKey andLastQuestionAnswer:answer];
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"finishTesting" object:nil];
    }
}

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden // in iOS 7
{
    return YES;
}

@end
