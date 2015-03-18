//
//  LotPreview.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/7/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "LotPreview.h"

@implementation LotPreview

@synthesize delegate;
@synthesize addressLabel;
@synthesize neighborhoodLabel;
@synthesize cuentaCatastralLabel;
@synthesize superficieLabel;
@synthesize construccionLabel;
@synthesize areaLibreLabel;
@synthesize nivelesLabel;
@synthesize alturaLabel;
@synthesize densidadLabel;
@synthesize minViviendaLabel;
@synthesize maxViviendaLabel;

@synthesize cancelButton;
@synthesize generateReportButton;
@synthesize viewReportsButton;

- (id) init {
    NSLog(@"LotPreview:init");
    if ( self = [super init] ) {

    }
    return self;
}

- (void)setupView {
    delegate = nil;
    
    // cancelButton setup
    cancelButton.backgroundColor = [ViewDecorator clearColor];
    cancelButton.layer.backgroundColor = [ViewDecorator coralColor].CGColor;
    cancelButton.layer.cornerRadius = 3.0f;
    
    // generateReportButton setup
    generateReportButton.backgroundColor = [ViewDecorator clearColor];
    generateReportButton.layer.backgroundColor = [ViewDecorator lightGreenColor].CGColor;
    generateReportButton.layer.cornerRadius = 3.0f;
    
    // viewReportsButton setup
    viewReportsButton.backgroundColor = [ViewDecorator clearColor];
    viewReportsButton.layer.backgroundColor = [ViewDecorator lightBlueColor].CGColor;
    viewReportsButton.layer.cornerRadius = 3.0f;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ( delegate && [delegate conformsToProtocol:@protocol(LotPreviewDelegate)] ) {
        if ( [delegate respondsToSelector:@selector(toggleLotPreview)] )
            [delegate toggleLotPreview];
    }
}

@end
