//
//  REDPrintingCell.h
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 25.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REDPrintingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *subparagraphText;
@property (strong, nonatomic) IBOutlet UILabel *riskText;
@property (strong, nonatomic) IBOutlet UILabel *scoreText;

@end
