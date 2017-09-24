//
//  ImageLinks.m
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "ImageLinks.h"
#import "NSURL+Parameters.h"

@interface ImageLinks()
@property (nonatomic, strong) NSFileManager *fileManager;
@end

@implementation ImageLinks

- (instancetype)init {
    self = [super init];
    if (self) {
        self.fileManager = [NSFileManager defaultManager];
    }
    return self;
}

- (void)setValue:(id)value forKey:(nonnull NSString *)key {
    [super setValue:value forKey:key];
    if([key isEqualToString:@"smallThumbnail"]) {
        self.smallThumbnailIcon = [self getImageFromFileNamed:value];
    } else if([key isEqualToString:@"thumbnail"]) {
        self.thumbnailIcon = [self getImageFromFileNamed:value];
    }
}

- (UIImage *)getImageFromFileNamed:(NSString *) url {
    UIImage *img = nil;
    NSURL *urlStr = [NSURL URLWithString:url];
    NSString *idVal = urlStr[@"id"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:idVal];
    if([_fileManager fileExistsAtPath:filePath]) {
        img = [UIImage imageWithContentsOfFile:filePath];
    }
    return img;
}

@end
