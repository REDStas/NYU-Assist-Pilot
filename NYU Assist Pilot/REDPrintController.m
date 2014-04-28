//
//  REDPrintController.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 25.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDPrintController.h"
#import "REDCloseScreen2.h"

#import "REDPrintingCell.h"

#import "REDSettings.h"
#import "REDFontManager.h"

@interface REDPrintController ()
{
    IBOutlet UILabel *userName;
    IBOutlet UILabel *printDate;
    IBOutlet UITableView *resultTableView;
    IBOutlet UILabel *referenceValueLabel;
    IBOutlet UIScrollView *mainScroll;
    
    REDCloseScreen2 *closeScreen2;
}

@end

@implementation REDPrintController

- (void)viewDidLoad
{
    [super viewDidLoad];
    userName.text = [[REDSettings sharedSettings] participantName];
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    printDate.text = dateString;
    
    closeScreen2 = [[REDCloseScreen2 alloc] initWithNibName:@"REDCloseScreen2" bundle:nil];
}
- (IBAction)saveImage:(id)sender {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIView *contentView = [mainScroll subviews][0];
//    [contentView.layer renderInContext:context];
//    
//    CGImageRef imgRef = CGBitmapContextCreateImage(context);
//    UIImage* img = [UIImage imageWithCGImage:imgRef];
//    CGImageRelease(imgRef);
//    CGContextRelease(context);
//    
//    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
[mainScroll setFrame:CGRectMake(mainScroll.frame.origin.x, mainScroll.frame.origin.y, mainScroll.contentSize.width, mainScroll.contentSize.height)];
    UIGraphicsBeginImageContext(CGSizeMake(mainScroll.contentSize.width, mainScroll.contentSize.height));
    [mainScroll.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
//    UIImage *imageToDisplay = [UIImage imageWithCGImage:[viewImage CGImage]
//                        scale:1.0
//                  orientation: UIImageOrientationUp];
    //UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    pic.delegate = self;
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    //printInfo.orientation = UIPrintInfoOrientationPortrait;
    printInfo.jobName = [NSString stringWithFormat:@"Results"];
    pic.printInfo = printInfo;
    
    
    pic.printingItem = [self createPDFfromUIView:[[UIImageView alloc] initWithImage:viewImage] saveToDocumentsWithFileName:@"dvr"];//[UIImage imageWithContentsOfFile:path];
    
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if (!completed && error) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error."
                                                         message:[NSString stringWithFormat:@"An error occured while printing: %@", error]
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
            
            [av show];
//            [av release];
        }
    };
    
    [pic presentAnimated:YES completionHandler:completionHandler];
}


-(NSMutableData *)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    // Creates a mutable data object for updating with binary data, like a byte array
    NSMutableData *pdfData = [NSMutableData data];
    
    // Points the pdf converter to the mutable data object and to the UIView to be converted
    UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil);
    
    UIGraphicsBeginPDFPage();
    
    
    // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // remove PDF rendering context
    UIGraphicsEndPDFContext();
    
    // Retrieves the document directories from the iOS device
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    
    // instructs the mutable data object to write its context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    return pdfData;
    NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
}

- (void)printInteractionControllerWillStartJob:(UIPrintInteractionController *)printInteractionController
{
    [self.navigationController pushViewController:closeScreen2 animated:NO];
    NSLog(@"Start");
}

- (void)viewDidAppear:(BOOL)animated
{
    [resultTableView reloadData];
    [resultTableView setFrame:CGRectMake(resultTableView.frame.origin.x, resultTableView.frame.origin.y, resultTableView.frame.size.width, resultTableView.contentSize.height)];
    [referenceValueLabel setFrame:CGRectMake(referenceValueLabel.frame.origin.x, resultTableView.frame.origin.y + resultTableView.contentSize.height + 10, referenceValueLabel.frame.size.width, referenceValueLabel.frame.size.height)];
    [mainScroll setContentSize:CGSizeMake(mainScroll.frame.size.width, referenceValueLabel.frame.origin.y + referenceValueLabel.frame.size.height)];
    
}

#pragma mark - Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[REDSettings sharedSettings] subparagraphsEverUsed] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    REDPrintingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"REDPrintingCell" owner:self options:nil];
        cell = (REDPrintingCell *)[nib objectAtIndex:0];
    }
    cell.subparagraphText.text = [[[REDSettings sharedSettings] subparagraphsEverUsed] objectAtIndex:indexPath.row];
    NSArray *array = [[REDSettings sharedSettings] indexOfSubparagraph];
    NSInteger value = [[[[REDSettings sharedSettings] subparagraphNumbers] objectForKey:[NSString stringWithFormat:@"%@", [array objectAtIndex:indexPath.row]]] integerValue];
    cell.scoreText.text = [NSString stringWithFormat:@"%i", value];
    if ([cell.scoreText.text integerValue] < 4) {
        cell.riskText.text = @"low risk use";
    }
    else if ([cell.scoreText.text integerValue] >= 4 && [cell.scoreText.text integerValue] <= 26)
    {
        cell.riskText.text = @"moderate risk use";
    }
    else if ([cell.scoreText.text integerValue] > 26)
    {
        cell.riskText.text = @"high risk use";
    }
    
    //[dataForPrint setObject:cell.riskValue.text forKey:cell.categoryTitle.text];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize textSize = [[[[REDSettings sharedSettings] subparagraphsEverUsed] objectAtIndex:indexPath.row] sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(600, 1500) lineBreakMode:NSLineBreakByWordWrapping];
    return textSize.height + 20.0;
    //return 70.0;
}

#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden // in iOS 7
{
    return YES;
}

@end
