//
//  REDFiveAnswerQuestion.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 15.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDFiveAnswerQuestion.h"

#import "REDFontManager.h"
#import "REDSettings.h"
#import "REDQuestionManager.h"

@interface REDFiveAnswerQuestion ()
{
    NSString *questionKey;
    IBOutlet UILabel *questionText;
    IBOutlet UILabel *subparagraphText;
    
    IBOutlet UIButton *neverButton;
    IBOutlet UIButton *onceOrTwiceButton;
    IBOutlet UIButton *monthlyButton;
    IBOutlet UIButton *weeklyButton;
    IBOutlet UIButton *dailyOrAlmostDailyButton;
    
    IBOutlet UILabel *neverLabel;
    IBOutlet UILabel *onceOrTwiceLabel;
    IBOutlet UILabel *monthlyLabel;
    IBOutlet UILabel *weeklyLabel;
    IBOutlet UILabel *dailyOrAlmostDailyLabel;
    
    NSString *answer;
    NSString *ansverText;
    NSArray *answersArray;
}

@end

@implementation REDFiveAnswerQuestion

- (void)viewDidLoad
{
    [super viewDidLoad];
    answersArray = [[NSArray alloc] init];
    answer = @"0";
    ansverText = @"";
    [self customizeElements];
}

- (void)customizeElements
{
    [questionText setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:30.0]];
    [subparagraphText setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:24.0]];
    [neverLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
    [onceOrTwiceLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
    [monthlyLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
    [weeklyLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
    [dailyOrAlmostDailyLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
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
    [onceOrTwiceButton setSelected:NO];
    [monthlyButton setSelected:NO];
    [weeklyButton setSelected:NO];
    [dailyOrAlmostDailyButton setSelected:NO];
    [sender setSelected:YES];
    
    if (sender == neverButton)
    {
        answer = [answersArray objectAtIndex:0];
        ansverText = neverLabel.text;
    } else if (sender == onceOrTwiceButton)
    {
        answer = [answersArray objectAtIndex:1];
        ansverText = onceOrTwiceLabel.text;
    }
    else if (sender == monthlyButton)
    {
        answer = [answersArray objectAtIndex:2];
        ansverText = monthlyLabel.text;
    }
    else if (sender == weeklyButton)
    {
        answer = [answersArray objectAtIndex:3];
        ansverText = weeklyLabel.text;
    }
    else if (sender == dailyOrAlmostDailyButton)
    {
        answer = [answersArray objectAtIndex:4];
        ansverText = dailyOrAlmostDailyLabel.text;
    }
}


- (IBAction)pressNextButton:(id)sender {
    //NSLog(@"%@ | %@: %@ - %@", questionKey, questionText.text, subparagraphText.text, ansverText);
    NSArray* keyConponents = [questionKey componentsSeparatedByString:@"."];
    NSString *subparagraph = [keyConponents objectAtIndex:1];
    NSLog(@"questionKey %@", questionKey);
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
