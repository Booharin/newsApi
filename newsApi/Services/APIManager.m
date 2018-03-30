//
//  APIManager.m
//  newsApi
//
//  Created by Александр on 29.03.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

#import "APIManager.h"
#import "NewItem.h"

#define API_TOKEN @"60c124c4db164f11800e3c0f61dc547d"
#define API_MAIN_HOST   @"newsapi.org/v2"

@implementation APIManager

+ (instancetype)sharedInstance {
    static APIManager *shared;
    static dispatch_once_t dispatchOperation;
    dispatch_once(&dispatchOperation, ^{
        shared = [[APIManager alloc] init];
    });
    return shared;
}

- (void)loadWithURLString:(NSString *)urlString completion:(void (^)(id _Nullable result))completion {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIApplication.sharedApplication.networkActivityIndicatorVisible = YES;
    });
    [[NSURLSession.sharedSession
      dataTaskWithURL:url
      completionHandler:^(
                          NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
          dispatch_async(dispatch_get_main_queue(), ^{
              UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
          });
          completion([NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil]);
      }] resume];
}

#pragma mark News request

- (void)newsWithRequest:(NewsRequest)request withCompletion:(void (^)(NSArray *news))completion {
    
    NSString *urlString = [[[self urlForNewsRequest:request] absoluteString] stringByRemovingPercentEncoding];
    //NSLog(@"Requset URL String is: %@", urlString);
    
    [self loadWithURLString:urlString completion:^(id result) {

        NSArray *json = [(NSArray *) result valueForKey:@"articles"];
        NSMutableArray *array = [NSMutableArray new];

        if ([json isKindOfClass:[NSArray class]]) {
            for (NSDictionary *value in json) {
                NewItem *newItem = [[NewItem alloc] initWithDictionary:value];
                [array addObject:newItem];
            }
        } else { NSLog(@"Program stops because this one: %@", json); }

        dispatch_async(dispatch_get_main_queue(), ^{
            completion(array);
        });
    }];
    
}

- (NSURL *)urlForNewsRequest:(NewsRequest)request {
    NSURLComponents *components = [NSURLComponents new];
    components.scheme = @"https";
    components.host = API_MAIN_HOST;
    components.path = request.path;
    
    NSMutableArray *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *token = [[NSURLQueryItem alloc] initWithName:@"apiKey" value: API_TOKEN];
    [queryItems addObject:token];
    
    NSURLQueryItem *country = [[NSURLQueryItem alloc] initWithName:@"country" value:request.country];
    [queryItems addObject:country];
    
    NSURLQueryItem *category = [[NSURLQueryItem alloc] initWithName:@"category" value:request.category];
    [queryItems addObject:category];
    
    components.queryItems = queryItems;
    
    return [components URL];
}

@end
