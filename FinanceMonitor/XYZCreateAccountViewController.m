//
//  XYZCreateAccountViewController.m
//  FinanceMonitor
//
//  Created by NEC on 5/1/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import "XYZCreateAccountViewController.h"
#import "XYZFormattingHelper.h"
#import "XYZWebServices.h"
#import "GlobalObjects.h"

@interface XYZCreateAccountViewController ()
@property BOOL shouldReturn;
@end

@implementation XYZCreateAccountViewController

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
    
}

- (IBAction)btnCreate:(id)sender
{
    if ([_txtEmail.text length] == 0) {
        _lblError.text = @"Error: Must enter email";
        [self setShouldReturn:NO];
        return;
    } else if ([XYZFormattingHelper ValidateEmailWithString:_txtEmail.text] == NO){
        _lblError.text = @"Error: Must enter valid email";
        [self setShouldReturn:NO];
        return;
    } else {
        if ([_txtPassword.text length] == 0) {
            _lblError.text = @"Error: Must enter password";
            [self setShouldReturn:NO];
            return;
        } else if ([_txtPassword.text length] < 6){
            _lblError.text = @"Error: Password must be at least 6 characters long";
            [self setShouldReturn:NO];
            return;
        }else{
            [self setShouldReturn:YES];
            
            NSMutableDictionary*dict = [[NSMutableDictionary alloc]init];
            [dict setObject:_txtEmail.text forKey:@"userID"];
            [dict setObject:_txtPassword.text forKey:@"password"];
            [dict setObject:_txtFirstName.text forKey:@"firstName"];
            [dict setObject:_txtLastName.text forKey:@"lastName"];
            
            XYZWebServices *webService = [[XYZWebServices alloc] init];
            NSData *result = [webService POSTWebService_sync:@"api/generalAccounts/CreateUser/" POSTContent:dict];
            NSString *userID = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
            
            if ([userID  isEqual: @"-1"]) {
                _lblError.text = @"Error: User with that email already exists";
                [self setShouldReturn:NO];
            } else
            {
                [self setShouldReturn:YES];
                [GlobalObjects setUserID:userID];
            }
        }
        
    }
    
    //redirect to homepage
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([sender tag] == 5) {
        return YES;
    } else{
        if (_shouldReturn) {
            return YES;
        }else{
            return NO;
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
