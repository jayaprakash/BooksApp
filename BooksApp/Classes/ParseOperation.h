//
//  ParseOperation.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BooksModel.h"

@interface ParseOperation : NSOperation
// A block to call when an error is encountered during parsing.
@property (nonatomic, copy) void (^errorHandler)(NSError *error);

// BooksModel containing instances for each Book parsed
// from the input data.
// Only meaningful after the operation has completed.
@property (nonatomic, strong, readonly) BooksModel *booksModel;

// The initializer for this NSOperation subclass.
- (instancetype)initWithData:(NSData *)data;
@end
