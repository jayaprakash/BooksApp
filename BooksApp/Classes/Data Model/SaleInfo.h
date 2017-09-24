//
//  SaleInfo.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Price.h"
#import "Offers.h"

@interface SaleInfo : NSObject
@property (nonatomic, strong) NSString* country;
@property (nonatomic, strong) NSString* saleability;
@property (nonatomic, strong) Price* listPrice;
@property (nonatomic, strong) Price* retailPrice;
@property (nonatomic, assign) BOOL isEbook;
@property (nonatomic, strong) NSString* buyLink;
@property (nonatomic, strong) NSArray <Offers *> *offers;
@end
