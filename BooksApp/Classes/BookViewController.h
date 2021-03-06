//
//  BookViewController.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BooksModel.h"

@interface BookViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BooksModel *bookModel;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

