//
//  Items.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VolumeInfo.h"
#import "SaleInfo.h"
#import "AccessInfo.h"
#import "SearchInfo.h"

@interface Item : NSObject
@property (nonatomic, strong) NSString* kind;
@property (nonatomic, strong) NSString* idValue;
@property (nonatomic, strong) NSString* etag;
@property (nonatomic, strong) NSString* selfLink;
@property (nonatomic, strong) VolumeInfo* volumeInfo;
@property (nonatomic, strong) SaleInfo* saleInfo;
@property (nonatomic, strong) AccessInfo* accessInfo;
@property (nonatomic, strong) SearchInfo* searchInfo;
@end
