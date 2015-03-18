//
//  ReportsViewController.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/8/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *reportsView;

@end
