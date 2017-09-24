//
//  BookViewController.m
//  BooksApp
//
//  Created by Jayaprakash Manchu on 9/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "BookViewController.h"
#import "BooksModel.h"
#import "Item.h"
#import "VolumeInfo.h"
#import "KeychainWrapper.h"
#import "BookDetailViewController.h"
#import "IconDownloader.h"

#define kCustomRowCount 7
#define kTopRatedVal 4.0

static NSString *CellIdentifier = @"LazyTableCell";
static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";

@interface BookViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) KeychainWrapper *keychain;
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButtonItem;
@property (assign, nonatomic) BOOL isLoadingAll;
@property (nonatomic, strong) NSArray *itemsToDisplay;
@property (nonatomic, strong) NSMutableDictionary *markedItemIds;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.keychain = [[KeychainWrapper alloc] init];
    _imageDownloadsInProgress = [NSMutableDictionary dictionary];
    self.isLoadingAll = true;
    [_rightBarButtonItem setEnabled:NO];
    NSDictionary *markedIds;
    /*id *savedData = [self.keychain myObjectForKey:(__bridge NSString *)kSecValueData];
    if ([archivedData isKindOfClass:NSClassFromString(@"NSData")] &&  archivedData.length > 0) {
        markedIds = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
    }*/
    self.markedItemIds = !markedIds ? [NSMutableDictionary dictionaryWithDictionary:markedIds] : [NSMutableDictionary dictionary];
}

- (IBAction)toggleAllVsTopRated:(id)sender {
    _isLoadingAll = !_isLoadingAll;
    [(UIBarButtonItem *)sender setTitle:(_isLoadingAll?@"Top Rated":@"All")];
    if(!_isLoadingAll) {
        NSPredicate *topRatedPredicate = [NSPredicate predicateWithFormat:@"volumeInfo.averageRating >= %f",kTopRatedVal];
        self.itemsToDisplay = [_bookModel.items filteredArrayUsingPredicate:topRatedPredicate];
    } else {
        self.itemsToDisplay = _bookModel.items;
    }
    [_tableView reloadData];
}

- (void)setBookModel:(BooksModel *)bookModel {
    _bookModel = bookModel;
    self.itemsToDisplay = _bookModel.items;
    [_rightBarButtonItem setEnabled:YES];
}

- (IBAction)togglePendingVsRead:(id)sender {
    UITableViewCell *cell = (UITableViewCell *)[[(UIButton *)sender superview] superview];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    Item *selectedItem = [self.itemsToDisplay objectAtIndex:indexPath.row];
    if([[_markedItemIds allKeys] containsObject:selectedItem.idValue]) {
        [_markedItemIds removeObjectForKey:selectedItem.idValue];
        [(UIButton *)sender setTitle:@"Pending" forState:UIControlStateNormal];
    } else {
        [_markedItemIds setValue:@"Read" forKey:selectedItem.idValue];
        [(UIButton *)sender setTitle:@"Read" forState:UIControlStateNormal];
    }
/*
    [self.keychain mySetObject:_markedItemIds forKey:(__bridge NSString *)kSecValueData];
    [self.keychain writeToKeychain];*/
}

// -------------------------------------------------------------------------------
//    terminateAllDownloads
// -------------------------------------------------------------------------------
- (void)terminateAllDownloads
{
    // terminate all pending download connections
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [self.imageDownloadsInProgress removeAllObjects];
}

// -------------------------------------------------------------------------------
//    dealloc
//  If this view controller is going away, we need to cancel all outstanding downloads.
// -------------------------------------------------------------------------------
- (void)dealloc
{
    // terminate all pending download connections
    [self terminateAllDownloads];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self terminateAllDownloads];
}

#pragma mark - UITableViewDataSource

// -------------------------------------------------------------------------------
//    tableView:numberOfRowsInSection:
//  Customize the number of rows in the table view.
// -------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = [_itemsToDisplay count];
    
    // if there's no data yet, return enough rows to fill the screen
    if (count == 0)
    {
        return kCustomRowCount;
    }
    return count;
}

// -------------------------------------------------------------------------------
//    tableView:cellForRowAtIndexPath:
// -------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    NSUInteger nodeCount = [_itemsToDisplay count];
    
    if (nodeCount == 0 && indexPath.row == 0)
    {
        // add a placeholder cell while waiting on table data
        cell = [tableView dequeueReusableCellWithIdentifier:PlaceholderCellIdentifier forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Leave cells empty if there's no data yet
        if (nodeCount > 0)
        {
            // Set up the cell representing the app
            Item *selectedItem = _itemsToDisplay[indexPath.row];
            VolumeInfo *volumeInfo = selectedItem.volumeInfo;
            
            cell.textLabel.text = volumeInfo.title;
            cell.detailTextLabel.text = volumeInfo.subtitle;
            [(UIButton *)[cell.contentView viewWithTag:10] setTitle:[[_markedItemIds allKeys] containsObject:selectedItem.idValue]?@"Read":@"Pending" forState:UIControlStateNormal];
            
            // Only load cached images; defer new downloads until scrolling ends
            if (!volumeInfo.imageLinks.smallThumbnailIcon)
            {
                if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
                {
                    [self startIconDownload:selectedItem forIndexPath:indexPath];
                }
                // if a download is deferred or in progress, return a placeholder image
                cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
            }
            else
            {
                cell.imageView.image = volumeInfo.imageLinks.smallThumbnailIcon;
            }
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"pushToDetails" sender:[tableView cellForRowAtIndexPath:indexPath]];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"pushToDetails"])
    {
        //if you need to pass data to the next controller do it here
        NSInteger selectedRow = [self.tableView indexPathForCell:(UITableViewCell *)sender].row;
        Item *selectedItem = [_itemsToDisplay  objectAtIndex:selectedRow];
        [(BookDetailViewController *)[segue destinationViewController] setSelectedItem:selectedItem];
    }
}


#pragma mark - Table cell image support

// -------------------------------------------------------------------------------
//    startIconDownload:forIndexPath:
// -------------------------------------------------------------------------------
- (void)startIconDownload:(Item *)selectedItem forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.itemVal = selectedItem;
        [iconDownloader setCompletionHandler:^{
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.imageView.image = selectedItem.volumeInfo.imageLinks.smallThumbnailIcon;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        (self.imageDownloadsInProgress)[indexPath] = iconDownloader;
        [iconDownloader startDownload];
    }
}

// -------------------------------------------------------------------------------
//    loadImagesForOnscreenRows
//  This method is used in case the user scrolled into a set of cells that don't
//  have their app icons yet.
// -------------------------------------------------------------------------------
- (void)loadImagesForOnscreenRows
{
    if ([_itemsToDisplay count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            Item *itemRec = _itemsToDisplay[indexPath.row];
            
            if (!itemRec.volumeInfo.imageLinks.smallThumbnailIcon)
                // Avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:itemRec forIndexPath:indexPath];
            }
        }
    }
}


#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//    scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//    scrollViewDidEndDecelerating:scrollView
//  When scrolling stops, proceed to load the app icons that are on screen.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

@end
