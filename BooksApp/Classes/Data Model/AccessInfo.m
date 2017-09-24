//
//  AccessInfo.m
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "AccessInfo.h"
@class ePub;

@implementation AccessInfo

- (void)setValue:(id)value forKey:(nonnull NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"epub"]) {
        self.epub = [[ePub alloc] init];
        [self.epub setValuesForKeysWithDictionary:value];
    } else if ([key isEqualToString:@"pdf"]) {
        self.pdf = [[ePub alloc] init];
        [self.pdf setValuesForKeysWithDictionary:value];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    return;
}

@end
