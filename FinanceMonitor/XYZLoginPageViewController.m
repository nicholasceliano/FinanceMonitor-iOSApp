//
//  XYZLoginPageViewController.m
//  FinanceMonitor
//
//  Created by NEC on 4/27/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import "XYZLoginPageViewController.h"
#import "XYZHomePageTableViewController.h"
#import "GlobalObjects.h"
#import "XYZWebServices.h"

@interface XYZLoginPageViewController ()

@end

@implementation XYZLoginPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _txtPassword.secureTextEntry = YES;
    // Do any additional setup after loading the view.
}

- (IBAction)login:(id)sender {
    //Get userID
    NSMutableDictionary*dict = [[NSMutableDictionary alloc]init];
    [dict setObject:_txtUsername.text forKey:@"userid"];
    [dict setObject:_txtPassword.text forKey:@"password"];
    
    XYZWebServices *webServices = [[XYZWebServices alloc]init];
    
    NSData *result = [webServices POSTWebService_sync:@"api/generalAccounts/ValidateUserCredentials" POSTContent:dict];
    
    [GlobalObjects setUserID:[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding]];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([[GlobalObjects getUserID]  isEqual: @"null"]) {
        if([_txtUsername.text  isEqual: @""]){
            _lblError.text = @"Error: Must enter valid username.";
            return NO;
        } else if ([_txtPassword.text isEqual:@""]){
            _lblError.text = @"Error: Must enter a password";
            return NO;
        } else{
            _lblError.text = @"Error: Invalid Credentials";
            return NO;
        }
    }else{
        return YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)txtUsernameExit:(id)sender {
    [_txtUsername resignFirstResponder];
}

- (IBAction)txtPasswordExit:(id)sender {
    [_txtPassword resignFirstResponder];
}







#define kOFFSET_FOR_KEYBOARD 180.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
        [self setViewMovedUp:YES];
    else if (self.view.frame.origin.y < 0)
        [self setViewMovedUp:NO];
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
        [self setViewMovedUp:YES];
    else if (self.view.frame.origin.y < 0)
        [self setViewMovedUp:NO];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

@end
