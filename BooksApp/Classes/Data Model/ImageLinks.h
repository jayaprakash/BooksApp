//
//  ImageLinks.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageLinks : NSObject
@property (nonatomic, strong) NSString* smallThumbnail;
@property (nonatomic, strong) NSString* thumbnail;

//Additional data not part of data model
@property (nonatomic, strong) UIImage *smallThumbnailIcon;
@property (nonatomic, strong) UIImage *thumbnailIcon;
@end
