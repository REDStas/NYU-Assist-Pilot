//
//  REDQuestionManager.h
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 15.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REDQuestionManager : NSObject

+ (instancetype)sharedQuestionManager;

- (NSInteger)analysisMainQuestionResults:(NSArray *)results;
- (instancetype)nextQuestionWithLastQuestionKey:(NSString *)lastQuestionKey andLastQuestionAnswer:(NSString *)lastQuestionAnswer;

@end
