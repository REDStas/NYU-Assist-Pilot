//
//  REDQuestionManager.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 15.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDQuestionManager.h"

#import "REDQuestionFactory.h"
#import "REDSettings.h"

@implementation REDQuestionManager
{
    NSInteger currentQuestionStage;
    NSInteger currentSubparagraph;
    
    NSMutableArray *everUsedSubparagraphs;
    BOOL isLastSubparagraph;
    BOOL isFirstSubparagraph;
    
    NSInteger currentQuestionStageScore;
}

static REDQuestionManager* sharedQuestionManager = nil;

+ (instancetype)sharedQuestionManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedQuestionManager = [[self alloc] init];
    });
    return sharedQuestionManager;
}

+ (id)alloc
{
    @synchronized([REDQuestionManager class])
    {
        NSAssert(sharedQuestionManager == nil, @"Attempted to allocate a second instance of a singleton.");
        sharedQuestionManager = [super alloc];
        return sharedQuestionManager;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
    }
    return self;
}

- (void)settings
{
    
}

#pragma mark - Methods

- (NSInteger)analysisMainQuestionResults:(NSArray *)results
{
    everUsedSubparagraphs = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [results count]; i++) {
        if ([[results objectAtIndex:i] boolValue]) {
            [everUsedSubparagraphs addObject:[NSNumber numberWithInteger:i]];
        }
    }
    [[REDSettings sharedSettings] addSubparagraphsAsEverUsed:everUsedSubparagraphs];
    return [everUsedSubparagraphs count];
}

- (NSInteger)nextSubparagraph:(NSInteger)subparagraph
{
    if ([self isLastSubparagraph:subparagraph]) {
        isLastSubparagraph = YES;
        return [[everUsedSubparagraphs lastObject] integerValue];
    }
    else if (isFirstSubparagraph)
    {
        isFirstSubparagraph = NO;
        return [[everUsedSubparagraphs firstObject] integerValue];
    }
    else
    {
        NSNumber *index = [NSNumber numberWithInteger:subparagraph];
        NSInteger lastIndex = [everUsedSubparagraphs indexOfObject:index];
        isLastSubparagraph = NO;
        return [[everUsedSubparagraphs objectAtIndex:lastIndex + 1] integerValue];
    }
}

- (BOOL)isLastSubparagraph:(NSInteger)subparagraph
{
    //NSLog(@"everUsedSubparagraphs %@", everUsedSubparagraphs);
    //NSLog(@"subparagraph %i", subparagraph);
    NSInteger idx = [everUsedSubparagraphs indexOfObject:[NSNumber numberWithInteger:subparagraph]];
    //NSLog(@"index %i", idx);
    if ([everUsedSubparagraphs count] == idx + ([everUsedSubparagraphs count]==1 ? 1 : 2))
        return YES;
    else
        return NO;
}

- (instancetype)nextQuestionWithLastQuestionKey:(NSString *)lastQuestionKey andLastQuestionAnswer:(NSString *)lastQuestionAnswer
{
    id controller;
    //NSLog(@"lastQuestionAnswer %@", lastQuestionAnswer);
    currentQuestionStageScore = currentQuestionStageScore + [lastQuestionAnswer integerValue];
    if ([lastQuestionKey isEqualToString:@"main"]) {
        currentQuestionStage = 2;
        NSString *key = [NSString stringWithFormat:@"%i.%i", currentQuestionStage, [[everUsedSubparagraphs objectAtIndex:0] integerValue]];
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:key];
    } else if ([lastQuestionKey isEqualToString:@"2.4"] && ![lastQuestionAnswer isEqualToString:@"0"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.4.0"];
    } else if ([lastQuestionKey isEqualToString:@"2.4.0"] && ![lastQuestionAnswer isEqualToString:@"1"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.4.1"];
    } else if ([lastQuestionKey isEqualToString:@"2.4.1"] && ![lastQuestionAnswer isEqualToString:@"0"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.4.2"];
    } else if ([lastQuestionKey isEqualToString:@"2.4.2"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.4.3"];
    } else if ([lastQuestionKey isEqualToString:@"2.7"] && ![lastQuestionAnswer isEqualToString:@"0"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.7.0"];
    } else if ([lastQuestionKey isEqualToString:@"2.7.0"] && ![lastQuestionAnswer isEqualToString:@"1"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.7.1"];
    } else if ([lastQuestionKey isEqualToString:@"2.7.1"] && ![lastQuestionAnswer isEqualToString:@"0"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.7.2"];
    } else if ([lastQuestionKey isEqualToString:@"2.7.2"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.7.3"];
    } else if ([lastQuestionKey isEqualToString:@"2.10"] && ![lastQuestionAnswer isEqualToString:@"0"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.10.0"];
    } else if ([lastQuestionKey isEqualToString:@"2.10.0"] && ![lastQuestionAnswer isEqualToString:@"1"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.10.1"];
    } else if ([lastQuestionKey isEqualToString:@"2.10.1"] && ![lastQuestionAnswer isEqualToString:@"0"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.10.2"];
    } else if ([lastQuestionKey isEqualToString:@"2.10.2"]) {
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"2.10.3"];
    }
    else if ([lastQuestionKey isEqualToString:@"8.0"])
    {
        if (currentQuestionStageScore == 2) {
            controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"9.0"];
        }
        else
        {
            return nil;
        }
        
    }
    else if ([lastQuestionKey isEqualToString:@"9.0"])
    {
        return nil;
    }
    else {
        NSInteger question;
        NSInteger subparagraph;
        NSArray* keyConponents = [lastQuestionKey componentsSeparatedByString:@"."];
        question = [[keyConponents objectAtIndex:0] integerValue];
        subparagraph = [[keyConponents objectAtIndex:1] integerValue];
        
        if (isFirstSubparagraph) {
            if (question == 2 && currentQuestionStageScore == 0) {
                currentQuestionStage = 6;
            }
//            else
//            {
//                if (currentQuestionStage == 9 && currentQuestionStageScore == 2) {
//                    controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"9.0"];
//                }
//                if (currentQuestionStage == 10 && currentQuestionStageScore == 2) {
//                    controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"end"];
//                }
//                if (question == 8 && currentQuestionStageScore == 2) {
//                    controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:@"9.0"];
//                }
//                if (question == 9) {
//                    
//                }
//                else{
//                    NSLog(@"stop Interview");
//                    return nil;
//                }
            //}
            
            currentQuestionStageScore = 0;
            //NSLog(@"считаем результаты");
        }
        currentSubparagraph = [self nextSubparagraph:subparagraph];
        
        NSString *key = [NSString stringWithFormat:@"%i.%i", currentQuestionStage, currentSubparagraph];
        //NSLog(@"key next %@", key);
        
        if (isLastSubparagraph) {
            currentQuestionStage++;
            isLastSubparagraph = NO;
            isFirstSubparagraph = YES;
        }
        controller = [[REDQuestionFactory sharedQuestionFactory] createQuestionWithKey:key];
    }
    return controller;
}


@end