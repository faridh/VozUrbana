//
//  LandUseTypeViewController.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/7/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "ReportTypePickerViewController.h"
#import "UIViewController+KNSemiModal.h"

@implementation ReportTypePickerViewController

@synthesize headerView;
@synthesize doneButton;
@synthesize picker;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    headerView = [UIView new];
    headerView.backgroundColor = [ViewDecorator lightBlueColor];
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    
    doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.backgroundColor = [UIColor clearColor];
    doneButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    doneButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [doneButton setTitle:@"Seleccionar" forState:UIControlStateNormal];
    [doneButton setTitle:@"Seleccionar" forState:UIControlStateHighlighted];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    doneButton.frame = CGRectMake(headerView.frame.size.width * 0.74f, 10, headerView.frame.size.width * 0.23f, 30);
    [doneButton addTarget:self action:@selector(doneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    picker = [UIPickerView new];
    picker.dataSource = self;
    picker.delegate = self;
    picker.backgroundColor = [UIColor whiteColor];
    picker.frame = CGRectMake(0, headerView.frame.origin.y + headerView.frame.size.height, self.view.frame.size.width, 350);
    
    [headerView addSubview:doneButton];
    [self.view addSubview:headerView];
    [self.view addSubview:picker];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)cancelButtonTapped
{
    
    [self dismissSemiModalView];
}

- (void)doneButtonTapped
{
    if ( delegate && [delegate conformsToProtocol:@protocol(ReportTypePickerDelegate)] ) {
        if ( [delegate respondsToSelector:@selector(reportTypeSelectedWithIndex:)] ) {
            NSInteger selectedIndex = [picker selectedRowInComponent:0];
            [delegate reportTypeSelectedWithIndex:selectedIndex];
            // [self dismissSemiModalView];
        }
    }
}

#pragma mark - UIPickerViewDataSource methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [DataSource instance].reportTypes.count;
            break;
        default:
            return 0;
            break;
    }
}

#pragma mark - UIPickerViewDelegate methods

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return headerView.frame.size.width * 0.90f;
            break;
        default:
            return 0.0f;
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35.0f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    NSDictionary *state = [[DataSource instance].reportTypes objectAtIndex:row];
    
    UILabel *rowTitle = [UILabel new];
    rowTitle.backgroundColor = [UIColor clearColor];
    rowTitle.textColor = [UIColor blackColor];
    rowTitle.text = state[@"name"];
    rowTitle.tag = [state[@"id"] integerValue];
    rowTitle.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    rowTitle.textAlignment = NSTextAlignmentLeft;
    rowTitle.frame = CGRectMake(headerView.frame.size.width * 0.05f, 10, headerView.frame.size.width * 0.9f, 30);
    //    switch (component) {
    //        case 0:
    //            return @"Estado";
    //            break;
    //        default:
    //            return @"";
    //            break;
    //    }
    return rowTitle;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

@end