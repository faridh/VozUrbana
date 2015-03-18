//
//  LandUseTypeViewController.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/7/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReportTypePicker;
@protocol ReportTypePickerDelegate <NSObject>
@optional
- (void)reportTypeSelectedWithIndex:(NSInteger)index;
@end

@interface ReportTypePickerViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) id<ReportTypePickerDelegate> delegate;

@end
