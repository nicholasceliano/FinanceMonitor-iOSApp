//
//  XYZHomePageTableViewController.m
//  FinanceMonitor
//
//  Created by NEC on 4/20/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import "XYZHomePageTableViewController.h"
#import "XYZAllAccountsInformation_Record.h"
#import "XYZWebServices.h"
#import "XYZFormattingHelper.h"
#import "GlobalObjects.h"

@interface XYZHomePageTableViewController ()

@end

@implementation XYZHomePageTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self populateAccountData:@"nicholasceliano@yahoo.com"];
}

- (IBAction)reloadData:(id)sender
{
    [self populateAccountData:@"nicholasceliano@yahoo.com"];
}

- (void)populateAccountData:(NSString*)userName
{
    [_aiAllAccounts startAnimating];
    [_aiRetirementAcc startAnimating];
    [_aiSavingsAcc startAnimating];
    [_aiCheckingAcc startAnimating];
    [_aiInvestAcc startAnimating];
    
    XYZWebServices *webServices = [[XYZWebServices alloc] init];
    [webServices RetrieveAccountValues:[NSString stringWithFormat:@"%@%@%@", @"api/generalAccounts/GetAllAccountsByUser/",userName, @"/"]:self];
}

- (void)setPageValues
{
    [_aiAllAccounts stopAnimating];
    [_aiRetirementAcc stopAnimating];
    [_aiSavingsAcc stopAnimating];
    [_aiCheckingAcc stopAnimating];
    [_aiInvestAcc stopAnimating];
    
    double totAllAccounts = 0;
    double totRetirement = 0;
    double totInvestments = 0;
    double totSavings = 0;
    double totChecking = 0;
    NSString* minRetirementDate;
    NSString* minInvestmentDate;
    NSString* minSavingsDate;
    NSString* minCheckingDate;
    
    for (NSObject *obj in [GlobalObjects allAccInfoForUser]) {
        NSMutableDictionary *dict = (NSMutableDictionary*)obj;
        
        XYZAllAccountsInformation_Record *item = [[XYZAllAccountsInformation_Record alloc] init];
        item.AccountTypeID = dict[@"AccountTypeID"];
        item.LatestAmount = dict[@"LatestAmount"];
        item.LatestRequestDate = dict[@"LatestRequestDate"];
        item.IsActive = dict[@"IsActive"];
        
        if (item.IsActive)
        {
            totAllAccounts = totAllAccounts + [item.LatestAmount doubleValue];
            
            switch ([item.AccountTypeID intValue]) {
                case 1://Retirement
                    totRetirement = totRetirement + [item.LatestAmount doubleValue];
                    minRetirementDate = item.LatestRequestDate;
                    break;
                case 2://Investments
                    totInvestments = totInvestments + [item.LatestAmount doubleValue];
                    minInvestmentDate = item.LatestRequestDate;
                    break;
                case 3://Checking
                    totChecking = totChecking + [item.LatestAmount doubleValue];
                    minCheckingDate = item.LatestRequestDate;
                    break;
                case 4://Savings
                    totSavings = totSavings + [item.LatestAmount doubleValue];
                    minSavingsDate = item.LatestRequestDate;
                    break;
            }
        }
    }

    _lblAllAccounts.text = [XYZFormattingHelper FormatDecimalToMoneyString:totAllAccounts];
    _lblRetirementTotal.text = [XYZFormattingHelper FormatDecimalToMoneyString:totRetirement];
    _lblInvestmentsTotal.text = [XYZFormattingHelper FormatDecimalToMoneyString:totInvestments];
    _lblCheckingTotal.text = [XYZFormattingHelper FormatDecimalToMoneyString:totChecking];
    _lblSavingsTotal.text = [XYZFormattingHelper FormatDecimalToMoneyString:totSavings];
    
    _lblRetirementDate.text = [XYZFormattingHelper SetProperDateTime:minRetirementDate];
    _lblInvestmentsDate.text = [XYZFormattingHelper SetProperDateTime:minInvestmentDate];
    _lblCheckingDate.text = [XYZFormattingHelper SetProperDateTime:minCheckingDate];
    _lblSavingsDate.text = [XYZFormattingHelper SetProperDateTime:minSavingsDate];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
