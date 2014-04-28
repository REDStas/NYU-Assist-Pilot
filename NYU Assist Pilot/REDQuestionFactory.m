//
//  REDQuestionFactory.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 08.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#import "REDQuestionFactory.h"

#import "REDFiveAnswerQuestion.h"
#import "REDThreeAnswerQuestion.h"
#import "REDDetailsQuestion.h"
#import "REDEightBQuestion.h"

@implementation REDQuestionFactory

static REDQuestionFactory* sharedQuestionFactory = nil;

+ (instancetype)sharedQuestionFactory
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedQuestionFactory = [[self alloc] init];
    });
    return sharedQuestionFactory;
}

+ (id)alloc
{
    @synchronized([REDQuestionFactory class])
    {
        NSAssert(sharedQuestionFactory == nil, @"Attempted to allocate a second instance of a singleton.");
        sharedQuestionFactory = [super alloc];
        return sharedQuestionFactory;
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

- (instancetype)createQuestionWithKey:(NSString *)key
{
    id controller;
    switch ([self detectQuestionType:key]) {
        case FiveOptionType:
            controller = [[REDFiveAnswerQuestion alloc] initWithNibName:@"REDFiveAnswerQuestion" bundle:nil];
            break;
        case DetailType:
            controller = [[REDDetailsQuestion alloc] initWithNibName:@"REDDetailsQuestion" bundle:nil];
            break;
        case ThreeOptionType:
            controller = [[REDThreeAnswerQuestion alloc] initWithNibName:@"REDThreeAnswerQuestion" bundle:nil];
            break;
        case EightQuestionType:
            controller = [[REDThreeAnswerQuestion alloc] initWithNibName:@"REDThreeAnswerQuestion" bundle:nil];
            break;
        case EightBQuestionType:
            controller = [[REDEightBQuestion alloc] initWithNibName:@"REDEightBQuestion" bundle:nil];
            break;
            
        default:
            break;
    }
    
    [controller view];
    [controller fillData:[self buildData:key]];
    return controller;
}

- (QuestionType)detectQuestionType:(NSString *)key
{
    NSArray* keyConponents = [key componentsSeparatedByString:@"."];
    if ([keyConponents count] == 3) {
        return DetailType;
    }
    else
    {
        if ([[keyConponents objectAtIndex:0] isEqualToString:@"6"] || [[keyConponents objectAtIndex:0] isEqualToString:@"7"]) {
            return ThreeOptionType;
        }
        else if ([[keyConponents objectAtIndex:0] isEqualToString:@"8"]) {
            return EightQuestionType;
        }
        else if ([[keyConponents objectAtIndex:0] isEqualToString:@"9"]) {
            return EightBQuestionType;
        }
        else
        {
            return FiveOptionType;
        }
        
    }
}

- (NSDictionary *)buildData:(NSString *)key
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if ([key isEqualToString:@"main"]) {
        
    } else if ([key isEqualToString:@"2.4.0"]) {
        [data setObject:@"Prescription stimulants." forKey:@"mainQuestion"];
        [data setObject:@"Is this a medication that you can buy in the store without a prescription (over the counter)?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    } else if ([key isEqualToString:@"2.4.1"]) {
        [data setObject:@"Prescription stimulants." forKey:@"mainQuestion"];
        [data setObject:@"Was it prescribed for you?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    } else if ([key isEqualToString:@"2.4.2"]) {
        [data setObject:@"Prescription stimulants." forKey:@"mainQuestion"];
        [data setObject:@"Do you ever use MORE of your stimulant medication, that is, take a higher dosage, than is prescribed for you?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    } else if ([key isEqualToString:@"2.4.3"]) {
        [data setObject:@"Prescription stimulants." forKey:@"mainQuestion"];
        [data setObject:@"Do you ever use your stimulant medication MORE OFTEN, that is, shorten the time between dosages, than is prescribed for you?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    } else if ([key isEqualToString:@"2.7.0"]) {
        [data setObject:@"Sedatives or Sleeping Pills" forKey:@"mainQuestion"];
        [data setObject:@"Is this a medication that you can buy in the store without a prescription (over the counter)?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    } else if ([key isEqualToString:@"2.7.1"]) {
        [data setObject:@"Sedatives or Sleeping Pills" forKey:@"mainQuestion"];
        [data setObject:@"Was it prescribed for you?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    } else if ([key isEqualToString:@"2.7.2"]) {
        [data setObject:@"Sedatives or Sleeping Pills" forKey:@"mainQuestion"];
        [data setObject:@"Do you ever use MORE of your sedatives or sleeping pills, that is, take a higher dosage, than is prescribed for you?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    } else if ([key isEqualToString:@"2.7.3"]) {
        [data setObject:@"Sedatives or Sleeping Pills" forKey:@"mainQuestion"];
        [data setObject:@"Do you ever use your sedatives or sleeping pills MORE OFTEN, that is, shorten the time between dosages, than is prescribed for you?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    } else if ([key isEqualToString:@"2.10.0"]) {
        [data setObject:@"Prescription opioids" forKey:@"mainQuestion"];
        [data setObject:@"Is this a medication that you can buy in the store without a prescription (over the counter)?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    } else if ([key isEqualToString:@"2.10.1"]) {
        [data setObject:@"Prescription opioids" forKey:@"mainQuestion"];
        [data setObject:@"Was it prescribed for you?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    } else if ([key isEqualToString:@"2.10.2"]) {
        [data setObject:@"Prescription opioids" forKey:@"mainQuestion"];
        [data setObject:@"Do you ever use MORE of your opioid medication, that is, take a higher dosage, than is prescribed for you?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    } else if ([key isEqualToString:@"2.10.3"]) {
        [data setObject:@"Prescription opioids" forKey:@"mainQuestion"];
        [data setObject:@"Do you ever use your opioid medication MORE OFTEN, that is, shorten the time between dosages, than is prescribed for you?" forKey:@"mainSubparagraph"];
        NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"0", @"2", nil];
        [data setObject:array forKey:@"answers"];
    }
    else
    {
        NSString *question;
        NSString *subparagraph;
        NSArray* keyConponents = [key componentsSeparatedByString:@"."];
        question = [keyConponents objectAtIndex:0];
        subparagraph = [keyConponents objectAtIndex:1];
        
        NSArray *allSubparagraphs = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SubparagraphList" ofType:@"plist"]];
        NSDictionary *allQuestion = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuestionList" ofType:@"plist"]];
        
        [data setObject:[allQuestion objectForKey:question] forKey:@"mainQuestion"];
        [data setObject:[allSubparagraphs objectAtIndex:[subparagraph integerValue]] forKey:@"mainSubparagraph"];
        NSArray *array;
//        switch ([question integerValue]) {
//            case 2:
//                array = [[NSArray alloc] initWithObjects:@"0", @"2", @"3", @"4", @"6", nil];
//                break;
//                
//            case 3:
//                array = [[NSArray alloc] initWithObjects:@"0", @"2", @"3", @"4", @"6", nil];
//                break;
//            case 4:
//                array = [[NSArray alloc] initWithObjects:@"0", @"2", @"3", @"4", @"6", nil];
//                break;
//            case 5:
//                array = [[NSArray alloc] initWithObjects:@"0", @"2", @"3", @"4", @"6", nil];
//                break;
//            case 6: case 7: gshjsjsy
//                array = [[NSArray alloc] initWithObjects:@"0", @"2", @"3", @"4", @"6", nil];
//                break;
//                
//            default:
//                break;
//        }
        if ([question isEqualToString:@"2"]) {
            array = [[NSArray alloc] initWithObjects:@"0", @"2", @"3", @"4", @"6", nil];
        }
        else if ([question isEqualToString:@"3"])
        {
            array = [[NSArray alloc] initWithObjects:@"0", @"3", @"4", @"5", @"6", nil];
        }
        else if ([question isEqualToString:@"4"])
        {
            array = [[NSArray alloc] initWithObjects:@"0", @"4", @"5", @"6", @"7", nil];
        }
        else if ([question isEqualToString:@"5"])
        {
            array = [[NSArray alloc] initWithObjects:@"0", @"5", @"6", @"7", @"8", nil];
        }
        else if ([question isEqualToString:@"6"] || [question isEqualToString:@"7"])
        {
            array = [[NSArray alloc] initWithObjects:@"0", @"6", @"3", nil];
        }
        else if ([question isEqualToString:@"8"])
        {
            array = [[NSArray alloc] initWithObjects:@"0", @"2", @"1", nil];
            [data setObject:@"" forKey:@"mainSubparagraph"];
        }
        else if ([question isEqualToString:@"9"])
        {
            array = [[NSArray alloc] initWithObjects:@"0", @"1", nil];
            [data setObject:@"" forKey:@"mainSubparagraph"];
        }
        
        [data setObject:array forKey:@"answers"];
    }
    [data setObject:key forKey:@"questionKey"];
    return data;
}

@end
