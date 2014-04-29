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

@end
