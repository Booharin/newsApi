//
//  NewsTableViewCell.h
//  newsApi
//
//  Created by Александр on 29.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewItem.h"
@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *articleTitleView;
@property (weak, nonatomic) IBOutlet UILabel *articleDescriptionView;
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UILabel *articleLinkView;
@property (weak, nonatomic) IBOutlet UILabel *authorView;
@end
