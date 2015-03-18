//
//  APiKeyModel.h
//  UsoDeSuelo
//
//  Created by Cuauhtemoc Ramirez on 08/03/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <Realm/Realm.h>

// ApiKey model

@interface ApiKeyModel : RLMObject

@property NSInteger id;
@property NSString *api_key;

+ (NSString *)getApiKey;
@end
RLM_ARRAY_TYPE(ApiKeyModel)
