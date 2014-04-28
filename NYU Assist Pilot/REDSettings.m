//
//  REDSettings.m
//  NYU Assist Pilot
//
//  Created by Станислав Редреев on 08.04.14.
//  Copyright (c) 2014 Станислав Редреев. All rights reserved.
//

#define kSubparagraphList       @"SubparagraphList"

#import "REDSettings.h"

@implementation REDSettings
{
    NSArray *allSubparagraphs;
    NSMutableArray *subparagraphsEverUsed;
    
    NSMutableDictionary *allAnswers;
    
    NSMutableDictionary *subparagraphNumbers;
    NSArray *indexOfSubparagraph;
}

static REDSettings* sharedSettings = nil;

+ (instancetype)sharedSettings
{
    static dispatch_once_t once;
    static id sharedSettings;
    dispatch_once(&once, ^{
        sharedSettings = [[self alloc] init];
    });
    return sharedSettings;
}

+ (id)alloc
{
    @synchronized([REDSettings class])
    {
        NSAssert(sharedSettings == nil, @"Attempted to allocate a second instance of a singleton.");
        sharedSettings = [super alloc];
        return sharedSettings;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        allSubparagraphs = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kSubparagraphList ofType:@"plist"]];
        subparagraphsEverUsed = [NSMutableArray arrayWithArray:allSubparagraphs];
        allAnswers = [[NSMutableDictionary alloc] init];
        subparagraphNumbers = [[NSMutableDictionary alloc] init];
        indexOfSubparagraph = [[NSArray alloc] init];
        
        _participantHadVaginal = @"";
        _participantHadAnal = @"";
        _sexQuestion3 = @"";
        _sexQuestion4 = @"";
        _sexQuestion5 = @"";
        _sexQuestion6 = @"";
        
        _consent = @"";
    }
    return self;
}

#pragma mark - Subparagraphs

- (NSArray *)subparagraphsEverUsed
{
    return subparagraphsEverUsed;
}

- (void)addSubparagraphsAsEverUsed:(NSArray *)indexList
{
    [subparagraphsEverUsed removeAllObjects];
    [subparagraphNumbers removeAllObjects];
    indexOfSubparagraph = indexList;
    for (NSNumber *subparagraphIndex in indexList)
    {
        [subparagraphsEverUsed addObject:[allSubparagraphs objectAtIndex:[subparagraphIndex integerValue]]];
        [subparagraphNumbers setObject:@0 forKey:[NSString stringWithFormat:@"%i", [subparagraphIndex integerValue]]];
    }
}

- (NSArray *)allSubparagraphs
{
    return allSubparagraphs;
}

- (NSArray *)indexOfSubparagraph
{
    return indexOfSubparagraph;
}

- (NSDictionary *)subparagraphNumbers
{
    return subparagraphNumbers;
}

- (void)addAnswerNumber:(NSString *)number ofSubparagraph:(NSString *)subparagraph
{
    if ([subparagraphNumbers objectForKey:subparagraph]) {
        NSInteger numberValue = [[subparagraphNumbers objectForKey:subparagraph] integerValue];
        NSInteger newNumberValue = numberValue + [number integerValue];
        [subparagraphNumbers setObject:[NSNumber numberWithInteger:newNumberValue] forKey:[NSString stringWithFormat:@"%@", subparagraph]];
    }
    NSLog(@"subparagraphNumbers %@", subparagraphNumbers);
}

#pragma mark - Data

- (void)addAnswer:(NSString *)answer ofQuestionKey:(NSString *)questionKey
{
    [allAnswers setObject:answer forKey:questionKey];
}

- (NSDictionary *)allAnswers
{
    return allAnswers;
}



@end
