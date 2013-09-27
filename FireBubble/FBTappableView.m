//
//  FBTappableView.m
//  FireBubble
//
//  Created by Jose Medrano on 9/24/13.
//  Copyright (c) 2013 Jose Medrano. All rights reserved.
//

#import "FBTappableView.h"

@interface FBTappableView ()
@end


@implementation FBTappableView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    self.touched = YES;
    UITouch *touch = [touches anyObject];
    self.locationOfTouch = [touch locationInView:self];
    [self setNeedsDisplay];
    
    [self.delegate bubbleBurstedInLocation:@{@"x": [NSNumber numberWithFloat:self.locationOfTouch.x], @"y": [NSNumber numberWithFloat:self.locationOfTouch.y]}];
    
}

- (void)drawTouchCircle:(CGPoint)locationOfTouch
{
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    
    if (ctx) {
        CGContextSaveGState(ctx);
        
        CGContextSetRGBFillColor(ctx, 1.0, 0, 255, 0.1);
        CGContextSetRGBStrokeColor(ctx, 1.0, 0, 255, 0.5);
        CGContextFillEllipseInRect(ctx, CGRectMake(locationOfTouch.x - 30, locationOfTouch.y - 30, 80.0, 88.0));
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.touched)
        [self drawTouchCircle:self.locationOfTouch];
}



@end
