//
//  UIControl (Extensions).m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "UIControl+Extensions.h"

@implementation UIControl (Extensions)

/**
 * Performs a quick alpha animation to emulate a button blink
 */
- (void)blink {
    if ( self.alpha == 1.0f && self.isEnabled && !self.isHidden ) {
        [UIView animateWithDuration:0.1f animations:^{
            self.alpha = 0.5f;
        } completion:^(BOOL finished) {
            if ( finished ) {
                [UIView animateWithDuration:0.1f animations:^{
                    self.alpha = 1.0f;
                }];
            }
        }];
    }
}

/**
 * Disables UIControl and sets alpha to 3/4 opacity
 */
- (void)disableInteracions
{
    self.enabled = NO;
    self.alpha = 0.75f;
}

/**
 * Disables UIControl and sets alpha to desired opacity
 */
- (void)disableInteracionsWithAlpha:(CGFloat)alpha
{
    self.enabled = NO;
    self.alpha = alpha;
}

/**
 * Enables UIControl and sets alpha to full opacity
 */
- (void)enableInteractions
{
    self.enabled = YES;
    self.alpha = 1.0f;
}

@end