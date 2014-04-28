//
//  REDSexualRisk2.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 17.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDSexualRisk2.h"
#import "REDSexualRisk3.h"
#import "REDCloseScreen1.h"

#import "REDFontManager.h"
#import "REDSettings.h"

@interface REDSexualRisk2 ()
{
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *firstParagraph;
    IBOutlet UILabel *secondParagraph;
    
    IBOutlet UILabel *yesLabel;
    IBOutlet UILabel *noLabel;
    IBOutlet UILabel *dontKnow;
    IBOutlet UILabel *refuseAnswer;
    
    
    IBOutlet UIButton *fqYesButton;
    IBOutlet UIButton *fqNoButton;
    IBOutlet UIButton *fqDontKnowButton;
    IBOutlet UIButton *fqRefuseButton;
    
    IBOutlet UIButton *sqYesButton;
    IBOutlet UIButton *sqNoButton;
    IBOutlet UIButton *sqDontKnowButton;
    IBOutlet UIButton *sqRefuseButton;
    NSString *firstAnswerText;
    NSString *secondAnswerText;
    
    REDSexualRisk3 *sexualRisk3;
    REDCloseScreen1 *closeScreen1;
}

@end

@implementation REDSexualRisk2

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
    
    sexualRisk3 = [[REDSexualRisk3 alloc] initWithNibName:@"REDSexualRisk3" bundle:nil];
    closeScreen1 = [[REDCloseScreen1 alloc] initWithNibName:@"REDCloseScreen1" bundle:nil];
    
    [headerLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:48.0]];
    [firstParagraph setFont:[REDFontManager fontNamed:MuliRegular andSize:36.0]];
    [secondParagraph setFont:[REDFontManager fontNamed:MuliRegular andSize:36.0]];
}

#pragma mark - IBAction

- (IBAction)pressFirstQuestionControll:(id)sender {
    [fqYesButton setSelected:NO];
    [fqNoButton setSelected:NO];
    [fqDontKnowButton setSelected:NO];
    [fqRefuseButton setSelected:NO];
    [sender setSelected:YES];
    switch ([sender tag]) {
        case 1:
            firstAnswerText = yesLabel.text;
            break;
        case 2:
            firstAnswerText = noLabel.text;
            break;
        case 3:
            firstAnswerText = dontKnow.text;
            break;
        case 4:
            firstAnswerText = refuseAnswer.text;
            break;
            
        default:
            break;
    }
}

- (IBAction)pressSecondQuestionControll:(id)sender {
    [sqYesButton setSelected:NO];
    [sqNoButton setSelected:NO];
    [sqDontKnowButton setSelected:NO];
    [sqRefuseButton setSelected:NO];
    [sender setSelected:YES];
    switch ([sender tag]) {
        case 5:
            secondAnswerText = yesLabel.text;
            break;
        case 6:
            secondAnswerText = noLabel.text;
            break;
        case 7:
            secondAnswerText = dontKnow.text;
            break;
        case 8:
            secondAnswerText = refuseAnswer.text;
            break;
            
        default:
            break;
    }
}

- (IBAction)pressNextButton:(id)sender {
    REDSettings *settings = [REDSettings sharedSettings];
    settings.participantHadVaginal = firstAnswerText;
    settings.participantHadAnal = secondAnswerText;
    if ([firstAnswerText isEqualToString:yesLabel.text] || [secondAnswerText isEqualToString:yesLabel.text]) {
        [self.navigationController pushViewController:sexualRisk3 animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:closeScreen1 animated:YES];
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
