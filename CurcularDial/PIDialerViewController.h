//
//  PIDialerViewController.h
//  TelephoneDialer
//
//  Created by Pavan Itagi on 22/02/14.
//  Copyright (c) 2014 Pavan Itagi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ActionType)
{
    eSetPassword,
    eCheckPassword
};

extern NSString *const PasswordKey;

@interface PIDialerViewController : UIViewController
- (id)initWithActionType:(ActionType)type;
@end
