//
//  SaleInfo.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaleInfo : NSObject
@property (nonatomic, strong) NSString* country;
@property (nonatomic, strong) NSString* saleability;
@property (nonatomic, assign) BOOL isEbook;
@property (nonatomic, strong) NSString* buyLink;
@end
