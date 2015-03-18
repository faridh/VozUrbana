//
//  ApiKeyModel.m
//  UsoDeSuelo
//
//  Created by Cuauhtemoc Ramirez on 08/03/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiKeyModel.h"

@implementation ApiKeyModel

@synthesize id;
@synthesize api_key;

// Specify default values for properties
+ (NSDictionary *)defaultPropertyValues
{
    return @{};
}

// Specify properties to ignore (Realm won't persist these)
+ (NSArray *)ignoredProperties
{
    return @[];
}

+ (NSString *)primaryKey {
    return @"id";
}

+ (NSString *)getApiKey
{
    ApiKeyModel *api;
    RLMResults *apiQuery = [ApiKeyModel objectsWhere:[NSString stringWithFormat:@"id == 1"]];
    if ( apiQuery.count == 0 ) {
        return @"";
    } else {
        api = [apiQuery objectAtIndex:0];
        return api.api_key;
    }
}

@end

