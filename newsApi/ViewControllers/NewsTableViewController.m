//
//  NewsTableViewController.m
//  newsApi
//
//  Created by Александр on 29.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import "NewsTableViewController.h"
#import "APIManager.h"
#import "NewsTableViewCell.h"

#define kRowHeight 50.0

@interface NewsTableViewController ()
@property(nonatomic) NewsRequest newsRequest;
@property(nonatomic, strong) NSArray *news;
@property(nonatomic, strong) NSDictionary *selectedIndexes;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNews];
    [self performViewInitialization];
    _selectedIndexes = [[NSMutableDictionary alloc] init];
}

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
    NSNumber *selectedIndex = [_selectedIndexes objectForKey:indexPath];
    return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

- (void)performViewInitialization {
    self.navigationItem.title = @"News";
}

-(void)getNews {

    _newsRequest.path = @"/top-headlines";
    _newsRequest.country = @"us";
    _newsRequest.category = @"business";
    
    [APIManager.sharedInstance newsWithRequest:_newsRequest withCompletion:^(NSArray *news) {
        _news = news;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self cellIsSelected:indexPath]) {
        return kRowHeight * 12.0;
    }
    return kRowHeight * 2.5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _news.count;
}

#pragma mark - Table view delegate


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCellIdentifier"
                                                              forIndexPath:indexPath];
    NewItem *new = _news[(NSUInteger) indexPath.row];
    
    cell.articleTitleView.text = new.title;
    cell.articleDescriptionView.text = [self getTrimmedString: new.descriptionOfArticle];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    BOOL isSelected = ![self cellIsSelected:indexPath];
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    
    [_selectedIndexes setValue:selectedIndex forKey:indexPath];
    
    NewsTableViewCell *cell = (NewsTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NewItem *new = _news[(NSUInteger) indexPath.row];
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    if([self cellIsSelected:indexPath]) {
        cell.articleDescriptionView.text = new.descriptionOfArticle;
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: new.urlToImage]];
        cell.articleImageView.image = [UIImage imageWithData: imageData];
        cell.articleLinkView.text = new.url;
        cell.authorView.text = new.author;
    } else {
        cell.articleDescriptionView.text = [self getTrimmedString: new.descriptionOfArticle];
        cell.articleImageView.image = nil;
        cell.articleLinkView.text = @"";
        cell.authorView.text = @"";
    }
}

- (NSString *)getTrimmedString:(NSString *)fromString {
    if (fromString.length > 50) {
        NSString *newString = [fromString substringToIndex:50];
        newString = [newString stringByAppendingString:@"..."];
        return newString;
    } else {
        return fromString;
    }
}

@end
