//
//  BookDetailViewController.m
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "BookDetailViewController.h"
#import "Item.h"

@interface BookDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UITextView *snippetTextView;

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [[_selectedItem volumeInfo] title];
    // Do any additional setup after loading the view.
    UIImage *icon = [[[_selectedItem volumeInfo] imageLinks] smallThumbnailIcon];
    if (icon) {
        [self.imageView setImage:icon];
    } else {
        [self.imageView setImage:[UIImage imageNamed:@"Placeholder.png"]];
    }
    [self.titleLabel setText:[[_selectedItem volumeInfo] title]];
    [self.authorsLabel setText:[[_selectedItem volumeInfo] authors][0]];
    [self.subTitleLabel setText:[[_selectedItem volumeInfo] subtitle]];
    [self.descriptionTextView setText:[[_selectedItem volumeInfo] descriptionVal]];
    [self.ratingLabel setText:[NSString stringWithFormat:@"Average Rating: %.1f",[[_selectedItem volumeInfo] averageRating]]];
    [self.snippetTextView setText:[[_selectedItem searchInfo] textSnippet]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
