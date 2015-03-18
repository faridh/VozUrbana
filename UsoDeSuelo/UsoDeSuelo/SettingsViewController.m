//
//  SettingsViewController.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ViewDecorator lightGrayColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ViewDecorator clearNavigationForTabBarController:self.tabBarController];
    [ViewDecorator addBackButtonToTabBarController:self.tabBarController withNavigationController:self.navigationController];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, 100, 40);
    titleLabel.text = @"Configuraciones";
    titleLabel.textColor = [ViewDecorator whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    titleLabel.backgroundColor = [ViewDecorator clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.tabBarController.navigationItem.titleView = titleLabel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end