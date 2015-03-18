//
//  ReportsViewController.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "MyReportsViewController.h"
#include <stdlib.h>

static NSString *cellIdentifier = @"reportCell";

@interface MyReportsViewController ()

@end

@implementation MyReportsViewController
@synthesize reportsView;

NSArray *titles;
NSArray *address;
NSArray *dates;

- (void)viewDidLoad {
    [super viewDidLoad];
    reportsView.backgroundColor = [ViewDecorator whiteColor];
    reportsView.delegate = self;
    reportsView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ViewDecorator clearNavigationForTabBarController:self.tabBarController];
    self.navigationController.navigationBar.barTintColor = [ViewDecorator lightBlueColor];
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, 100, 40);
    titleLabel.text = @"Mis reportes";
    titleLabel.textColor = [ViewDecorator whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    titleLabel.backgroundColor = [ViewDecorator clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.tabBarController.navigationItem.titleView = titleLabel;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    titles = [NSArray arrayWithObjects:@"Uso de suelo", @"Construcción ilegal", @"Construcción ilegal", @"Comercio en predio residencial", @"Uso de suelo", @"Construcción ilegal", @"Construcción ilegal", @"Predio invadido", @"Exceso de ruido", @"Uso de suelo", nil];
    address = [NSArray arrayWithObjects:@"Tamaulipas #150", @"Ámsterdam #12", @"Cuautla #35", @"Alfonso Reyes #21", @"Benjamin Hill #48", @"Mexicali #178", @"Atlixco #65", @"Michoacán #13", @"Jalapa #71", @"Tonalá #22", nil];
    dates = [NSArray arrayWithObjects:@"01/ene/2015", @"24/dic/2015", @"08/mar/2015", @"28/feb/2015", @"15/dic/2014", @"11/nov/2014", @"09/oct/2014", @"31/dic/2014", @"01/mar/2015", @"02/ene/2015", nil];
    // reportsView.frame = CGRectMake(0, 0, reportsView.frame.size.width, reportsView.frame.size.height + 64);
    [reportsView reloadData];
    [reportsView reloadInputViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *newCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (newCell == nil) {
        newCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    int module = indexPath.row % 4;
    UIImageView *mapImageView = (UIImageView *)[newCell viewWithTag:100];
    switch (module) {
        case 0:
            mapImageView.image = [UIImage imageNamed:@"mapDummy1"];
            break;
        case 1:
            mapImageView.image = [UIImage imageNamed:@"mapDummy2"];
            break;
        case 2:
            mapImageView.image = [UIImage imageNamed:@"mapDummy3"];
            break;
        case 3:
            mapImageView.image = [UIImage imageNamed:@"mapDummy4"];
            break;
        default:
            break;
    }
    
    UILabel *reportDescriptionLabel = (UILabel *)[newCell viewWithTag:200];
    reportDescriptionLabel.text = [titles objectAtIndex:indexPath.row];
//    reportDescriptionLabel.backgroundColor = [ViewDecorator lightGrayColor];
    
    NSInteger random = arc4random_uniform(10);
    
    UILabel *statusLabel = (UILabel *)[newCell viewWithTag:300];
    statusLabel.backgroundColor = [ViewDecorator clearColor];
    statusLabel.layer.backgroundColor = random % 2 == 0 ? [ViewDecorator lightGreenColor].CGColor : [ViewDecorator lightBlueColor].CGColor;
    statusLabel.text = random % 2 == 0 ? @"Cambio" : @"Nuevo";
    statusLabel.layer.cornerRadius = 10.0f;
    
    UILabel *addressLabel = (UILabel *)[newCell viewWithTag:400];
//    addressLabel.backgroundColor = [ViewDecorator clearColor];
//    addressLabel.layer.backgroundColor = [ViewDecorator purpleColor].CGColor;
    addressLabel.text = [address objectAtIndex:indexPath.row];
    
    UILabel *dateLabel = (UILabel *)[newCell viewWithTag:500];
    dateLabel.text = [dates objectAtIndex:indexPath.row];
//    dateLabel.backgroundColor = [ViewDecorator clearColor];
//    dateLabel.layer.backgroundColor = [ViewDecorator cyanColor].CGColor;
    
    [newCell reloadInputViews];
    [newCell layoutSubviews];
    return newCell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
