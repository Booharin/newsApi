//
//  NewsNavigationController.m
//  newsApi
//
//  Created by Александр on 29.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import "NewsNavigationController.h"
#import "NewsTableViewController.h"

@interface NewsNavigationController ()

@end

@implementation NewsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    NewsTableViewController *newsController = [storyboard instantiateViewControllerWithIdentifier:
                                               NSStringFromClass([NewsTableViewController class])];
    [self pushViewController:newsController animated:YES];
}

@end
