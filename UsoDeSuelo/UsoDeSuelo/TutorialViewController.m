//
//  TutorialViewController.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "TutorialViewController.h"

@implementation TutorialViewController

@synthesize loginButton;

- (IBAction)loginButtonTapped:(UIButton *)sender {
    [self performSegueWithIdentifier:@"enterHome" sender:sender];
}

#pragma mark - UIViewController lifecycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    loginButton.backgroundColor = [ViewDecorator clearColor];
    loginButton.layer.backgroundColor = [ViewDecorator lightBlueColor].CGColor;
    loginButton.layer.cornerRadius = 5.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end