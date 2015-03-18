//
//  ReportsViewController.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/8/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "ReportsViewController.h"

static NSString *cellIdentifier = @"reportCell";

@interface ReportsViewController ()

@end

@implementation ReportsViewController
@synthesize reportsView;

- (void)viewDidLoad {
    [super viewDidLoad];
    reportsView.backgroundColor = [ViewDecorator whiteColor];
    reportsView.delegate = self;
    reportsView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ViewDecorator clearNavigationForTabBarController:self.tabBarController];
    [ViewDecorator addBackButtonToTabBarController:self.tabBarController withNavigationController:self.navigationController];
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, 100, 40);
    titleLabel.text = @"Reportes";
    titleLabel.textColor = [ViewDecorator whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    titleLabel.backgroundColor = [ViewDecorator clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.tabBarController.navigationItem.titleView = titleLabel;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
    [self performSegueWithIdentifier:@"showReportView" sender:self];
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *newCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    if (newCell == nil) {
        newCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellIdentifier];
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
    //    reportDescriptionLabel.backgroundColor = [ViewDecorator lightGrayColor];
    
    UILabel *statusLabel = (UILabel *)[newCell viewWithTag:300];
    statusLabel.backgroundColor = [ViewDecorator clearColor];
    statusLabel.layer.backgroundColor = [ViewDecorator lightGreenColor].CGColor;
    statusLabel.layer.cornerRadius = 10.0f;
    
    UILabel *addressLabel = (UILabel *)[newCell viewWithTag:400];
    //    addressLabel.backgroundColor = [ViewDecorator clearColor];
    //    addressLabel.layer.backgroundColor = [ViewDecorator purpleColor].CGColor;
    addressLabel.text = [NSString stringWithFormat:@"%@ / %ld", addressLabel.text, (long)indexPath.row + 1];
    
    UILabel *dateLabel = (UILabel *)[newCell viewWithTag:500];
    //    dateLabel.backgroundColor = [ViewDecorator clearColor];
    //    dateLabel.layer.backgroundColor = [ViewDecorator cyanColor].CGColor;
    
    return newCell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
