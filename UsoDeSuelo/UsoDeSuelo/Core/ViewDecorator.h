//
//  ViewDecorator.h
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewDecorator : UIColor

#pragma mark - Initialization
+ (ViewDecorator *) instance;

#pragma mark - Color palette accesors
/**
 * Returns a color object whose RGB values are 254, 123, 107 and whose alpha value is 1.0.
 * @return The UIColor object.
 */
+ (UIColor *)coralColor;
/**
 * Returns a color object whose RGB values are 254, 123, 107 and whose alpha value alpha.
 * @param The CGFloat alpha value
 * @return The UIColor object.
 */
+ (UIColor *)coralColorWithAlpha:(CGFloat)alpha;
/**
 * Returns a color object whose RGB values are 33, 147, 204 and whose alpha value is 1.0.
 * @return The UIColor object.
 */
+ (UIColor *)lightBlueColor;
/**
 * Returns a color object whose RGB values are 33, 147, 204 and whose alpha value alpha.
 * @param The CGFloat alpha value
 * @return The UIColor object.
 */
+ (UIColor *)lightBlueColorWithAlpha:(CGFloat)alpha;
/**
 * Returns a color object whose RGB values are 121, 201, 66 and whose alpha value is 1.0.
 * @return The UIColor object.
 */
+ (UIColor *)lightGreenColor;
/**
 * Returns a color object whose RGB values are 121, 201, 66 and whose alpha value alpha.
 * @param The CGFloat alpha value
 * @return The UIColor object.
 */
+ (UIColor *)lightGreenColorWithAlpha:(CGFloat)alpha;

#pragma mark - Platform Dependent
+ (void)clearNavigationForTabBarController:(UITabBarController *)tabBarController;
+ (void)addBackButtonToTabBarController:(UITabBarController *)tabBarController
               withNavigationController:(UINavigationController *)navigationController;

#pragma mark - Miscellaneous
+ (UIImage *)imageWithColor:(UIColor *) color AndBounds:(CGSize) bounds;
+ (UIImage *)imageWithColor;
+ (void)executeAlertViewWithTitle:(NSString *)title AndMessage:(NSString *)message;
+ (void)shiftView:(UIView *)view verticallyWithOffset:(CGFloat)offset;
+ (void)shiftView:(UIView *)view horizontallyWithOffset:(CGFloat)offset;

@end
