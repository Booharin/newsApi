//
//  NewItem.h
//  newsApi
//
//  Created by Александр on 29.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewItem : NSObject

@property(nonatomic, strong) NSString *author;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *descriptionOfArticle;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSString *urlToImage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
