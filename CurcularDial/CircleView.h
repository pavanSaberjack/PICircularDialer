//
//  CircleView.h
//  Rotator
//
//  Created by pavan on 10/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CircleViewDelegate;
@interface CircleView : UIView
@property (nonatomic, weak) id <CircleViewDelegate>delegate;
@end

@protocol CircleViewDelegate <NSObject>
- (void)clickedValue:(NSInteger)value;
@end
