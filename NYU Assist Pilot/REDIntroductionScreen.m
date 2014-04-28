//
//  REDStartScreen.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 31.03.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDIntroductionScreen.h"
#import "REDIntroduction4.h"
#import "REDCloseScreen1.h"
#import "REDInformationScreen.h"
#import "REDViewController5.h"

#import "REDFontManager.h"

@interface REDIntroductionScreen ()
{
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *firstParagraph;
    IBOutlet UILabel *secondParagraph;
    
    REDInformationScreen *informationScreen;
    REDIntroduction4 *introd4;
    REDCloseScreen1 *closeScreen1;
    REDViewController5 *vk5;
}

- (IBAction)pressNextButton:(id)sender;

@end

@implementation REDIntroductionScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    introd4 = [[REDIntroduction4 alloc] initWithNibName:@"REDIntroduction4" bundle:nil];
    
    [headerLabel setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:72.0]];
    [firstParagraph setFont:[REDFontManager fontNamed:MuliRegular andSize:40.0]];
    [secondParagraph setFont:[REDFontManager fontNamed:HammersmithOneRegular andSize:40.0]];
}


- (IBAction)pressNextButton:(id)sender {
    informationScreen = nil;
    informationScreen = [[REDInformationScreen alloc] initWithNibName:@"REDInformationScreen" bundle:nil];
    vk5 = [[REDViewController5 alloc] initWithNibName:@"REDViewController5" bundle:nil];
    closeScreen1 = [[REDCloseScreen1 alloc] init];
    [self.navigationController pushViewController:informationScreen animated:YES];
   // [self printImage];
}

-(void)printImage {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"rectImage" ofType:@"png"];
    NSData *dataFromPath = [NSData dataWithContentsOfFile:path];
    
    UIPrintInteractionController *pCon = [UIPrintInteractionController sharedPrintController];
    
    if(pCon && [UIPrintInteractionController canPrintData:dataFromPath]) {
        pCon.delegate = self;
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = [path lastPathComponent];
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        pCon.printInfo = printInfo;
        pCon.showsPageRange = YES;
        pCon.printingItem = dataFromPath;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"Unsuccessfull %@ error%ld", error.domain, (long)error.code);
            }
        };
        
        [pCon presentAnimated:YES completionHandler:completionHandler];
        
    } 
}
#pragma mark - Status Bar Hidden Method

- (BOOL)prefersStatusBarHidden // in iOS 7
{
    return YES;
}

@end
