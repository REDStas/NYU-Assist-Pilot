//
//  REDMainQuestion.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 14.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDMainQuestion.h"

#import "REDFontManager.h"
#import "REDQuestionManager.h"
#import "REDSettings.h"

@interface REDMainQuestion ()
{
    IBOutlet UILabel *questionTitle;
    IBOutlet UILabel *noLabel;
    IBOutlet UILabel *yesLabel;
    IBOutlet UITableView *questionTableView;
    
    REDSettings *appSettings;
    NSArray *allSubparagraphs;
    
    NSMutableArray *results;
}

@end

@implementation REDMainQuestion

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
    appSettings = [REDSettings sharedSettings];
    allSubparagraphs = [[NSArray alloc] init];
    results = [[NSMutableArray alloc] init];
    allSubparagraphs = [appSettings allSubparagraphs];
    for (NSInteger i = 0; i < [allSubparagraphs count]; i++)
        [results addObject:@NO];
    [questionTableView reloadData];
    [self customizeElements];
}

- (void)customizeElements
{
    [questionTitle setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:24.0]];
    [noLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:24.0]];
    [yesLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:24.0]];
}

#pragma mark - Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allSubparagraphs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    REDMainQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"REDMainQuestionCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"REDMainQuestionCell" owner:self options:nil];
        cell = (REDMainQuestionCell *)[nib objectAtIndex:0];
    }
    cell.delegate = self;
    cell.tag = indexPath.row;
    cell.titleLabel.text = [allSubparagraphs objectAtIndex:indexPath.row];
    cell.isPositive = [[results objectAtIndex:indexPath.row] boolValue];
    [cell changeActivity];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize textSize = [[allSubparagraphs objectAtIndex:indexPath.row] sizeWithFont:[REDFontManager fontNamed:MuliRegular andSize:20.0] constrainedToSize:CGSizeMake(706, 1500) lineBreakMode:NSLineBreakByWordWrapping];
    return textSize.height + 20.0;
}

#pragma mark - Main Question Cell Delegate

- (void)changeSubparagraphActivity:(BOOL)value atIndex:(NSInteger)index
{
    [results replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:value]];
}

#pragma mark - IBAction Method

- (IBAction)pressNextButton:(id)sender {
    NSInteger positiveAnswerCount = [[REDQuestionManager sharedQuestionManager] analysisMainQuestionResults:results];
    if (positiveAnswerCount > 0)
        [self.navigationController pushViewController:(UIViewController *)[[REDQuestionManager sharedQuestionManager] nextQuestionWithLastQuestionKey:@"main" andLastQuestionAnswer:@"0"] animated:YES];
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:@"finishTesting" object:nil];
}

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden // in iOS 7
{
    return YES;
}

@end
