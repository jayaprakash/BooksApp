//
//  VolumeInfo.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndustryIdentifiers.h"
#import "ReadingModes.h"
#import "ImageLinks.h"

@interface VolumeInfo : NSObject
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* subtitle;
@property (nonatomic, strong) NSArray<NSString *> *authors;
@property (nonatomic, strong) NSString* publishedDate;
@property (nonatomic, strong) NSArray<IndustryIdentifiers *> *industryIdentifiers;
@property (nonatomic, strong) ReadingModes * readingModes;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSString* printType;
@property (nonatomic, strong) NSArray<NSString *> *categories;
@property (nonatomic, assign) double averageRating;
@property (nonatomic, assign) NSInteger ratingsCount;
@property (nonatomic, strong) NSString* maturityRating;
@property (nonatomic, assign) BOOL allowAnonLogging;
@property (nonatomic, strong) NSString* contentVersion;
@property (nonatomic, strong) ImageLinks* imageLinks;
@property (nonatomic, strong) NSString* language;
@property (nonatomic, strong) NSString* previewLink;
@property (nonatomic, strong) NSString* infoLink;
@property (nonatomic, strong) NSString* canonicalVolumeLink;
@end
