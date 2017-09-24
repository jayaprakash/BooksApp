//
//  BookDetailViewController.h
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@interface BookDetailViewController : UIViewController

@property(nonatomic, strong) Item *selectedItem;
@end
