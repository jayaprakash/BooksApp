//
//  ViewController.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BooksModel.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BooksModel *bookModel;

@end

