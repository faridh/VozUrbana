//
//  ViewDecorator.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "ViewConstants.h"
#import "ViewDecorator.h"
#import "HomeViewController.h"
#import "MyReportsViewController.h"
#import "CivicGroupsViewController.h"
#import "SettingsViewController.h"

@implementation ViewDecorator

static ViewDecorator *_instance = nil;

/**
 * Singleton accesor to the static object.
 * @return id - A Singleton ViewDecorator
 */
+ (ViewDecorator *) instance
{
    @synchronized([ViewDecorator class]) {
        if ( !_instance ) {
            [self new];
        }
        return _instance;
    }
    return nil;
}

+ (id)alloc
{
    @synchronized([ViewDecorator class]) {
        if ( _instance == nil ) {
            _instance = [super alloc];
        }
        return _instance;
    }
    return nil;
}

- (id)init
{
    if (self = [super init]) {
        printf("ViewDecorator: init().\n");
    }
    return self;
}

#pragma mark - Color palette accesors
+ (UIColor *)colorWithColor:(UIColor *) color andAlpha:(CGFloat) alpha
{
    CIColor *colorRef = [CIColor colorWithCGColor:color.CGColor];
    return [UIColor colorWithRed:colorRef.red
                           green:colorRef.green
                            blue:colorRef.blue
                           alpha:alpha];
}


+ (UIColor *)coralColor {
    return [UIColor colorWithRed:254/kMaxHexColorValue green:123/kMaxHexColorValue
                            blue:107/kMaxHexColorValue alpha:kMaxDecAlphaValue];
}
+ (UIColor *)coralColorWithAlpha:(CGFloat)alpha {
    return [ViewDecorator colorWithColor:[ViewDecorator coralColor] andAlpha:alpha];
}
+ (UIColor *)lightBlueColor {
    return [UIColor colorWithRed:33/kMaxHexColorValue green:147/kMaxHexColorValue
                            blue:204/kMaxHexColorValue alpha:kMaxDecAlphaValue];
}
+ (UIColor *)lightBlueColorWithAlpha:(CGFloat)alpha {
    return [ViewDecorator colorWithColor:[ViewDecorator lightBlueColor] andAlpha:alpha];
}
+ (UIColor *)lightGreenColor {
    return [UIColor colorWithRed:121/kMaxHexColorValue green:201/kMaxHexColorValue
                            blue:66/kMaxHexColorValue alpha:kMaxDecAlphaValue];
}
+ (UIColor *)lightGreenColorWithAlpha:(CGFloat)alpha {
    return [ViewDecorator colorWithColor:[ViewDecorator lightGreenColor] andAlpha:alpha];
}
#pragma mark - Platform Dependent
+ (void)clearNavigationForTabBarController:(UITabBarController *)tabBarController
{
    [tabBarController.navigationController.navigationBar setHidden:NO];
    UIBarButtonItem *blankButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain
                                                                   target:nil
                                                                   action:nil];
    tabBarController.navigationItem.leftBarButtonItem = blankButton;
    tabBarController.navigationItem.rightBarButtonItem = blankButton;
    [tabBarController.navigationController.navigationBar setBarTintColor:[ViewDecorator lightBlueColor]];
    [tabBarController.tabBar setBarTintColor:[ViewDecorator whiteColor]];
    [tabBarController.tabBar setTintColor:[ViewDecorator blackColor]];
}
+ (void)addBackButtonToTabBarController:(UITabBarController *)tabBarController
               withNavigationController:(UINavigationController *)navigationController
{
    tabBarController.navigationController.navigationBar.hidden = NO;
    tabBarController.navigationController.navigationBar.barTintColor = [ViewDecorator lightBlueColor];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"❮ Regresar" style:UIBarButtonItemStylePlain
                                                                  target:navigationController
                                                                  action:@selector(popViewControllerAnimated:)];
    backButton.tintColor = [ViewDecorator whiteColor];
    tabBarController.navigationItem.leftBarButtonItem = backButton;
}

#pragma mark - Miscellaneous

/**
 * Creates a new rectangle with the size of *bounds and filled with *color
 * @return a new image
 * @param color - The UIColor that will fill our new image
 * @param bounds - The bounding size for our new image
 */
+ (UIImage *)imageWithColor:(UIColor *) color AndBounds:(CGSize) bounds
{
    UIGraphicsBeginImageContextWithOptions(bounds, YES, 0);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, bounds.width, bounds.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)imageWithColor {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[ViewDecorator grayColor] CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
/**
 * Invokes a UIAlertView with a title, a message and the OK button.
 */
+ (void) executeAlertViewWithTitle:(NSString *) title AndMessage:(NSString *) message
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
/**
 * Moves the view's frame vertically with the specified offset
 */
+ (void)shiftView:(UIView *)view verticallyWithOffset:(CGFloat)offset
{
    view.frame = CGRectMake(view.frame.origin.x,
                            view.frame.origin.y + offset,
                            view.frame.size.width,
                            view.frame.size.height);
}
/**
 * Moves the view's frame horizontally with the specified offset
 */
+ (void)shiftView:(UIView *)view horizontallyWithOffset:(CGFloat)offset
{
    view.frame = CGRectMake(view.frame.origin.x + offset,
                            view.frame.origin.y,
                            view.frame.size.width,
                            view.frame.size.height);
}

@end
