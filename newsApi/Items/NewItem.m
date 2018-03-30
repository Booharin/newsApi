//
//  NewItem.m
//  newsApi
//
//  Created by Александр on 29.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import "NewItem.h"

@implementation NewItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _author = [(NSString *) dictionary valueForKey:@"author"];
        if (_author == (id)[NSNull null]) {
            _author = @"";
        }
        _title = [(NSString *) dictionary valueForKey:@"title"];
        if (_title == (id)[NSNull null]) {
            _title = @"";
        }
        _descriptionOfArticle = [(NSString *) dictionary valueForKey:@"description"];
        if (_descriptionOfArticle == (id)[NSNull null]) {
            _descriptionOfArticle = @"";
        }
        _url = [(NSString *) dictionary valueForKey:@"url"];
        if (_url == (id)[NSNull null]) {
            _url = @"";
        }
        _urlToImage = [(NSString *) dictionary valueForKey:@"urlToImage"];
        if (_urlToImage == (id)[NSNull null]) {
            _urlToImage = @"";
        }
    }
    return self;
}

@end
