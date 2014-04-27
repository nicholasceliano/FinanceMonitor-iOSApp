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
    // Do any additional setup after loading the view.
}

- (IBAction)login:(id)sender {
    //Do Login logic to check if user is valid
    
    [self test];
    
    //Set global username
    [GlobalObjects setUserName:_txtUsername.text];

}

- (BOOL)test
{
    if (_txtUsername.text == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
