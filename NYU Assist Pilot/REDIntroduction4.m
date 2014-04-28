//
//  REDIntroduction4.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 08.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDIntroduction4.h"
#import "REDViewController5.h"

#import "REDFontManager.h"

@interface REDIntroduction4 ()
{
    IBOutlet UILabel *firstParagraph;
    IBOutlet UILabel *secondParagraph;
    
    REDViewController5 *vk5;
}

- (IBAction)pressNextButton:(id)sender;

@end

@implementation REDIntroduction4

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customizeElements];
    
    vk5 = [[REDViewController5 alloc] initWithNibName:@"REDViewController5" bundle:nil];
}

- (void)customizeElements
{
    UIFont *muliFont = [REDFontManager fontNamed:MuliRegular andSize:34.0];
    UIFont *hammersmithOneFont = [REDFontManager fontNamed:HammersmithOneRegular andSize:34.0];
    UIColor *foregroundColor = [UIColor whiteColor];
    
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys: muliFont, NSFontAttributeName, foregroundColor, NSForegroundColorAttributeName, nil];
    NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:hammersmithOneFont, NSFontAttributeName, nil];
    const NSRange range1 = NSMakeRange(135, 54);
    const NSRange range2 = NSMakeRange(282, 17);
    
    NSMutableAttributedString *firstParagraphAttributedText = [[NSMutableAttributedString alloc] initWithString:firstParagraph.text attributes:attrs];
    [firstParagraphAttributedText setAttributes:subAttrs range:range1];
    [firstParagraphAttributedText setAttributes:subAttrs range:range2];
    
    const NSRange range3 = NSMakeRange(31, 35);
    const NSRange range4 = NSMakeRange(73, 12);
    const NSRange range5 = NSMakeRange(102, 10);
    const NSRange range6 = NSMakeRange(119, 12);
    
    NSMutableAttributedString *secondParagraphAttributedText = [[NSMutableAttributedString alloc] initWithString:secondParagraph.text attributes:attrs];
    [secondParagraphAttributedText setAttributes:subAttrs range:range3];
    [secondParagraphAttributedText setAttributes:subAttrs range:range4];
    [secondParagraphAttributedText setAttributes:subAttrs range:range5];
    [secondParagraphAttributedText setAttributes:subAttrs range:range6];
    
    [firstParagraph setAttributedText:firstParagraphAttributedText];
    [secondParagraph setAttributedText:secondParagraphAttributedText];
}

- (IBAction)pressNextButton:(id)sender {
    [self presentViewController:vk5 animated:YES completion:^{
        
    }];
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
