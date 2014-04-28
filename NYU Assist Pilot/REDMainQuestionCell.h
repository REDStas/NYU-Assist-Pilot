//
//  REDMainQuestionCell.h
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 14.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainQuestionCellDelegate <NSObject>

@required

- (void)changeSubparagraphActivity:(BOOL)value atIndex:(NSInteger)index;

@end

@interface REDMainQuestionCell : UITableViewCell

@property (strong, nonatomic) id <MainQuestionCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property bool isPositive;

- (void)changeActivity;

@end
