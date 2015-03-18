//
//  UIControl (Extensions).h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Extensions)

/**
 * Performs a quick alpha animation to emulate a button blink
 */
- (void)blink;

/**
 * Disables UIControl and sets alpha to 3/4 opacity
 */
- (void)disableInteracions;

/**
 * Disables UIControl and sets alpha to desired opacity
 */
- (void)disableInteracionsWithAlpha:(CGFloat)alpha;

/**
 * Enables UIControl and sets alpha to full opacity
 */
- (void)enableInteractions;

@end
