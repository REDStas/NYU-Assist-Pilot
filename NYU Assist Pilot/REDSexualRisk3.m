//
//  REDSexualRisk3.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 18.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDSexualRisk3.h"

#import "REDCloseScreen1.h"

#import "REDFontManager.h"
#import "REDSettings.h"
#import "REDValidation.h"

@interface REDSexualRisk3 ()
{
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *firstParagraph;
    IBOutlet UILabel *secondParagraph;
    IBOutlet UILabel *thirdParagraph;
    IBOutlet UILabel *forthParagraph;
    
    IBOutlet UIButton *fqPartnersButton;
    IBOutlet UIButton *fqDontKnowButton;
    IBOutlet UIButton *fqRefuseButton;
    
    IBOutlet UIButton *sqPartnersButton;
    IBOutlet UIButton *sqDontKnowButton;
    IBOutlet UIButton *sqRefuseButton;
    
    IBOutlet UIButton *thqYesButton;
    IBOutlet UIButton *thqNoButton;
    
    IBOutlet UIButton *foqYesButton;
    IBOutlet UIButton *foqNoButton;
    IBOutlet UIScrollView *contentScroll;
    
    IBOutlet UITextField *firstQuestionTextField;
    IBOutlet UITextField *secondQuestionTextField;
    
    NSString *firstAnswerText;
    NSString *secondAnswerText;
    NSString *thirdAnswerText;
    NSString *forthAnswerText;
    
    REDCloseScreen1 *closeSceen1;
}

@end

@implementation REDSexualRisk3

- (void)viewDidLoad
{
    [super viewDidLoad];
    firstAnswerText = @"";
    secondAnswerText = @"";
    thirdAnswerText = @"";
    forthAnswerText = @"";
    
    [headerLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:48.0]];
    [firstParagraph setFont:[REDFontManager fontNamed:MuliRegular andSize:30.0]];
    [secondParagraph setFont:[REDFontManager fontNamed:MuliRegular andSize:30.0]];
    [thirdParagraph setFont:[REDFontManager fontNamed:MuliRegular andSize:30.0]];
    [forthParagraph setFont:[REDFontManager fontNamed:MuliRegular andSize:30.0]];
    
    UIFont *buttonFont = [REDFontManager fontNamed:MuliRegular andSize:23.0];
    
    [fqPartnersButton.titleLabel setFont:buttonFont];
    [fqDontKnowButton.titleLabel setFont:buttonFont];
    [fqRefuseButton.titleLabel setFont:buttonFont];
    [sqPartnersButton.titleLabel setFont:buttonFont];
    [sqDontKnowButton.titleLabel setFont:buttonFont];
    [sqRefuseButton.titleLabel setFont:buttonFont];
    [thqYesButton.titleLabel setFont:buttonFont];
    [thqNoButton.titleLabel setFont:buttonFont];
    [foqYesButton.titleLabel setFont:buttonFont];
    [foqNoButton.titleLabel setFont:buttonFont];
    
    UIView *fieldEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 34)];
    UIView *fieldEmail2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 34)];
    [firstQuestionTextField setLeftViewMode:UITextFieldViewModeAlways];
    [firstQuestionTextField setLeftView:fieldEmail];
    [secondQuestionTextField setLeftViewMode:UITextFieldViewModeAlways];
    [secondQuestionTextField setLeftView:fieldEmail2];
    
    [contentScroll setContentSize:CGSizeMake(contentScroll.frame.size.width, 750)];
    
    closeSceen1 = [[REDCloseScreen1 alloc] initWithNibName:@"REDCloseScreen1" bundle:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)pressFirstQuestionControll:(id)sender {
    [fqPartnersButton setSelected:NO];
    [fqDontKnowButton setSelected:NO];
    [fqRefuseButton setSelected:NO];
    [sender setSelected:YES];
    if (sender != fqPartnersButton) {
        firstAnswerText = [(UIButton *)sender titleLabel].text;
    }
    else
    {
        firstAnswerText = firstQuestionTextField.text;
    }
}

- (IBAction)pressSecondQuestionControll:(id)sender {
    [sqPartnersButton setSelected:NO];
    [sqDontKnowButton setSelected:NO];
    [sqRefuseButton setSelected:NO];
    [sender setSelected:YES];
    if (sender != sqPartnersButton) {
        secondAnswerText = [(UIButton *)sender titleLabel].text;
    }
    else
    {
        secondAnswerText = secondQuestionTextField.text;
    }
}

- (IBAction)pressThirdQuestionControll:(id)sender {
    [thqYesButton setSelected:NO];
    [thqNoButton setSelected:NO];
    [sender setSelected:YES];
    thirdAnswerText = [(UIButton *)sender titleLabel].text;
}

- (IBAction)pressForthQuestionControll:(id)sender {
    [foqYesButton setSelected:NO];
    [foqNoButton setSelected:NO];
    [sender setSelected:YES];
    forthAnswerText = [(UIButton *)sender titleLabel].text;
}

- (IBAction)pressNextButton:(id)sender {
    [[REDSettings sharedSettings] setSexQuestion3:firstAnswerText];
    [[REDSettings sharedSettings] setSexQuestion4:secondAnswerText];
    [[REDSettings sharedSettings] setSexQuestion5:thirdAnswerText];
    [[REDSettings sharedSettings] setSexQuestion6:forthAnswerText];
    [self.navigationController pushViewController:closeSceen1 animated:YES];
}

- (IBAction)pressPrevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == firstQuestionTextField) {
        [fqPartnersButton setSelected:YES];
        [fqDontKnowButton setSelected:NO];
        [fqRefuseButton setSelected:NO];
        firstAnswerText = textField.text;
    }
    else if (textField == secondQuestionTextField)
    {
        [sqPartnersButton setSelected:YES];
        [sqDontKnowButton setSelected:NO];
        [sqRefuseButton setSelected:NO];
        secondAnswerText = textField.text;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (![REDValidation isNumber1And99Between:newString]){
        return NO;
    }
    if (textField == firstQuestionTextField)
        firstAnswerText = newString;
    else if (textField == secondQuestionTextField)
        secondAnswerText = newString;
    return YES;
}

#pragma mark - Keyboard Delegate

-(void)keyboardWillAppear {
    [self moveViewUp:YES];
}

-(void)keyboardWillDisappear {
    //[self moveViewUp:NO];
}

-(void)moveViewUp:(BOOL)bMovedUp
{
    if ([secondQuestionTextField isEditing])
        contentScroll.contentOffset = CGPointMake(0, 170);
}

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden // in iOS 7
{
    return YES;
}

@end
