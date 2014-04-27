//
//  XYZHomePageTableViewController.h
//  FinanceMonitor
//
//  Created by NEC on 4/20/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZHomePageTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aiInvestAcc;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aiCheckingAcc;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aiSavingsAcc;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aiRetirementAcc;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aiAllAccounts;
@property (weak, nonatomic) IBOutlet UILabel *lblRetirementDate;
@property (weak, nonatomic) IBOutlet UILabel *lblRetirementTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblSavingsTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblSavingsDate;
@property (weak, nonatomic) IBOutlet UILabel *lblCheckingTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblCheckingDate;
@property (weak, nonatomic) IBOutlet UILabel *lblInvestmentsTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblInvestmentsDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAllAccounts;

- (IBAction)reloadData:(id)sender;
- (void)setPageValues;

@end
