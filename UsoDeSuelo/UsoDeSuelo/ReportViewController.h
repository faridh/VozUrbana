//
//  ReportViewController.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/8/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *mapAlertView;
@property (strong, nonatomic) IBOutlet UILabel *reportTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *reportAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *reportDateLabel;
@property (strong, nonatomic) IBOutlet UITextView *reportDescriptionTextView;
@property (strong, nonatomic) IBOutlet UITableView *messagesList;

@end
