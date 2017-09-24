//
//  BooksModel.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BooksModel : NSObject
@property (nonatomic, strong) NSString* kind;
@property (nonatomic, assign) NSInteger* totalItems;
@property (nonatomic, strong) NSArray* items;
@end
