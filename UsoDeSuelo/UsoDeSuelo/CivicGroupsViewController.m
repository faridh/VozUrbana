//
//  CivicGroupsViewController.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "CivicGroupsViewController.h"

static NSString *cellIdentifier = @"civicGroupCell";

@interface CivicGroupsViewController()

@end

@implementation CivicGroupsViewController
@synthesize civicGroupsView;

NSArray *alerts;

- (void)viewDidLoad {
    [super viewDidLoad];
    civicGroupsView.backgroundColor = [ViewDecorator whiteColor];
    civicGroupsView.delegate = self;
    civicGroupsView.dataSource = self;
    alerts = @[@{@"title":@"Alerta predios Condesa", @"description":@"Actualización de información en predio"},
              @{@"title":@"Alerta zona Del Valle", @"description":@"Mensaje para todos los colonos"},
              @{@"title":@"Alerta predios Santa Fe", @"description":@"Mensaje para todos los colonos"},
              @{@"title":@"Alerta en zona Roma", @"description":@"Reporte generado para predio"},
              @{@"title":@"Alerta predios en Centro", @"description":@"Reporte de cambio de uso de suelo"}];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ViewDecorator clearNavigationForTabBarController:self.tabBarController];
    self.navigationController.navigationBar.barTintColor = [ViewDecorator lightBlueColor];
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, 100, 40);
    titleLabel.text = @"Alertas";
    titleLabel.textColor = [ViewDecorator whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    titleLabel.backgroundColor = [ViewDecorator clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.tabBarController.navigationItem.titleView = titleLabel;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // civicGroupsView.frame = CGRectMake(0, 0, civicGroupsView.frame.size.width, civicGroupsView.frame.size.height + 64);
    [civicGroupsView reloadData];
    [civicGroupsView reloadInputViews];
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
    return alerts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *newCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    if (newCell == nil) {
        newCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellIdentifier];
    }
    
    int module = indexPath.row % 4;
    UIImageView *civicGroupIcon = (UIImageView *)[newCell viewWithTag:100];
    switch (module) {
        case 0:
            civicGroupIcon.image = [UIImage imageNamed:@"mapArea1"];
            break;
        case 1:
            civicGroupIcon.image = [UIImage imageNamed:@"mapArea2"];
            break;
        case 2:
            civicGroupIcon.image = [UIImage imageNamed:@"mapArea3"];
            break;
        case 3:
            civicGroupIcon.image = [UIImage imageNamed:@"mapArea4"];
            break;
        default:
            break;
    }
    
    NSDictionary *alert = [alerts objectAtIndex:indexPath.row];
    UILabel *reportDescriptionLabel = (UILabel *)[newCell viewWithTag:200];
    // reportDescriptionLabel.backgroundColor = [ViewDecorator yellowColor];
    reportDescriptionLabel.text = alert[@"title"];
    
    UILabel *addressLabel = (UILabel *)[newCell viewWithTag:300];
    addressLabel.text = alert[@"description"];
    addressLabel.numberOfLines = 2;
//    addressLabel.backgroundColor = [ViewDecorator clearColor];
//    addressLabel.layer.backgroundColor = [ViewDecorator purpleColor].CGColor;
    
    UILabel *phoneLabel = (UILabel *)[newCell viewWithTag:400];
    phoneLabel.text = @"";
//    phoneLabel.backgroundColor = [ViewDecorator clearColor];
//    phoneLabel.layer.backgroundColor = [ViewDecorator cyanColor].CGColor;
    
    return newCell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
@end
