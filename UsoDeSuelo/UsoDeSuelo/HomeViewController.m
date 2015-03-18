//
//  HomeViewController.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "UIWindow+Extensions.h"
#import "SettingsViewController.h"
#import "UIControl+Extensions.h"
#import "UIView+Extensions.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "MapHomeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <FacebookSDK/FacebookSDK.h>

const static NSString *placesAPIKey = @"AIzaSyDPFAWXNQyqZPFhc4323azeML9mlPZCER8";

@implementation HomeViewController

@synthesize mainView;
@synthesize settingsButton;
@synthesize titleLabel;
@synthesize searchByLocation;
@synthesize locationSearchBar;
@synthesize searchByName;
@synthesize loginButton;

LocationResultsViewController *locationResults;
BOOL isShowingKeyboard;
CLLocationCoordinate2D initialLocation;

#pragma mark - UIViewController lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainView.backgroundColor = [ViewDecorator clearColor];
    locationSearchBar.delegate = self;
    locationSearchBar.backgroundColor = [UIColor clearColor];
    locationSearchBar.backgroundImage = [UIImage new];
    isShowingKeyboard = NO;
    
    self.loginButton.readPermissions = @[@"public_profile", @"email"];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [ViewDecorator clearNavigationForTabBarController:self.tabBarController];
    
    // searchByLocation setup
    searchByLocation.backgroundColor = [ViewDecorator clearColor];
    searchByLocation.layer.backgroundColor = [ViewDecorator lightBlueColor].CGColor;
    searchByLocation.layer.cornerRadius = 5.0f;
    
    // searchByName setup
    searchByName.backgroundColor = [ViewDecorator clearColor];
    searchByName.layer.backgroundColor = [ViewDecorator lightGreenColor].CGColor;
    searchByName.layer.cornerRadius = 5.0f;
    
    [settingsButton setImage:[UIImage imageNamed:@"gearIcon"] forState:UIControlStateNormal];
    [settingsButton setImage:[UIImage imageNamed:@"gearIcon"] forState:UIControlStateHighlighted];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Se hace en viewDidAppear y no viewWillAppear
    // porque en viewDidLoad los tamaños están mal
    mainView.contentSize = CGSizeMake(mainView.frame.size.width, mainView.frame.size.height * 2);
    locationResults = [LocationResultsViewController new];
    locationResults.view.frame = CGRectMake(self.view.frame.size.width * 0.1f,
                                            searchByName.frame.origin.y + searchByName.frame.size.height,
                                            self.view.frame.size.width * 0.8f, 150);
    locationResults.view.alpha = 0.0f;
    locationResults.view.hidden = YES;
    locationResults.view.backgroundColor = [ViewDecorator whiteColor];
    locationResults.delegate = self;
    [mainView addSubview:locationResults.view];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Logic
