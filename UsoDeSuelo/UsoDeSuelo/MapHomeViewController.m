//
//  MapHomeViewController.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "AppDelegate.h"
#import "MapHomeViewController.h"
#import "AddReportViewController.h"
#import "APIRequester.h"
#import "LotPreview.h"
#import "MyReportsViewController.h"
#import "ReportsViewController.h"

@interface MapHomeViewController ()

@end

@implementation MapHomeViewController

@synthesize initialLocation;
@synthesize bootsFromLocation;
@synthesize locationRefreshCounter;

CLLocationManager *locationManager;
GMSCameraPosition *camera;
GMSMapView *mapView;
CLGeocoder *geocoder;
CLPlacemark *placemark;
GMSPolygon *previousPolygonTapped;
LotPreview *lotPreview;
BOOL isShowingLotPreview;
BOOL isAnimatingLotPreview;


- (id)init {
    if ( self = [super init] ) {
        [GMSServices provideAPIKey:@"AIzaSyDGdJuhXNLWQDQw5eROMoMvhCW3ZRy6qm0"];
        isShowingLotPreview = NO;
        isAnimatingLotPreview = NO;
    }
    previousPolygonTapped = nil;
    NSLog(@"MHVC init!");

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    camera = [GMSCameraPosition cameraWithLatitude:0 longitude:0 zoom:18];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    [mapView setMinZoom:15 maxZoom:20];
    mapView.delegate = self;
//    mapView.mapType = kGMSTypeSatellite;
    self.view = mapView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ViewDecorator clearNavigationForTabBarController:self.tabBarController];
    [ViewDecorator addBackButtonToTabBarController:self.tabBarController withNavigationController:self.navigationController];
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, 100, 40);
    titleLabel.text = @"Navega";
    titleLabel.textColor = [ViewDecorator whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    titleLabel.backgroundColor = [ViewDecorator clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.tabBarController.navigationItem.titleView = titleLabel;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    locationManager = [DataSource locationManagerInstance];
    locationManager = [CLLocationManager new];
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.delegate = self;
    locationRefreshCounter = 0;

    geocoder = [CLGeocoder new];
    lotPreview = nil;
    
    if ( !bootsFromLocation ) {
        switch ( [CLLocationManager authorizationStatus] ) {
            case kCLAuthorizationStatusAuthorizedWhenInUse:
            case kCLAuthorizationStatusAuthorizedAlways:
                [locationManager stopUpdatingLocation];
                [locationManager startUpdatingLocation];
                break;
            case kCLAuthorizationStatusNotDetermined:
                [locationManager requestWhenInUseAuthorization];
                break;
            case kCLAuthorizationStatusDenied:
                [ViewDecorator executeAlertViewWithTitle:@"Aviso"
                                              AndMessage:@"Su ubicación es requerida para poder ver la información geográfica."];
                break;
            default:
                break;
        }
    }
    else
    {
        [locationManager stopUpdatingLocation];
        [self moveMapToLocation:initialLocation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD show];
            [self getPolygonsForMapView];
        });
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
//    NSLog(@"viewWillDisappear");
    if (locationManager)
    {
        [locationManager stopUpdatingLocation];
        locationManager = nil;
    }
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
//    NSLog(@"viewDidDisappear");
    if (locationManager)
    {
        [locationManager stopUpdatingLocation];
        locationManager = nil;
    }
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)moveMapToLocation:(CLLocationCoordinate2D)location
{
    [mapView clear];
    [mapView animateToLocation:location];
    
    if(!bootsFromLocation)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = location;
        marker.snippet = @"HQ";
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = [UIImage imageNamed:@"pinMarker"];
        marker.map = mapView;
        
//        // Create a rectangular path
//        GMSMutablePath *rect = [GMSMutablePath path];
//        [rect addCoordinate:CLLocationCoordinate2DMake(marker.position.latitude - 0.0005, marker.position.longitude + 0.0005)];
//        [rect addCoordinate:CLLocationCoordinate2DMake(marker.position.latitude + 0.0005, marker.position.longitude + 0.0005)];
//        [rect addCoordinate:CLLocationCoordinate2DMake(marker.position.latitude + 0.0005, marker.position.longitude - 0.0005)];
//        [rect addCoordinate:CLLocationCoordinate2DMake(marker.position.latitude - 0.0005, marker.position.longitude - 0.0005)];
//        
//        // Create the polygon, and assign it to the map.
//        GMSPolygon *polygon = [GMSPolygon polygonWithPath:rect];
//        polygon.fillColor = [ViewDecorator coralColorWithAlpha:0.25f];
//        polygon.strokeColor = [ViewDecorator orangeColor];
//        polygon.strokeWidth = 1;
//        polygon.tappable = YES;
//        polygon.map = mapView;
    }
}
#pragma mark - CLLocationManagerDelegate methods

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            if ( !bootsFromLocation ) {
//                [locationManager startUpdatingLocation];
            }
            break;
        case kCLAuthorizationStatusNotDetermined:
            [locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusDenied:
            [ViewDecorator executeAlertViewWithTitle:@"Aviso"
                                          AndMessage:@"Su ubicación es requerida para poder ver la información geográfica."];
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"locationManager:didFailWithError: %@", error.description);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locationRefreshCounter == 0 && locations.count > 0) {
        locationRefreshCounter = 0;
        CLLocation *currentLocation = (CLLocation *)[locations objectAtIndex:0];
        [self moveMapToLocation:currentLocation.coordinate];
    }
    
    locationRefreshCounter = locationRefreshCounter == 10 ? 0 : locationRefreshCounter + 1;
}

