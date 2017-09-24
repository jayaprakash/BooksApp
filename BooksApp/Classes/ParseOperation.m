//
//  ParseOperation.m
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "ParseOperation.h"
#import "BooksModel.h"

@interface ParseOperation ()
@property (nonatomic, strong) NSData *dataToParse;
@property (nonatomic, strong) BooksModel *booksModel;
@end

@implementation ParseOperation

// -------------------------------------------------------------------------------
//    initWithData:
// -------------------------------------------------------------------------------
- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self != nil)
    {
        _dataToParse = data;
    }
    return self;
}

// -------------------------------------------------------------------------------
//    main
//  Entry point for the operation.
//  Given data to parse, use Json Parser and process all the books.
// -------------------------------------------------------------------------------
- (void)main
{
    // The default implemetation of the -start method sets up an autorelease pool
    // just before invoking -main however it does NOT setup an excption handler
    // before invoking -main.  If an exception is thrown here, the app will be
    // terminated.
    /*
    _workingArray = [NSMutableArray array];
    _workingPropertyString = [NSMutableString string];
    
    // It's also possible to have NSXMLParser download the data, by passing it a URL, but this is not
    // desirable because it gives less control over the network, particularly in responding to
    // connection errors.
    //
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.dataToParse];
    [parser setDelegate:self];
    [parser parse];
    
    if (![self isCancelled])
    {
        // Set appRecordList to the result of our parsing
        self.appRecordList = [NSArray arrayWithArray:self.workingArray];
    }
    
    self.workingArray = nil;
    self.workingPropertyString = nil;
    self.dataToParse = nil;
     */
    
    NSError        *error        = nil;
    id         jsonObject    = nil;
    jsonObject = [NSJSONSerialization JSONObjectWithData:self.dataToParse options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil){
        self.booksModel = [[BooksModel alloc]  initWithDictionary:jsonObject];
    } else {
        if (self.errorHandler) {
            self.errorHandler(error);
        }
    }
    
    jsonObject = nil;
}


@end
