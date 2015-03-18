//
//  HomeViewController.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationResultsViewController.h"

@interface HomeViewController : UIViewController<UISearchBarDelegate, LocationResultsViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *mainView;
@property (strong, nonatomic) IBOutlet UIButton *settingsButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *searchByLocation;
@property (strong, nonatomic) IBOutlet UISearchBar *locationSearchBar;
@property (strong, nonatomic) IBOutlet UIButton *searchByName;
@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;

- (IBAction)settingsButtonTapped:(UIButton *)sender;
- (IBAction)locationButtonTapped:(UIButton *)sender;
- (IBAction)searchButtonTapped:(UIButton *)sender;

@end
