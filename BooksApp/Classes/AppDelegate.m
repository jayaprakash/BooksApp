//
//  AppDelegate.m
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "AppDelegate.h"
#import "ParseOperation.h"
#import "BookViewController.h"


// the http URL used for fetching the books
static NSString *const FreeEBooks = @"https://www.googleapis.com/books/v1/volumes?filter=ebooks&q=a";//@"https://www.googleapis.com/books/v1/volumes?filter=free-ebooks&q=a";

@interface AppDelegate ()
// the queue to run our "ParseOperation"
@property (nonatomic, strong) NSOperationQueue *queue;

// the NSOperation driving the parsing of the RSS feed
@property (nonatomic, strong) ParseOperation *parser;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self retrieveDataFromSource];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)retrieveDataFromSource {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:FreeEBooks]];
    
    // create an session data task to obtain and the XML feed
    NSURLSessionDataTask *sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    // in case we want to know the response status code
    //NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
                                                                            
    if (error != nil)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if ([error code] == NSURLErrorAppTransportSecurityRequiresSecureConnection)
            {
                // if you get error NSURLErrorAppTransportSecurityRequiresSecureConnection (-1022),
                // then your Info.plist has not been properly configured to match the target server.
                //
                abort();
            }
            else
            {
                [self handleError:error];
            }
        }];
    }
    else
    {
        // create the queue to run our ParseOperation
        self.queue = [[NSOperationQueue alloc] init];
        
        // create an ParseOperation (NSOperation subclass) to parse the RSS feed data so that the UI is not blocked
        _parser = [[ParseOperation alloc] initWithData:data];
        
        __weak AppDelegate *weakSelf = self;
        
        self.parser.errorHandler = ^(NSError *parseError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [weakSelf handleError:parseError];
            });
        };
        
        // referencing parser from within its completionBlock would create a retain cycle
        __weak ParseOperation *weakParser = self.parser;
        
        self.parser.completionBlock = ^(void) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (weakParser.booksModel != nil)
            {
                // The completion block may execute on any thread.  Because operations
                // involving the UI are about to be performed, make sure they execute on the main thread.
                //
                dispatch_async(dispatch_get_main_queue(), ^{
                    // The root rootViewController is the only child of the navigation
                    // controller, which is the window's rootViewController.
                    //
                    BookViewController *rootViewController = (BookViewController*)[(UINavigationController*)weakSelf.window.rootViewController topViewController];
                    
                    rootViewController.bookModel = weakParser.booksModel;
                    
                    // tell our table view to reload its data, now that parsing has completed
                    [rootViewController.tableView reloadData];
                });
            }
            
            // we are finished with the queue and our ParseOperation
            weakSelf.queue = nil;
        };
        
        [self.queue addOperation:self.parser]; // this will start the "ParseOperation"
    }
}];
    
    [sessionTask resume];
    
    // show in the status bar that network activity is starting
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// -------------------------------------------------------------------------------
//    handleError:error
//  Reports any error with an alert which was received from connection or loading failures.
// -------------------------------------------------------------------------------
- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    
    // alert user that our current record was deleted, and then we leave this view controller
    //
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Show Top Paid Apps"
                                                                   message:errorMessage
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         // dissmissal of alert completed
                                                     }];
    
    [alert addAction:OKAction];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
