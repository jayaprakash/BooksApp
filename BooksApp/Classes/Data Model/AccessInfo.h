//
//  AccessInfo.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ePub.h"

@interface AccessInfo : NSObject
@property (nonatomic, strong) NSString* country;
@property (nonatomic, strong) NSString* viewability;
@property (nonatomic, assign) BOOL embeddable;
@property (nonatomic, assign) BOOL publicDomain;
@property (nonatomic, strong) NSString* textToSpeechPermission;
@property (nonatomic, strong) ePub* epub;
@property (nonatomic, strong) ePub* pdf;
@property (nonatomic, strong) NSString* webReaderLink;
@property (nonatomic, strong) NSString* accessViewStatus;
@property (nonatomic, assign) BOOL quoteSharingAllowed;
@end
