//
//  SaleInfo.m
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "SaleInfo.h"
@class Price;
@class Offers;

@implementation SaleInfo

- (void)setValue:(id)value forKey:(nonnull NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"listPrice"]) {
        self.listPrice = [[Price alloc] init];
        [self.listPrice setValuesForKeysWithDictionary:value];
    } else if ([key isEqualToString:@"retailPrice"]) {
        self.retailPrice = [[Price alloc] init];
        [self.retailPrice setValuesForKeysWithDictionary:value];
    } else if ([key isEqualToString:@"offers"]) {
        NSMutableArray *array = [NSMutableArray array];
        for(int i = 0; i< [(NSArray *)value count]; i ++) {
            Offers *offerItem = [[Offers alloc] init];
            [offerItem setValuesForKeysWithDictionary:value[i]];
            [array addObject:offerItem];
        }
        self.offers = [NSArray arrayWithArray:array];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    return;
}

@end
