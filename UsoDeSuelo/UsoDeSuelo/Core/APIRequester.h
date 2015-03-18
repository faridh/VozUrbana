//
//  APIRequester.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIRequester : NSObject

+ (NSString *)formatBackendURLPath:(NSString *)relativePath withHTTPS:(BOOL)isHttps;

+ (void)get:(NSString *)method WithParams:(NSDictionary *)params
WithSuccess:(void (^)(NSDictionary *response))successBlock
   AndError:(void (^)(NSDictionary *errorResponse, NSError *error))errorBlock;

+ (void)post:(NSString *)method WithParams:(NSDictionary *)params
 WithSuccess:(void (^)(NSDictionary *response))successBlock
    AndError:(void (^)(NSDictionary *errorResponse, NSError *error))errorBlock;

@end
