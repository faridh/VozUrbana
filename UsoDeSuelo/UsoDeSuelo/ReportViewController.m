//
//  ReportViewController.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/8/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "ReportViewController.h"

static NSString *cellIdentifier = @"messageCell";

@implementation ReportViewController

@synthesize  mapAlertView;
@synthesize reportTypeLabel;
@synthesize reportAddressLabel;
@synthesize reportDateLabel;
@synthesize reportDescriptionTextView;
@synthesize messagesList;

NSArray *messages;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    
    [ViewDecorator clearNavigationForTabBarController:self.tabBarController];
    [ViewDecorator addBackButtonToTabBarController:self.tabBarController withNavigationController:self.navigationController];
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, 100, 40);
    titleLabel.text = @"Reporte";
    titleLabel.textColor = [ViewDecorator whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    titleLabel.backgroundColor = [ViewDecorator clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.tabBarController.navigationItem.titleView = titleLabel;
    
    messages = @[@{@"title":@"Mucho ruido", @"subtitle":@"04/20/2015"},
                @{@"title":@"Mucha basura", @"subtitle":@"04/20/2015"},
                 @{@"title":@"Venta ilegal de alcohol", @"subtitle":@"04/20/2015"}];
    
    reportDescriptionTextView.backgroundColor = [ViewDecorator colorWithWhite:0.75f alpha:0.5f];
    messagesList.dataSource = self;
    messagesList.delegate = self;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.frame = CGRectMake(0, 64, [DataSource screenSize].width, [DataSource screenSize].height);
    [messagesList reloadData];
    [messagesList reloadInputViews];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *newCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    if (newCell == nil) {
        newCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *message = [messages objectAtIndex:indexPath.row];
    UILabel *titleLabel = (UILabel *)[newCell viewWithTag:100];
    titleLabel.text = message[@"title"];
    UILabel *subtitleLabel = (UILabel *)[newCell viewWithTag:200];
    subtitleLabel.text = message[@"subtitle"];
    
    return newCell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
