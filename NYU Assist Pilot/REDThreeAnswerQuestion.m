//
//  REDThreeAnswerQuestion.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 22.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDThreeAnswerQuestion.h"

#import "REDFontManager.h"
#import "REDSettings.h"
#import "REDQuestionManager.h"

@interface REDThreeAnswerQuestion ()
{
    NSString *questionKey;
    IBOutlet UILabel *questionText;
    IBOutlet UILabel *subparagraphText;
    
    IBOutlet UIButton *neverButton;
    IBOutlet UIButton *yesInPast3mButton;
    IBOutlet UIButton *yesButNotInPast3mButton;
    
    IBOutlet UILabel *neverLabel;
    IBOutlet UILabel *yesInPast3mLabel;
    IBOutlet UILabel *yesButNotInPast3mLabel;
    
    NSString *answer;
    NSString *ansverText;
    NSArray *answersArray;
}

@end

@implementation REDThreeAnswerQuestion

- (void)viewDidLoad
{
    [super viewDidLoad];
    answer = @"0";
    ansverText = @"";
    answersArray = [[NSArray alloc] init];
    [self customizeElements];
}

- (void)customizeElements
{
    [questionText setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:30.0]];
    [subparagraphText setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:24.0]];
    [neverLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
    [yesInPast3mLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
    [yesButNotInPast3mLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
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
    [neverButton setSelected:NO];
    [yesInPast3mButton setSelected:NO];
    [yesButNotInPast3mButton setSelected:NO];
    [sender setSelected:YES];
    
    if (sender == neverButton)
    {
        answer = [answersArray objectAtIndex:0];
        ansverText = neverLabel.text;
    } else if (sender == yesInPast3mButton)
    {
        answer = [answersArray objectAtIndex:1];
        ansverText = yesInPast3mLabel.text;
    }
    else if (sender == yesButNotInPast3mButton)
    {
        answer = [answersArray objectAtIndex:2];
        ansverText = yesButNotInPast3mLabel.text;
    }
}


- (IBAction)pressNextButton:(id)sender {
    NSLog(@"questionKey %@", questionKey);
    NSArray* keyConponents = [questionKey componentsSeparatedByString:@"."];
    NSString *subparagraph = [keyConponents objectAtIndex:1];
    [[REDSettings sharedSettings] addAnswerNumber:answer ofSubparagraph:subparagraph];
    
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
