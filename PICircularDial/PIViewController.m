//
//  PIViewController.m
//  PICircularDial
//
//  Created by Pavan Itagi on 22/02/14.
//  Copyright (c) 2014 Pavan Itagi. All rights reserved.
//

#import "PIViewController.h"
#import "PIDialerViewController.h"

NSString *const SetPasswordTitle = @"Set Password";
NSString *const CheckPasswordTitle = @"Check Password";

@interface PIViewController ()
@property (nonatomic, weak) UIButton *setPasswordButton;
@property (nonatomic, weak) UIButton * checkPasswordButton;
@end

@implementation PIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * setPasswordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [setPasswordButton setFrame:CGRectMake(80, 90, 160, 40)];
    [setPasswordButton setTitle:SetPasswordTitle forState:UIControlStateNormal];
    [setPasswordButton setTag:1];
    [setPasswordButton addTarget:self action:@selector(setPasswordButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setPasswordButton];
    self.setPasswordButton = setPasswordButton;
    
    UIButton * checkPasswordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkPasswordButton setFrame:CGRectMake(80, 150, 160, 40)];
    [checkPasswordButton setTitle:CheckPasswordTitle forState:UIControlStateNormal];
    [checkPasswordButton setTag:2];
    [checkPasswordButton addTarget:self action:@selector(setPasswordButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkPasswordButton];
    self.checkPasswordButton = checkPasswordButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:PasswordKey] == nil)
    {
        [self.checkPasswordButton setHidden:YES];
    }
    else
    {
        [self.checkPasswordButton setHidden:NO];
    }
}

#pragma mark - UIButton action methods
- (void)setPasswordButtonClicked:(UIButton *)sender
{
    PIDialerViewController * controller = nil;
    if (sender.tag == 1)
    {
        controller = [[PIDialerViewController alloc] initWithActionType:eSetPassword];
    }
    else
    {
        controller = [[PIDialerViewController alloc] initWithActionType:eCheckPassword];
    }
    
    [self presentViewController:controller animated:YES completion:nil];
}
@end
