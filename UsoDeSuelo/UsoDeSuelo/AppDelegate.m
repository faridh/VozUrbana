//
//  AppDelegate.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "AppDelegate.h"
#import "APIRequester.h"
#import <FacebookSDK/FacebookSDK.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <Realm/Realm.h>
#import "ApiKeyModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize rootNavigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [DataSource new];
    [SVProgressHUD setBackgroundColor:[ViewDecorator lightBlueColor]];
    [SVProgressHUD setForegroundColor:[ViewDecorator whiteColor]];
    self.rootNavigationController = (UINavigationController *)self.window.rootViewController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    if(wasHandled){
        NSString *accessToken = [FBSession activeSession].accessTokenData.accessToken;
        
        NSMutableDictionary *params = [NSMutableDictionary new];
        params[@"access_token"] = accessToken;
        
        NSString *url_login = @"http://vozurbana.mx/api/blueberry/users/facebook/";
        //NSString *url_login = @"http://127.0.0.1:8000/api/blueberry/users/facebook/";
        [APIRequester post:url_login WithParams:params WithSuccess:^(NSDictionary *response) {
            if ( response ) {
                    [DataSource instance].apiKey = response[@"api_key"];
                    NSLog(@"api_key: %@", [DataSource instance].apiKey);
                
                    //Creating a primary key object
                    ApiKeyModel *apiKeyObject = [[ApiKeyModel alloc] init];
                    apiKeyObject.api_key = response[@"api_key"];
                    apiKeyObject.id = @1;
                
                    //Updating api key with id = 1
                    RLMRealm *realm = RLMRealm.defaultRealm;
                    [realm beginWriteTransaction];
                    [ApiKeyModel createOrUpdateInRealm:realm withObject:apiKeyObject];
                    [realm commitWriteTransaction];
                }
            } AndError:^(NSDictionary *errorResponse, NSError *error) {
                NSLog(@"APIResponse - ERROR: %@", error);
            }
         ];
    
    }else{
        NSLog(@"No permitido el acceso");
    }
    
    return wasHandled;
}

@end
