//
//  CircleView.m
//  Rotator
//
//  Created by pavan on 10/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CircleView.h"

@interface CircleView()
{
    CGFloat currentAngle;
    CGPoint centerPoint;
    
    CGPoint beginPoint;
    CGPoint endPoint;
}

@end

@implementation CircleView
@synthesize delegate;
- (double) wrapd:(double)_val min:(double)_min max:(double)_max {
    if(_val < _min) return _max - (_min - _val);
    if(_val > _max) return _val - _max; /*_min - (_max - _val)*/;
    return _val;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - UITouches methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    beginPoint = [[[event allTouches] anyObject] locationInView:self];
    currentAngle = 0.0f;
    centerPoint = self.center;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    endPoint = [[[event allTouches] anyObject] locationInView:self];
    
    float fromAngle = atan2(beginPoint.y - self.center.y, beginPoint.x - self.center.x);
    float toAngle = atan2(endPoint.y - self.center.y, endPoint.x - self.center.x);
    float newAngle = [self wrapd:currentAngle + (toAngle - fromAngle) min:0 max:2 * 3.14];
    
    currentAngle = newAngle;
    
    CGAffineTransform cgaRotate = CGAffineTransformMakeRotation(newAngle);
    [self setTransform:cgaRotate]; 
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    endPoint = [[[event allTouches] anyObject] locationInView:self];
    
    float fromAngle = atan2(beginPoint.y - self.center.y, beginPoint.x - self.center.x);
    float toAngle = atan2(endPoint.y - self.center.y, endPoint.x - self.center.x);
    float newAngle = [self wrapd:currentAngle + (toAngle - fromAngle) min:0 max:2 * 3.14];
    
    currentAngle = newAngle;
    
    CGAffineTransform cgaRotate = CGAffineTransformRotate(self.transform, -currentAngle);
    
    [UIView animateWithDuration:1.0 animations:^{
        [self setTransform:cgaRotate];
    }];
    
    if (currentAngle > 0.15 && currentAngle < 6.12)
    {
        if ([delegate respondsToSelector:@selector(clickedValue:)])
        {
            [delegate clickedValue:(ceil(((currentAngle * 180.0 / 3.14) / 36)) - 1)];
        }
    }
}
@end
