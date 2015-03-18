//
//  AddReportViewController.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/7/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "AddReportViewController.h"
#import "UIViewController+KNSemiModal.h"
#import <SVProgressHUD/SVProgressHUD.h>

static NSString *defaultDetails = @"Añada detalles sobre el reporte";
@interface AddReportViewController ()

@end

@implementation AddReportViewController

@synthesize addressTextField;
@synthesize reportTypeButton;
@synthesize reportDetails;

@synthesize cancelButton;
@synthesize saveReportButton;
@synthesize reportTypePicker;

NSString *reportId;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [ViewDecorator whiteColor];
    [addressTextField setEnabled:NO];
    
    // cancelButton setup
    cancelButton.backgroundColor = [ViewDecorator clearColor];
    cancelButton.layer.backgroundColor = [ViewDecorator coralColor].CGColor;
    cancelButton.layer.cornerRadius = 3.0f;
    
    // generateReportButton setup
    saveReportButton.backgroundColor = [ViewDecorator clearColor];
    saveReportButton.layer.backgroundColor = [ViewDecorator lightGreenColor].CGColor;
    saveReportButton.layer.cornerRadius = 3.0f;
    
    reportId = @"";
    reportDetails.text = defaultDetails;
    reportDetails.layer.cornerRadius = 3.0f;
    [reportTypeButton addTarget:self action:@selector(showReportTypePicker) forControlEvents:UIControlEventTouchUpInside];
    reportTypePicker = [[ReportTypePickerViewController alloc] init];
    reportTypePicker.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    reportTypePicker.delegate = self;
    
    NSDictionary *currentLot = [DataSource instance].selectedLotInformation[@"objects"][0];
    NSString *fullAddress = @"";
    fullAddress = [fullAddress stringByAppendingString:[NSString stringWithFormat:@"%@ %@, ",
                                                        currentLot[@"street"],
                                                        currentLot[@"number"]]];
    fullAddress = [fullAddress stringByAppendingString:[NSString stringWithFormat:@"%@, %@, ",
                                                        currentLot[@"colony_catastro"],
                                                        currentLot[@"city_catastro"]]];
    fullAddress = [fullAddress stringByAppendingString:[NSString stringWithFormat:@"%@",
                                                        currentLot[@"zipcode"]]];
    addressTextField.text = fullAddress;
    addressTextField.numberOfLines = 2;
    reportDetails.delegate = self;
}

#pragma mark - UIViewController lifecycle methods
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ViewDecorator clearNavigationForTabBarController:self.tabBarController];
    [ViewDecorator addBackButtonToTabBarController:self.tabBarController withNavigationController:self.navigationController];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, 100, 40);
    titleLabel.text = @"Crear reporte";
    titleLabel.textColor = [ViewDecorator whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    titleLabel.backgroundColor = [ViewDecorator clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.tabBarController.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cameraIcon"]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(openCameraSettings)];
    cameraButton.tintColor = [ViewDecorator whiteColor];
    self.tabBarController.navigationItem.rightBarButtonItem = cameraButton;
}
- (void)openCameraSettings {
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
#if TARGET_IPHONE_SIMULATOR
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    [self presentViewController:imagePickerController
                       animated:YES
                     completion:^{
                         //
                     }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Image:\n%@", info);
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Controller Logic
- (IBAction)cancelButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveReportButtonTapped:(UIButton *)sender {
    [SVProgressHUD show];
    [self generateLotReport:reportDetails.text];
}
- (void)showReportTypePicker {
    [self.reportDetails resignFirstResponder];
    [self presentSemiViewController:reportTypePicker withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO),
                                                                   KNSemiModalOptionKeys.parentAlpha : @(0.8)}];
}

#pragma mark - UITextViewDelegate methods
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ( [textView.text isEqualToString:defaultDetails] ) {
        textView.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if ( [textView.text isEqualToString:@""] ) {
        textView.text = defaultDetails;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ( textView.text.length > 145 ) {
        textView.text = [textView.text substringToIndex:10];
    }
    return YES;
}

#pragma mark - ReportTypePickerDelegate methods
- (void)reportTypeSelectedWithIndex:(NSInteger)index {
    NSDictionary *reportType = [[DataSource instance].reportTypes objectAtIndex:index];
    NSString *trimmedName = [DataSource cleanString:reportType[@"name"]];
    
    NSString *buttonName = [NSString stringWithFormat:@"%@ ❯", trimmedName];
    [reportTypeButton setTitle:buttonName forState:UIControlStateNormal];
    [reportTypeButton setTitle:buttonName forState:UIControlStateHighlighted];
    reportId = reportType[@"id"];
    [reportTypePicker dismissSemiModalViewWithCompletion:^{
        NSLog(@"statePicker Dismissed");
    }];
}

#pragma mark - API calls
- (void) generateLotReport:(NSString *)description
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"catastro"] = [NSString stringWithFormat:@"%@", [DataSource instance].selectedLotInformation[@"objects"][0][@"catastro"]];
    params[@"description"] = description;
    params[@"report_type"] = [NSNumber numberWithInt:1];
    
    NSLog(@"data for request %@", params);
    
    NSString *url = @"http://vozurbana.mx/api/blueberry/reports/";
    [APIRequester post:url WithParams:params WithSuccess:^(NSDictionary *response) {
        [SVProgressHUD dismiss];
        [ViewDecorator executeAlertViewWithTitle:@"Voz Urbana" AndMessage:@"¡Reporte enviado con éxito!"];
        [self.navigationController popViewControllerAnimated:YES];
    } AndError:^(NSDictionary *errorResponse, NSError *error) {
        [SVProgressHUD dismiss];
        [ViewDecorator executeAlertViewWithTitle:@"Voz Urbana" AndMessage:@"¡Reporte enviado con éxito!"];
        NSLog(@"APIResponse - ERROR: %@", error);
    }];
}
@end
