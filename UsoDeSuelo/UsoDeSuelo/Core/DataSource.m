//
//  DataSource.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

static DataSource *_instance = nil;

NSNumberFormatter *numberFormatter;

@synthesize reportTypes;
@synthesize selectedLocation;
@synthesize selectedLotInformation;
@synthesize apiKey;

/**
 * Singleton accesor to the static object.
 * @return id - A Singleton DataSource
 */
+ (DataSource *) instance
{
    @synchronized([DataSource class]) {
        if ( !_instance ) {
            [self new];
        }
        return _instance;
    }
    return nil;
}

+ (id)alloc
{
    @synchronized([DataSource class]) {
        if ( _instance == nil ) {
            _instance = [super alloc];
        }
        return _instance;
    }
    return nil;
}

- (id)init
{
    if (self = [super init]) {
        printf("DataSource: init().\n");
        
        reportTypes = @[@{@"id":@"1", @"name":@"Uso de Suelo"},
                        @{@"id":@"2", @"name":@"Niveles Permitidos"},
                        @{@"id":@"3", @"name":@"Ruido"}];
        
        // Number Formatter
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        
        selectedLocation = nil;
    }
    return self;
}

#pragma marl - Data methods
+ (NSString *)pathForDataFile:(NSString *) fileName
{
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.usosuelo", fileName]];
}

+ (NSString *)cleanString:(NSString *)originalString
{
    NSString *cleanString = [originalString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return cleanString;
}

+ (NSString *)formatNumberAsString:(NSNumber *)number
{
    return [numberFormatter stringFromNumber:number];
}

+ (NSString *)jsonStringFromArray:(NSArray *)array
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if ( error == nil ) {
        return jsonString;
    } else {
        return @"";
    }
}
+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dictionary
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if ( error == nil ) {
        return jsonString;
    } else {
        return @"";
    }
}
+ (NSArray *)jsonArrayFromString:(NSString *) jsonString
{
    if ( jsonString == nil || [jsonString isKindOfClass:[NSNull class]] || [jsonString isEqualToString:@""] ) {
        return [NSArray new];
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    return jsonArray;
}
+ (NSDictionary *) jsonDictionaryFromString:(NSString *) jsonString
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
    return jsonDictionary;
}

#pragma mark - Display methods
+ (CGSize) screenSize {
    return [[UIScreen mainScreen] bounds].size;
}

@end
