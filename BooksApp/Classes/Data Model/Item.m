//
//  Items.m
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "Item.h"
@class VolumeInfo;
@class SaleInfo;
@class AccessInfo;
@class SearchInfo;

@implementation Item

- (void)setValue:(id)value forKey:(nonnull NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.idValue = value;
    } else if ([key isEqualToString:@"volumeInfo"]) {
        self.volumeInfo = [[VolumeInfo alloc] init];
        [self.volumeInfo setValuesForKeysWithDictionary:value];
    } else if ([key isEqualToString:@"saleInfo"]) {
        self.saleInfo = [[SaleInfo alloc] init];
        [self.saleInfo setValuesForKeysWithDictionary:value];
    } else if ([key isEqualToString:@"accessInfo"]) {
        self.accessInfo = [[AccessInfo alloc] init];
        [self.accessInfo setValuesForKeysWithDictionary:value];
    } else if ([key isEqualToString:@"searchInfo"]) {
        self.searchInfo = [[SearchInfo alloc] init];
        [self.searchInfo setValuesForKeysWithDictionary:value];
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    return;
}

@end
