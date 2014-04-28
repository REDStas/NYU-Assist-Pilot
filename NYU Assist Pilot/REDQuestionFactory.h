//
//  REDQuestionFactory.h
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 08.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, QuestionType) {
    MainType,
    ThreeOptionType,
    FiveOptionType,
    EightQuestionType,
    EightBQuestionType,
    DetailType,
};

@interface REDQuestionFactory : NSObject

+ (instancetype)sharedQuestionFactory;

- (instancetype)createQuestionWithKey:(NSString *)key;

@end
