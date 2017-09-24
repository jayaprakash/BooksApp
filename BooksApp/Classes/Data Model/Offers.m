//
//  Offers.m
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/25/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "Offers.h"
#import "Price.h"

@implementation Offers

- (void)setValue:(id)value forKey:(nonnull NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"listPrice"]) {
        self.listPrice = [[Price alloc] init];
        [self.listPrice setValuesForKeysWithDictionary:value];
    } else if ([key isEqualToString:@"retailPrice"]) {
        self.retailPrice = [[Price alloc] init];
        [self.retailPrice setValuesForKeysWithDictionary:value];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    return;
}


@end
