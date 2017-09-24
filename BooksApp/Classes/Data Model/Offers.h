//
//  Offers.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/25/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Price;

@interface Offers : NSObject
@property (nonatomic, assign) long finskyOfferType;
@property (nonatomic, strong) Price* listPrice;
@property (nonatomic, strong) Price* retailPrice;
@end
