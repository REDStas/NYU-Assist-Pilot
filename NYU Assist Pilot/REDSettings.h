//
//  REDSettings.h
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 08.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REDSettings : NSObject

+ (instancetype)sharedSettings;

- (NSArray *)subparagraphsEverUsed;
- (void)addSubparagraphsAsEverUsed:(NSArray *)indexList;
- (NSArray *)allSubparagraphs;
- (NSArray *)indexOfSubparagraph;
- (NSDictionary *)subparagraphNumbers;

- (void)addAnswer:(NSString *)answer ofQuestionKey:(NSString *)questionKey;
- (NSDictionary *)allAnswers;

- (void)addAnswerNumber:(NSString *)number ofSubparagraph:(NSString *)subparagraph;

@property (strong, nonatomic) NSString *participantAge;
@property (strong, nonatomic) NSString *participantName;
@property (strong, nonatomic) NSString *participantGender;
@property (strong, nonatomic) NSString *participantDegree;

@property (strong, nonatomic) NSString *participantHadVaginal;
@property (strong, nonatomic) NSString *participantHadAnal;
@property (strong, nonatomic) NSString *sexQuestion3;
@property (strong, nonatomic) NSString *sexQuestion4;
@property (strong, nonatomic) NSString *sexQuestion5;
@property (strong, nonatomic) NSString *sexQuestion6;

@property (strong, nonatomic) NSString *consent;

@end
