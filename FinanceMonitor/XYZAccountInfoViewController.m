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
}

- (IBAction)refreshPage:(id)sender {
    [_indicator startAnimating];
    [self performSelector:@selector(retrieveAccountData:) withObject:_pageTitle afterDelay:1];
}

- (void)retrieveAccountData:(NSString *)account
{
    //[_indicator startAnimating];
    NSString *extensionURI;
    
    if ([account isEqual: @"Hess 401k"]) {
        extensionURI = @"api/hessbenefits/get401k";
    }
    
    //XYZWebServices *webServices = [[XYZWebServices alloc] init];
    //[webServices RetrieveAccountValues:extensionURI:self];
    [_indicator stopAnimating];//temp
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
