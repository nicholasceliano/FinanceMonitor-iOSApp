//
//  XYZLoginPageViewController.h
//  FinanceMonitor
//
//  Created by NEC on 4/27/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZLoginPageViewController : UIViewController
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblError;

@end
