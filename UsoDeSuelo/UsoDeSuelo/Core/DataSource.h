//
//  DataSource.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataSource : NSObject

#pragma mark - Initialization
+ (DataSource *) instance;

@property (nonatomic, strong) NSArray *reportTypes;
@property (strong, nonatomic) NSDictionary *selectedLocation;
@property (strong, nonatomic) NSDictionary *selectedLotInformation;
@property (strong, nonatomic) NSString *apiKey;

#pragma mark - Data methods
+ (NSString *)pathForDataFile:(NSString *) fileName;
+ (NSString *)cleanString:(NSString *) originalString;
+ (NSString *)formatNumberAsString:(NSNumber *) number;

+ (NSString *)jsonStringFromArray:(NSArray *) array;
+ (NSString *)jsonStringFromDictionary:(NSDictionary *) array;
+ (NSArray *)jsonArrayFromString:(NSString *) jsonString;
+ (NSDictionary *)jsonDictionaryFromString:(NSString *) jsonString;

#pragma mark - Display methods
+ (CGSize) screenSize;

@end