#pragma mark - GMSMapViewDelegate methods
- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture
{
    [SVProgressHUD show];
}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *) position
{
    if (mapView.camera.zoom < 18)
    {
        [mapView clear];
        [SVProgressHUD dismiss];
    }
    else
    {
        [self getPolygonsForMapView];
    }
}

- (void)mapView:(GMSMapView *)mapView didTapOverlay:(GMSOverlay *)overlay
{
    [SVProgressHUD show];
    GMSPolygon *polygon = (GMSPolygon *)overlay;
    if (previousPolygonTapped == nil) {
        previousPolygonTapped = polygon;
    } else {
        previousPolygonTapped.strokeColor = [ViewDecorator orangeColor];
        previousPolygonTapped.fillColor = [ViewDecorator coralColorWithAlpha:0.25f];
        previousPolygonTapped = polygon;
    }
    
    polygon.strokeColor = [ViewDecorator blueColor];
    polygon.fillColor = [ViewDecorator lightBlueColorWithAlpha:0.25f];
    [self getLotInformation: polygon.title];
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    return YES;
}

#pragma mark - Methods for painting polygons
- (void) getPolygonsForMapView
{
//    NSLog(@"getPolygonsForMapView");
    NSMutableDictionary *params = [NSMutableDictionary new];

    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithRegion:mapView.projection.visibleRegion];
    mapView.frame = CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height);
    
    NSString *point_ne = [NSString stringWithFormat:@"%f,%f", bounds.northEast.latitude, bounds.northEast.longitude];
    NSString *point_sw = [NSString stringWithFormat:@"%f,%f", bounds.southWest.latitude, bounds.southWest.longitude];
    params[@"point_ne"] = point_ne;
    params[@"point_sw"] = point_sw;
    
    NSString *url = @"http://vozurbana.mx/api/blueberry/predios/in_polygon";
    [APIRequester get:url WithParams:params WithSuccess:^(NSDictionary *response) {
        if ( response ) {
            [self paintScreenPolygons:response];
            [SVProgressHUD dismiss];
        }
    } AndError:^(NSDictionary *errorResponse, NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"APIResponse - ERROR: %@", error);
    }];
}

-(void) paintScreenPolygons:(NSDictionary *)response
{
    [mapView clear];
    
    for(id object in response[@"objects"])
    {
        GMSMutablePath *rect = [GMSMutablePath path];
        
        for(id coordinates in object[@"geom"][@"coordinates"][0][0])
        {
            NSString *latitude = coordinates[1];
            NSString *longitude = coordinates[0];
            [rect addCoordinate:CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue)];
        }
        
        // Create the polygon, and assign it to the map.
        GMSPolygon *polygon = [GMSPolygon polygonWithPath:rect];
        polygon.fillColor = [ViewDecorator coralColorWithAlpha:0.25f];
        polygon.strokeColor = [ViewDecorator orangeColor];
        polygon.strokeWidth = 1;
        polygon.tappable = YES;
        polygon.title = object[@"catastro"];
        polygon.map = mapView;
    }
}

#pragma mark - Methods for requesting polygon information
- (void) getLotInformation:(NSString *)lotId
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"catastro"] = lotId;
    
    NSString *url = @"http://api.propiedades.com/api/private/properties";
    [APIRequester get:url WithParams:params WithSuccess:^(NSDictionary *response) {
        [SVProgressHUD dismiss];
        if ( response ) {
            [DataSource instance].selectedLotInformation = response;
            [self populateLotPreview];
        }
    } AndError:^(NSDictionary *errorResponse, NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"APIResponse - ERROR: %@", error);
    }];
}

