//
//  VolumeInfo.m
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "VolumeInfo.h"

@implementation VolumeInfo

- (void)setValue:(id)value forKey:(nonnull NSString *)key {
    [super setValue:value forKey:key];
    if([key isEqualToString:@"imageLinks"]) {
        self.imageLinks = [[ImageLinks alloc] init];
        [self.imageLinks setValuesForKeysWithDictionary:value];
    } else if([key isEqualToString:@"readingModes"]) {
        self.readingModes = [[ReadingModes alloc] init];
        [self.readingModes setValuesForKeysWithDictionary:value];
    }  else if([key isEqualToString:@"industryIdentifiers"]) {
        NSMutableArray *array = [NSMutableArray array];
        for(int i = 0; i< [(NSArray *)value count]; i ++) {
            IndustryIdentifiers *industryId = [[IndustryIdentifiers alloc] init];
            [industryId setValuesForKeysWithDictionary:value[i]];
            [array addObject:industryId];
        }
        self.industryIdentifiers = [NSArray arrayWithArray:array];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    return;
}

@end
