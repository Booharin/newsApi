//
//  NewsRequest.h
//  newsApi
//
//  Created by Александр on 29.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct NewsRequest {
    __unsafe_unretained NSString *path;
    __unsafe_unretained NSString *country;
    __unsafe_unretained NSString *category;
} NewsRequest;
