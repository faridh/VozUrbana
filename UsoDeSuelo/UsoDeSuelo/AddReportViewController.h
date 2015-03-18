//
//  AddReportViewController.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/7/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportTypePickerViewController.h"

@interface AddReportViewController : UIViewController<UITextViewDelegate, ReportTypePickerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *addressTextField;
@property (strong, nonatomic) IBOutlet UIButton *reportTypeButton;
@property (strong, nonatomic) IBOutlet UITextView *reportDetails;

@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *saveReportButton;
@property (nonatomic, strong) ReportTypePickerViewController *reportTypePicker;

- (IBAction)cancelButtonTapped:(UIButton *)sender;
- (IBAction)saveReportButtonTapped:(UIButton *)sender;

@end
