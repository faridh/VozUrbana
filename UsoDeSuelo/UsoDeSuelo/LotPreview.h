//
//  LotPreview.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/7/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LotPreview;
@protocol LotPreviewDelegate <NSObject>
@optional
- (void) toggleLotPreview;
@end

@interface LotPreview : UIView
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *neighborhoodLabel;
@property (strong, nonatomic) IBOutlet UILabel *cuentaCatastralLabel;
@property (strong, nonatomic) IBOutlet UILabel *superficieLabel;
@property (strong, nonatomic) IBOutlet UILabel *construccionLabel;
@property (strong, nonatomic) IBOutlet UILabel *areaLibreLabel;
@property (strong, nonatomic) IBOutlet UILabel *nivelesLabel;
@property (strong, nonatomic) IBOutlet UILabel *alturaLabel;
@property (strong, nonatomic) IBOutlet UILabel *densidadLabel;
@property (strong, nonatomic) IBOutlet UILabel *minViviendaLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxViviendaLabel;

@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *generateReportButton;
@property (strong, nonatomic) IBOutlet UIButton *viewReportsButton;

@property (nonatomic, strong) id<LotPreviewDelegate> delegate;

- (void)setupView;

@end
