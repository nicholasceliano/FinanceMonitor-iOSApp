//
//  XYZAccountInfoViewController.m
//  FinanceMonitor
//
//  Created by NEC on 4/19/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import "XYZAccountInfoViewController.h"
#import "XYZAccountsListTableViewController.h"
#import "XYZHess401kAmount.h"

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
    
    NSString*baseURI = @"https://financemonitor.azurewebsites.net/";
    NSString*APILocation = @"api/hessbenefits/get401k";
    
    [self RetrieveAccountValues:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURI,APILocation]]];
}

- (void)setTitle:(NSString *)title
{
    self.pageTitle = title;
}

- (void)RetrieveAccountValues:(NSURL *)url
{
    [self.indicator startAnimating];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60];
    self.receivedData = [NSMutableData dataWithCapacity: 0];

    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSLog(@"%@", theConnection);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *e;
    NSArray *object = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingMutableContainers error:&e];
    
    NSDictionary *dict = (NSDictionary *)object;
    XYZHess401kAmount*acc = [[XYZHess401kAmount alloc]init];
    acc.Amount = dict[@"Amount"];
    acc.RequestTime = dict[@"RequestTime"];
    
    // Turn OFF the loading Icon
    [self.indicator stopAnimating];
    
    //Load controls
    [self SetPageValues:acc];
}

- (void)SetPageValues:(XYZHess401kAmount *)info401k
{
    self.lblTitle.text = self.pageTitle;
    self.lblTitleAmount.text = @"Amount:";
    self.lblAmount.text = (info401k.Amount != nil) ? [info401k.Amount stringValue] : @"Error";
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
