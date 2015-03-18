//
//  ReportsViewController.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyReportsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *reportsView;

@end
