//
//  APIRequester.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "APIRequester.h"
#import "AFHTTPRequestOperationManager.h"
#import "ApiKeyModel.h" // <- perdon por esto faridh u_U

@implementation APIRequester

+ (NSString *)formatBackendURLPath:(NSString *)relativePath withHTTPS:(BOOL)isHttps;
{
    NSString *tempURLPath;
    if ( isHttps ) {
        tempURLPath = [NSString stringWithFormat:@"http://%@/api/%@", kBackendURL, relativePath];
    } else {
        tempURLPath = [NSString stringWithFormat:@"http://%@/api/%@", kBackendURL, relativePath];
    }
    return  tempURLPath;
}

+ (void)get:(NSString *)method WithParams:(NSDictionary *)params
WithSuccess:(void (^)(NSDictionary *response))successBlock
   AndError:(void (^)(NSDictionary *errorResponse, NSError *error))errorBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSString *apiKey = [NSString stringWithFormat:@"ApiKey %@", [DataSource instance].apiKey];
    NSString *apiKey = [ApiKeyModel getApiKey];
    
    [manager.requestSerializer setValue:apiKey forHTTPHeaderField: @"Authorization"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager GET:method parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             if(successBlock)
                 successBlock(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             if (  error.code == kCFURLErrorNotConnectedToInternet ) {
                 [ViewDecorator executeAlertViewWithTitle:kErrorTitle AndMessage:kErrorMessageNoNetwork];
             }
             if(errorBlock)
                 errorBlock(operation.responseObject, error);
         }];
}

+ (void)post:(NSString *)method WithParams:(NSDictionary *)params
 WithSuccess:(void (^)(NSDictionary *response))successBlock
    AndError:(void (^)(NSDictionary *errorResponse, NSError *error))errorBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    manager.shouldUseCredentialStorage = YES;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //NSString *apiKey = [NSString stringWithFormat:@"ApiKey %@", [DataSource instance].apiKey];
    NSString *apiKey = [ApiKeyModel getApiKey];
    
    [manager.requestSerializer setValue:apiKey forHTTPHeaderField: @"Authorization"];
    [manager POST:method parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
              if ( successBlock )
                  successBlock(responseObject);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
              if (  error.code == kCFURLErrorNotConnectedToInternet ) {
                  [ViewDecorator executeAlertViewWithTitle:kErrorTitle AndMessage:kErrorMessageNoNetwork];
              }
              if ( errorBlock )
                  errorBlock(operation.responseObject, error);
          }];
}

@end
