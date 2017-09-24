//
//  Price.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/25/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Price : NSObject
@property (nonatomic, strong) NSString* amount;
@property (nonatomic, strong) NSString* amountInMicros;
@property (nonatomic, strong) NSString* currencyCode;
@end
