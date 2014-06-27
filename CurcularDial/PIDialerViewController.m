//
//  PIDialerViewController.m
//  TelephoneDialer
//
//  Created by Pavan Itagi on 22/02/14.
//  Copyright (c) 2014 Pavan Itagi. All rights reserved.
//

#import "PIDialerViewController.h"
#import "CircleView.h"
#import "PDKeychainBindings.h"

NSString *const PasswordKey = @"Password";

NSString *const AlertTitle = @"Hello";

@interface PIDialerViewController ()<CircleViewDelegate>
@property (nonatomic) ActionType viewtype;
@property (nonatomic, weak) UILabel *valLabel;
@end

@implementation PIDialerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithActionType:(ActionType)type
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        _viewtype = type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // Back button
    [self.view addSubview:({
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backButton setFrame:CGRectMake(20, 30, 60, 40)];
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
        [backButton setTag:1];
        [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        backButton;
    })];
    
    // Reset Button
    [self.view addSubview:({
        UIButton * resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [resetButton setFrame:CGRectMake(250, 30, 60, 40)];
        [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
        [resetButton setTag:1];
        [resetButton addTarget:self action:@selector(resetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        resetButton;
    })];
    
    [self.view addSubview:({
        UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 300, 300)];
        [img setBackgroundColor:[UIColor clearColor]];
        [img setImage:[UIImage imageNamed:@"CircleBackground.png"]];
        img;
    })];
    
    // Add dialer
    [self addCircleView];
    
    // Label showing current
    [self.view addSubview:({
        UILabel *valLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 380, 320, 30)];
        [valLabel setBackgroundColor:[UIColor clearColor]];
        [valLabel setText:@""];
        [valLabel setTextAlignment:NSTextAlignmentCenter];
        [valLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:34.0f]];
        [valLabel setTextColor:[UIColor darkGrayColor]];
        self.valLabel = valLabel;
        valLabel;
    })];
    
    
    [self.view addSubview:({
        UIButton * setPasswordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [setPasswordButton setFrame:CGRectMake(80, 420, 160, 40)];
        
        if (self.viewtype == eSetPassword) {
            [setPasswordButton setTitle:@"Set Password" forState:UIControlStateNormal];
        }
        else
        {
            [setPasswordButton setTitle:@"Check Password" forState:UIControlStateNormal];
        }
        
        [setPasswordButton setTag:1];
        [setPasswordButton addTarget:self action:@selector(setPasswordButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        setPasswordButton;
    })];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private methods
- (void)addCircleView
{
    CircleView * circle = [[CircleView alloc] initWithFrame:CGRectMake(10, 50, 300, 300)];
    [circle setDelegate:self];
    [circle setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"circle.png"]]];
    [self.view addSubview:circle];
}

#pragma mark - UIButton action methods
- (void)setPasswordButtonClicked:(UIButton *)sender
{
    PDKeychainBindings *bindings = [PDKeychainBindings sharedKeychainBindings];

    if (self.viewtype == eSetPassword)
    {
        if ([self.valLabel.text length] < 4)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"Minimum 4 numbers needed." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            return;
        }
        
        //[[NSUserDefaults standardUserDefaults] setValue:self.valLabel.text forKey:PasswordKey];
        [bindings setObject:self.valLabel.text forKey:PasswordKey];
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"Your Password is set." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else
    {
       // if ([[[NSUserDefaults standardUserDefaults] valueForKey:PasswordKey] isEqualToString:self.valLabel.text])
       if ([[[bindings objectForKey:PasswordKey] stringValue] isEqualToString:self.valLabel.text])
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"Perfect" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"Wrong" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        
        [self.valLabel setText:@""];
    }
    
   // [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)backButtonClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)resetButtonClicked:(UIButton *)sender
{
    [self.valLabel setText:@""];
}

#pragma mark - Circle view delegate methods
-(void)clickedValue:(NSInteger)value
{
    if ([self.valLabel.text length] < 4)
    {
        [self.valLabel setText:[self.valLabel.text stringByAppendingFormat:@"%@",[NSNumber numberWithDouble:value]]];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"Maximum 4 charactors allowed." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

@end