- (IBAction)settingsButtonTapped:(UIButton *)sender {
    // [self performSegueWithIdentifier:@"showSettings" sender:self];
    [ViewDecorator executeAlertViewWithTitle:@"Aviso" AndMessage:@"Implementación pendiente."];
}
- (IBAction)locationButtonTapped:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showMap" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showMap"]) {
        // Get reference to the destination view controller
        MapHomeViewController *vc = [[MapHomeViewController alloc] init];
        vc.bootsFromLocation = YES;
    }
}
- (IBAction)searchButtonTapped:(UIButton *)sender {
    
    if ( ![DataSource instance].selectedLocation ) return;
    
    [SVProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"placeid"] = [DataSource instance].selectedLocation[@"place_id"];
    params[@"key"] = placesAPIKey;
    
    NSString *url = @"https://maps.googleapis.com/maps/api/place/details/json?";
    [APIRequester get:url WithParams:params WithSuccess:^(NSDictionary *response) {
        // NSLog(@"APIResponse - Success:\n%@", response);
        // result/geometry/location -> lat,lng
        [SVProgressHUD dismiss];
        NSDictionary *location = response[@"result"][@"geometry"][@"location"];
        initialLocation = CLLocationCoordinate2DMake([location[@"lat"] floatValue], [location[@"lng"] floatValue]);
        MapHomeViewController *mapVC = [[MapHomeViewController alloc] init];
        mapVC.initialLocation = initialLocation;
        mapVC.bootsFromLocation = YES;
        [self.navigationController pushViewController:mapVC animated:YES];

    } AndError:^(NSDictionary *errorResponse, NSError *error) {
        NSLog(@"APIResponse - ERROR: %@", error);
        [SVProgressHUD dismiss];
    }];
}
- (void)fadeInLocationResultsView
{
    [UIView animateWithDuration:0.5f animations:^{
        locationResults.view.hidden = NO;
        locationResults.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        if ( finished ) {
            //
        }
    }];
}
- (void)fadeOutLocationResultsView
{
    [UIView animateWithDuration:0.5f animations:^{
        locationResults.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if ( finished ) {
            locationResults.view.hidden = YES;
        }
    }];
}

- (void) executeSearchWithTerm:(NSString *) searchTerm
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"input"] = searchTerm;
    params[@"key"] = placesAPIKey;
    
    NSString *url = @"https://maps.googleapis.com/maps/api/place/autocomplete/json";
    [APIRequester get:url WithParams:params WithSuccess:^(NSDictionary *response) {
        if ( response ) {
            NSArray *predictions = response[@"predictions"];
            if ( predictions.count > 0 ) {
                NSMutableArray *resultArray = [NSMutableArray new];
                for (NSDictionary *result in predictions) {
                    [resultArray addObject:result];
                }
                locationResults.locationResults = resultArray;
                [locationResults.tableView reloadData];
            }
        }
    } AndError:^(NSDictionary *errorResponse, NSError *error) {
        NSLog(@"APIResponse - ERROR: %@", error);
    }];
}

#pragma mark - UISearchBarDelegate Methods
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *textCopy = searchBar.text;
    textCopy = [textCopy stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self executeSearchWithTerm:textCopy];
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    // ToDo
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // ToDo
    [searchBar resignFirstResponder];
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    // ToDo
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *textCopy = searchBar.text;
    textCopy = [textCopy stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self executeSearchWithTerm:textCopy];
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self fadeInLocationResultsView];
    isShowingKeyboard = YES;
    searchBar.text = @"";
    searchBar.placeholder = @"";
    
    if ( isShowingKeyboard ) {
        [UIView animateWithDuration:0.25f animations:^{
            self.view.frame = CGRectMake(0, self.view.frame.origin.y - 200, self.view.frame.size.width, self.view.frame.size.height);
            self.mainView.scrollEnabled = NO;
        } completion:^(BOOL finished) {
            if ( finished ) {
                
            }
        }];
    }
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    // ToDo
    isShowingKeyboard = NO;
    NSString *textCopy = searchBar.text;
    textCopy = [textCopy stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ( [textCopy isEqualToString:@""] ) {
        [self fadeOutLocationResultsView];
    } else {
        [self executeSearchWithTerm:textCopy];
    }
    
    if ( !isShowingKeyboard ) {
        [UIView animateWithDuration:0.25f animations:^{
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            self.mainView.scrollEnabled = YES;
        } completion:^(BOOL finished) {
            if ( finished ) {
                
            }
        }];
    }
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // ToDo
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // ToDo
}

#pragma mark - LocationResultsViewDelegate methods
- (void) locationSelected {
    [self fadeOutLocationResultsView];
    locationSearchBar.text = [DataSource instance].selectedLocation[@"description"];
    [locationSearchBar resignFirstResponder];
    if ( !searchByLocation.isEnabled ) {
        [searchByLocation enableInteractions];
    }
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [FBLoginView class];
    return YES;
}

@end
