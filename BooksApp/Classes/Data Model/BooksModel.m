//
//  BooksModel.m
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "BooksModel.h"

@interface BooksModel ()
@end

@implementation BooksModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forKey:(nonnull NSString *)key {
    [super setValue:value forKey:key];
    if([key isEqualToString:@"items"]) {
        NSMutableArray *array = [NSMutableArray array];
        for(int i = 0; i< [(NSArray *)value count]; i ++) {
            Item *item = [[Item alloc] init];
            [item setValuesForKeysWithDictionary:value[i]];
            [array addObject:item];
        }
        self.items = [NSArray arrayWithArray:array];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    return;
}

@end
