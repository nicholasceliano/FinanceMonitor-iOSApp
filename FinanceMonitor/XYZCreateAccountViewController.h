//
//  XYZCreateAccountViewController.h
//  FinanceMonitor
//
//  Created by NEC on 5/1/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZCreateAccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
- (IBAction)btnCreate:(id)sender;

@end
