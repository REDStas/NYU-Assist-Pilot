//
//  REDEightQuestion.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 22.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDEightBQuestion.h"

#import "REDFontManager.h"
#import "REDSettings.h"
#import "REDQuestionManager.h"

@interface REDEightBQuestion ()
{
    NSString *questionKey;
    IBOutlet UILabel *questionText;
    IBOutlet UILabel *subparagraphText;
    
    IBOutlet UIButton *onceButton;
    IBOutlet UIButton *moreButton;
    
    IBOutlet UILabel *onceLabel;
    IBOutlet UILabel *moreLabel;
    
    NSString *answer;
    NSString *ansverText;
    NSArray *answersArray;
}

@end

@implementation REDEightBQuestion

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
    [questionText setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:24.0]];
    [onceLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
    [moreLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
}

- (void)fillData:(NSDictionary *)data
{
    questionKey = [data objectForKey:@"questionKey"];
    [questionText setText:[data objectForKey:@"mainQuestion"]];
    //[subparagraphText setText:[data objectForKey:@"mainSubparagraph"]];
    answersArray = [data objectForKey:@"answers"];
    
    //NSLog(@"question key :: %@", questionKey);
}

- (IBAction)pressCheckbox:(id)sender {
    [onceButton setSelected:NO];
    [moreButton setSelected:NO];
    [sender setSelected:YES];
    
    if (sender == onceButton)
    {
        answer = [answersArray objectAtIndex:0];
        ansverText = onceLabel.text;
    } else if (sender == moreButton)
    {
        answer = [answersArray objectAtIndex:1];
        ansverText = moreLabel.text;
    }
}


- (IBAction)pressNextButton:(id)sender {
    NSLog(@"questionKey %@", questionKey);
//    NSArray* keyConponents = [questionKey componentsSeparatedByString:@"."];
//    NSString *subparagraph = [keyConponents objectAtIndex:1];
//    [[REDSettings sharedSettings] addAnswerNumber:answer ofSubparagraph:subparagraph];
    
    [[REDSettings sharedSettings] addAnswer:ansverText ofQuestionKey:questionKey];
//    UIViewController *viewController = (UIViewController *)[[REDQuestionManager sharedQuestionManager] nextQuestionWithLastQuestionKey:questionKey andLastQuestionAnswer:answer];
//    if (viewController) {
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
//    else
//    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"finishTesting" object:nil];
    //}
}

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden // in iOS 7
{
    return YES;
}

@end
