//
//  XYZAccountInfoViewController.m
//  FinanceMonitor
//
//  Created by NEC on 4/19/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import "XYZAccountInfoViewController.h"
#import "XYZAccountsListTableViewController.h"
#import "XYZWebServices.h"
#import "XYZFormattingHelper.h"
#import "GlobalObjects.h"


@interface XYZAccountInfoViewController ()

@end

@implementation XYZAccountInfoViewController

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
    
    _lblTitle.text = _pageTitle;
    
    [self setPageValues];
    
    //[self retrieveAccountData:_pageTitle];
}

- (void)retrieveAccountData:(NSString *)account
{
    [_indicator startAnimating];
    
    NSString *extensionURI;
    
    if ([account isEqual: @"Hess 401k"]) {
        extensionURI = @"api/hessbenefits/get401k";
    }
    
    XYZWebServices *webServices = [[XYZWebServices alloc] init];
    [webServices RetrieveAccountValues:extensionURI:self];
}

- (void)setPageValues
{
    [_indicator stopAnimating];
    
    
    for (NSObject *obj in [GlobalObjects allAccInfoForUser]) {
        NSMutableDictionary *dict = (NSMutableDictionary*)obj;
        XYZAllAccountsInformation_Record *item = [[XYZAllAccountsInformation_Record alloc]init];
        item.ID = dict[@"ID"];
        item.LatestAmount = dict[@"LatestAmount"];
        item.AccountType = dict[@"AccountType"];
        item.LatestRequestDate = dict[@"LatestRequestDate"];
        
        if ([item.ID integerValue] == _accountID) {
            _lblAmount.text = [XYZFormattingHelper FormatDecimalToMoneyString:[item.LatestAmount doubleValue]];
            _lblRequestDate.text = [XYZFormattingHelper SetProperDateTime:item.LatestRequestDate];
            _lblAccountType.text = item.AccountType;
        }
    }
    
    //NSMutableDictionary *dict = (NSMutableDictionary*)object;
    //XYZAccountInformation*accInfo = [[XYZAccountInformation alloc] init];
    //accInfo.Amount = dict[@"Amount"];
    //accInfo.RequestDate = dict[@"RequestDate"];
    
    //_lblRequestDate.text = (accInfo.RequestDate != nil) ? [XYZFormattingHelper SetProperDateTime:accInfo.RequestDate] : @"Error";
    //_lblAmount.text = (accInfo.Amount != nil) ? [XYZFormattingHelper FormatDecimalToMoneyString:[accInfo.Amount doubleValue]] : @"Error";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