- (void)populateLotPreview {
    
    NSDictionary *currentLot = [DataSource instance].selectedLotInformation[@"objects"][0];
    NSLog(@"CurrentLot:\n%@", currentLot);
    dispatch_group_t asyncOperation = dispatch_group_create();
    if ( lotPreview != nil ) {
        dispatch_group_enter(asyncOperation);
        [UIView animateWithDuration:0.5f animations:^{
            lotPreview.alpha = 0.0f;
        } completion:^(BOOL finished) {
            if ( finished ) {
                [lotPreview removeFromSuperview];
                dispatch_group_leave(asyncOperation);
            }
        }];
    } else {
        dispatch_group_enter(asyncOperation);
        dispatch_group_leave(asyncOperation);
    }
    
    dispatch_group_notify(asyncOperation, dispatch_get_main_queue(), ^{
        
        // Instantiate the nib content without any reference to it.
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"LotPreview" owner:nil options:nil];
        
        // Find the view among nib contents (not too hard assuming there is only one view in it).
        lotPreview = [nibContents lastObject];
        lotPreview.frame = CGRectMake(0, [DataSource screenSize].height - 120,
                                      [DataSource screenSize].width, lotPreview.frame.size.height);
        lotPreview.backgroundColor = [ViewDecorator whiteColor];
        lotPreview.userInteractionEnabled = YES;
        lotPreview.alpha = 0.0f;
        [lotPreview setupView];
        lotPreview.delegate = self;
        
        lotPreview.addressLabel.text = [NSString stringWithFormat:@"%@ %@ (%@)",
                                        currentLot[@"street"], currentLot[@"number"], currentLot[@"land_use"]];
        lotPreview.neighborhoodLabel.text = [NSString stringWithFormat:@"%@, %@", currentLot[@"colony_catastro"],
                                             currentLot[@"city_catastro"]];
        lotPreview.cuentaCatastralLabel.text = (NSString *)currentLot[@"catastro"];
        lotPreview.superficieLabel.text = [NSString stringWithFormat:@"%@m\u00B2", currentLot[@"size"]];
        lotPreview.construccionLabel.text = [NSString stringWithFormat:@"%@m\u00B2", currentLot[@"max_construction"]];
        lotPreview.areaLibreLabel.text = [NSString stringWithFormat:@"%@m\u00B2", currentLot[@"free_area"]];
        lotPreview.nivelesLabel.text = [NSString stringWithFormat:@"%@", currentLot[@"levels"]];
        lotPreview.alturaLabel.text = [NSString stringWithFormat:@"%@", currentLot[@"height"]];;
        lotPreview.densidadLabel.text = [NSString stringWithFormat:@"%@", currentLot[@"density"]];;
        lotPreview.minViviendaLabel.text = [NSString stringWithFormat:@"%@", currentLot[@"min_dewlling"]];;
        lotPreview.maxViviendaLabel.text = [NSString stringWithFormat:@"%@", currentLot[@"max_dewlling"]];;
        [lotPreview.cancelButton addTarget:self action:@selector(toggleLotPreview) forControlEvents:UIControlEventTouchUpInside];
        [lotPreview.generateReportButton addTarget:self action:@selector(showAddReport) forControlEvents:UIControlEventTouchUpInside];
        [lotPreview.viewReportsButton addTarget:self action:@selector(showReports) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:lotPreview];
        
        [UIView animateWithDuration:0.5f animations:^{
            lotPreview.alpha = 1.0f;
        } completion:^(BOOL finished) {
            //
        }];
        
    });
}
- (void)showAddReport {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddReportViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"AddReportViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)showReports {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ReportsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ReportsViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LotPreviewDelegate methods
- (void)toggleLotPreview {
    if ( isAnimatingLotPreview ) return;
    if ( !isShowingLotPreview ) {
        isAnimatingLotPreview = YES;
        [UIView animateWithDuration:0.25f animations:^{
            lotPreview.frame = CGRectMake(0, 80, lotPreview.frame.size.width, lotPreview.frame.size.height);
        } completion:^(BOOL finished) {
            if (finished) {
                isAnimatingLotPreview = NO;
                isShowingLotPreview = YES;
            }
        }];
    } else {
        isAnimatingLotPreview = YES;
        [UIView animateWithDuration:0.25f animations:^{
            lotPreview.frame = CGRectMake(0, self.view.frame.size.height - 120,
                                          lotPreview.frame.size.width, lotPreview.frame.size.height);
        } completion:^(BOOL finished) {
            if (finished) {
                isAnimatingLotPreview = NO;
                isShowingLotPreview = NO;
            }
        }];
    }
}

#pragma mark - Methods for accesing reports and comments TODO: Move them from here, they should not be here


- (void) getLotReports
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"predio"] = [DataSource instance].selectedLotInformation[@"objects"][@"catastro"];
    params[@"limit"] = [NSNumber numberWithInt:10];
    params[@"offset"] = [NSNumber numberWithInt:0];
    
    NSString *url = @"http://vozurbana.mx/api/blueberry/reports";
    [APIRequester get:url WithParams:params WithSuccess:^(NSDictionary *response) {
        if ( response ) {
            NSLog(@"%@", response);
        }
    } AndError:^(NSDictionary *errorResponse, NSError *error) {
        NSLog(@"APIResponse - ERROR: %@", error);
    }];
}

@end
