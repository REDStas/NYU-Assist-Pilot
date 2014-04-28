//
//  REDViewController6.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 08.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDDemographicsScreen.h"
#import "REDCloseScreen1.h"
#import "REDSexualRisk1.h"

#import "REDFontManager.h"
#import "REDSettings.h"
#import "REDValidation.h"

@interface REDDemographicsScreen ()
{
    IBOutlet UILabel *header;
    IBOutlet UILabel *firstQuestionTitle;
    IBOutlet UILabel *secondQuestionTitle;
    IBOutlet UILabel *thirdQuestionTitle;
    
    IBOutlet UITextField *firstQuestionTextField;
    IBOutlet UITextField *secondQuestionTextField;
    IBOutlet UITextField *thirdQuestionTextField;
    
    
    IBOutlet UIButton *firstQuestionMale;
    IBOutlet UIButton *firstQuestionFemale;
    IBOutlet UIButton *firstQuestionTransgender;
    IBOutlet UIButton *firstQuestionOther;
    IBOutlet UIButton *firstQuestionRefused;
    
    IBOutlet UIButton *secondQuestionRefused;
    
    IBOutlet UIButton *thirdQuestionUndergraduate;
    IBOutlet UIButton *thirdQuestionMasters;
    IBOutlet UIButton *thirdQuestionDoctoral;
    IBOutlet UIButton *thirdQuestionOther;
    
    REDCloseScreen1 *closeScreen1;
    REDSexualRisk1 *sexualRisk1;
    
    // Data
    NSString *genderType;
    NSString *age;
    NSString *educationalType;
    
    IBOutlet UITableView *ageListView;
    IBOutlet UIPickerView *agePicker;
    IBOutlet UIView *aveViewTop;
}

@end

@implementation REDDemographicsScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    closeScreen1 = [[REDCloseScreen1 alloc] initWithNibName:@"REDCloseScreen1" bundle:nil];
    sexualRisk1 = [[REDSexualRisk1 alloc] initWithNibName:@"REDSexualRisk1" bundle:nil];
    [self customizeElements];
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

- (void)customizeElements
{
    UIFont *questFont = [REDFontManager fontNamed:HammersmithOneRegular andSize:36.0];
    UIFont *buttonFont = [REDFontManager fontNamed:MuliRegular andSize:30.0];
    
    [header setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:48.0]];
    
    [firstQuestionTitle setFont:questFont];
    [secondQuestionTitle setFont:questFont];
    [thirdQuestionTitle setFont:questFont];
    
    [firstQuestionMale.titleLabel setFont:buttonFont];
    [firstQuestionFemale.titleLabel setFont:buttonFont];
    [firstQuestionTransgender.titleLabel setFont:buttonFont];
    [firstQuestionOther.titleLabel setFont:buttonFont];
    [firstQuestionRefused.titleLabel setFont:buttonFont];
    
    [secondQuestionRefused.titleLabel setFont:buttonFont];
    
    [thirdQuestionUndergraduate.titleLabel setFont:buttonFont];
    [thirdQuestionMasters.titleLabel setFont:buttonFont];
    [thirdQuestionDoctoral.titleLabel setFont:buttonFont];
    [thirdQuestionOther.titleLabel setFont:buttonFont];
    
    
    UIView *fieldEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 34)];
    UIView *fieldEmail2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 34)];
    UIView *fieldEmail3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 34)];
    [firstQuestionTextField setLeftViewMode:UITextFieldViewModeAlways];
    [firstQuestionTextField setLeftView:fieldEmail];
    [secondQuestionTextField setLeftViewMode:UITextFieldViewModeAlways];
    [secondQuestionTextField setLeftView:fieldEmail2];
    [thirdQuestionTextField setLeftViewMode:UITextFieldViewModeAlways];
    [thirdQuestionTextField setLeftView:fieldEmail3];
}

#pragma mark - IBAction Methods

- (IBAction)pressGenderButtonControls:(id)sender {
    [firstQuestionMale setSelected:NO];
    [firstQuestionFemale setSelected:NO];
    [firstQuestionTransgender setSelected:NO];
    [firstQuestionOther setSelected:NO];
    [firstQuestionRefused setSelected:NO];
    [firstQuestionTextField resignFirstResponder];
    [sender setSelected:YES];
    genderType = [NSString stringWithFormat:@"%@", [[(UIButton *)sender titleLabel] text]];
    if (sender == firstQuestionOther) {
        [firstQuestionTextField becomeFirstResponder];
    }
}

- (IBAction)pressEducationalButtonControls:(id)sender {
    [thirdQuestionUndergraduate setSelected:NO];
    [thirdQuestionMasters setSelected:NO];
    [thirdQuestionDoctoral setSelected:NO];
    [thirdQuestionOther setSelected:NO];
    [thirdQuestionTextField resignFirstResponder];
    educationalType = [NSString stringWithFormat:@"%@", [[(UIButton *)sender titleLabel] text]];
    [sender setSelected:YES];
    if (sender == thirdQuestionOther) {
        [thirdQuestionTextField becomeFirstResponder];
    }
}

- (IBAction)pressAgeButtonControl:(id)sender {
    [secondQuestionTextField resignFirstResponder];
    age = [NSString stringWithFormat:@"%@", [[(UIButton *)sender titleLabel] text]];
    [sender setSelected:YES];
}

- (IBAction)pressNextButton:(id)sender {
    REDSettings *settings = [REDSettings sharedSettings];
    settings.participantAge = age;
    settings.participantGender = genderType;
    settings.participantDegree = educationalType;
    [self.navigationController pushViewController:sexualRisk1 animated:YES];
}

- (IBAction)pressPrevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == firstQuestionTextField) {
        [firstQuestionMale setSelected:NO];
        [firstQuestionFemale setSelected:NO];
        [firstQuestionTransgender setSelected:NO];
        [firstQuestionRefused setSelected:NO];
        [firstQuestionOther setSelected:YES];
    }
    else if (textField == secondQuestionTextField)
    {
        [secondQuestionRefused setSelected:NO];
        [secondQuestionTextField resignFirstResponder];
        [ageListView setHidden:!ageListView.hidden];
        [aveViewTop setHidden:!aveViewTop.hidden];
    }
    else if (textField == thirdQuestionTextField)
    {
        [thirdQuestionUndergraduate setSelected:NO];
        [thirdQuestionMasters setSelected:NO];
        [thirdQuestionDoctoral setSelected:NO];
        [thirdQuestionOther setSelected:YES];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == secondQuestionTextField) {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (![REDValidation isNumber1And99Between:newString]){
            return NO;
        }
    }
    return YES;
}

#pragma mark - Keyboard Delegate

-(void)keyboardWillAppear {
    [self moveViewUp:YES];
}

-(void)keyboardWillDisappear {
    [self moveViewUp:NO];
}

-(void)moveViewUp:(BOOL)bMovedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    CGRect rect = self.view.bounds;
    if (bMovedUp) {
        if ([thirdQuestionTextField isEditing])
            rect.origin.y = 200.0;
    } else
        rect.origin.y = 0;
    self.view.bounds = rect;
    [UIView commitAnimations];
}

#pragma mark - Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 73;//[resultData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%i", indexPath.row + 18];
    [cell.textLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:20.0]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    secondQuestionTextField.text = [NSString stringWithFormat:@"%i", indexPath.row + 18];
    age = secondQuestionTextField.text;
    [ageListView setHidden:YES];
    [aveViewTop setHidden:YES];
}

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden // in iOS 7
{
    return YES;
}

@end
