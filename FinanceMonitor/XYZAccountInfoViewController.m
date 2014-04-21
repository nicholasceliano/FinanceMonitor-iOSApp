//
//  XYZAccountInfoViewController.m
//  FinanceMonitor
//
//  Created by NEC on 4/19/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import "XYZAccountInfoViewController.h"
#import "XYZAccountsListTableViewController.h"
#import "XYZAccountInformation.h"
#import "XYZWebServices.h"
#import "XYZFormattingHelper.h"

@interface XYZAccountInfoViewController ()
@property NSString *pageTitle;
@property NSMutableData *receivedData;
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
    
    [self retrieveAccountData:_pageTitle];
}

- (void)retrieveAccountData:(NSString *)account
{
    [_indicator startAnimating];
    
    NSString *extensionURI;
    
    if ([account isEqual: @"Hess 401k"]) {
        extensionURI = @"api/hessbenefits/get401k";
    }
    
    XYZWebServices *webServices = [[XYZWebServices alloc] init];
    [webServices RetrieveAccountValues:extensionURI :self];
}

- (void)setTitle:(NSString *)pageTitle
{
    _pageTitle = pageTitle;
}

- (void)setPageValues:(XYZAccountInformation *)accInfo
{
    [_indicator stopAnimating];
    
    _lblRequestDate.text = (accInfo.RequestDate != nil) ? [XYZFormattingHelper SetProperDateTime:accInfo.RequestDate] : @"Error";
    _lblAmount.text = (accInfo.Amount != nil) ? [XYZFormattingHelper FormatDecimalToMoneyString:accInfo.Amount] : @"Error";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
