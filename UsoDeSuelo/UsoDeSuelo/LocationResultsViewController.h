//
//  LocationResultsViewController.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationResultsView;
@protocol LocationResultsViewDelegate <NSObject>
@optional
- (void) locationSelected;
@end

@interface LocationResultsViewController : UITableViewController

@property (nonatomic, strong) NSArray *locationResults;
@property (nonatomic, strong) id<LocationResultsViewDelegate> delegate;

@end