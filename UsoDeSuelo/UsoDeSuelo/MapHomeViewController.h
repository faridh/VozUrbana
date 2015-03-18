//
//  MapHomeViewController.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "LotPreview.h"

@interface MapHomeViewController : UIViewController<CLLocationManagerDelegate, GMSMapViewDelegate, LotPreviewDelegate>

@property CLLocationCoordinate2D initialLocation;
@property BOOL bootsFromLocation;
@property int locationRefreshCounter;

- (id)init;

@end
