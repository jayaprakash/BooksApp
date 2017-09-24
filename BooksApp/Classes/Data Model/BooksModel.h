//
//  BooksModel.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface BooksModel : NSObject
@property (nonatomic, strong) NSString* kind;
@property (nonatomic, assign) NSString* totalItems;
@property (nonatomic, strong) NSArray<Item *>* items;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
