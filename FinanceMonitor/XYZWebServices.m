//
//  XYZWebServices.m
//  FinanceMonitor
//
//  Created by NEC on 4/20/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import "XYZWebServices.h"
#import "XYZAccountInformation.h"
#import "XYZAccountInfoViewController.h"
#import "XYZHomePageTableViewController.h"
#import "XYZAccountsListTableViewController.h"

@interface XYZWebServices ()

@property NSMutableData *receivedData;

@property NSObject *controller;

@end

@implementation XYZWebServices

- (void)RetrieveAccountValues:(NSURL *)extensionURI: (NSObject *)controler
{
    _controller = controler;
    
    static NSString*baseURI = @"https://financemonitor.azurewebsites.net/";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURI,extensionURI]];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60];
    _receivedData = [NSMutableData dataWithCapacity: 0];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSLog(@"%@", theConnection);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *e;
    NSArray *object = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingMutableContainers error:&e];
    
    NSDictionary *dict = (NSDictionary *)object;
    
    XYZAccountInformation*ai = [[XYZAccountInformation alloc]init];
    ai.Amount = dict[@"Amount"];
    ai.RequestDate = dict[@"RequestDate"];
    
    
    
    //Load controls
    
    if([_controller isKindOfClass:[XYZHomePageTableViewController class]])
    {
        XYZHomePageTableViewController *page = _controller;
        [page setPageValues:ai];
    } else if ([_controller isKindOfClass:[XYZAccountInfoViewController class]])
    {
        XYZAccountInfoViewController *page = _controller;
        [page setPageValues:ai];
    } else if ([_controller isKindOfClass:[XYZAccountsListTableViewController class]])
    {
        XYZAccountsListTableViewController *page = _controller;
        [page setPageValues:ai];
    }
    
}

@end
