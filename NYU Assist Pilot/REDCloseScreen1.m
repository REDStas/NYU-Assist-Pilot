//
//  REDCloseScreen.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 09.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDCloseScreen1.h"
#import "REDCloseScreen2.h"
#import "REDPrintController.h"
#import "REDNextButton.h"

#import "REDFontManager.h"
#import "REDSettings.h"
#import "REDResultCell.h"

@interface REDCloseScreen1 ()
{
    IBOutlet UILabel *headerLabel;
    IBOutlet UITableView *resultTable;
    IBOutlet UILabel *question;
    IBOutlet UITextField *userNameTextField;
    IBOutlet UIButton *noButton;
    IBOutlet UIButton *yesButton;
    
    IBOutlet REDNextButton *nextButton;
    REDCloseScreen2 *closeScreen2;
    REDPrintController *printingController;
    
    NSArray *resultData;
    NSArray *allSubparagraphs;
    
    NSMutableDictionary *dataForPrint;
    
    BOOL isPrint;
}

@end

@implementation REDCloseScreen1

- (void)viewDidLoad
{
    [super viewDidLoad];
    closeScreen2 = [[REDCloseScreen2 alloc] initWithNibName:@"REDCloseScreen2" bundle:nil];
    printingController = [[REDPrintController alloc] initWithNibName:@"REDPrintController" bundle:nil];
    [noButton.titleLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:28.0]];
    [yesButton.titleLabel setFont:[REDFontManager fontNamed:MuliRegular andSize:28.0]];
    [self customizeElements];
    
    allSubparagraphs = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SubparagraphList" ofType:@"plist"]];
    dataForPrint = [[NSMutableDictionary alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear) name:UIKeyboardWillHideNotification object:nil];
    [resultTable reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)customizeElements
{
    [headerLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:48.0]];
    [question setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:34.0]];

    UIView *fieldEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 34)];
    [userNameTextField setLeftViewMode:UITextFieldViewModeAlways];
    [userNameTextField setLeftView:fieldEmail];
}

#pragma mark - IBAction Methods

- (IBAction)pressNextButton:(id)sender {
    [REDSettings sharedSettings].participantName = userNameTextField.text;
    if (isPrint) {
        [self.navigationController pushViewController:printingController animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:closeScreen2 animated:YES];
    }
}

- (IBAction)pressPrevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pressYesNoControlButton:(id)sender {
    [nextButton setHidden:NO];
    [noButton setSelected:NO];
    [yesButton setSelected:NO];
    [sender setSelected:YES];
    
    if (sender == yesButton)
    {
        isPrint = YES;
        [userNameTextField setHidden:NO];
    }
    else
    {
        isPrint = NO;
        [userNameTextField setHidden:YES];
    }
}

#pragma mark - Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[REDSettings sharedSettings] subparagraphsEverUsed] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    REDResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"REDResultCell" owner:self options:nil];
        cell = (REDResultCell *)[nib objectAtIndex:0];
    }
    cell.categoryTitle.text = [[[REDSettings sharedSettings] subparagraphsEverUsed] objectAtIndex:indexPath.row];
    NSArray *array = [[REDSettings sharedSettings] indexOfSubparagraph];
    NSInteger value = [[[[REDSettings sharedSettings] subparagraphNumbers] objectForKey:[NSString stringWithFormat:@"%@", [array objectAtIndex:indexPath.row]]] integerValue];
    cell.riskValue.text = [NSString stringWithFormat:@"%i", value];
    
    [dataForPrint setObject:cell.riskValue.text forKey:cell.categoryTitle.text];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize textSize = [[[[REDSettings sharedSettings] subparagraphsEverUsed] objectAtIndex:indexPath.row] sizeWithFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:23.0] constrainedToSize:CGSizeMake(620, 1500) lineBreakMode:NSLineBreakByWordWrapping];
    return textSize.height + 20.0;
    //return 70.0;
}

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden // in iOS 7
{
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
    [UIView setAnimationDuration:0.4];
    
    CGRect rect = self.view.bounds;
    if (bMovedUp) {
            rect.origin.y = 300.0;
    } else
        rect.origin.y = 0;
    self.view.bounds = rect;
    [UIView commitAnimations];
}

@end
