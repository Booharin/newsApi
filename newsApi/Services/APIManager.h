//
//  APIManager.h
//  newsApi
//
//  Created by Александр on 29.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsRequest.h"

@interface APIManager : NSObject

+ (instancetype)sharedInstance;

- (void)newsWithRequest:(NewsRequest)request withCompletion:(void (^)(NSArray *news))completion;

@end
