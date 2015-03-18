//
//  UIView+Extensions.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

/**
 * Performs a quick alpha animation to emulate a button blink
 */
- (void)blink {
    if ( self.alpha == 1.0f && !self.isHidden ) {
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

@end
