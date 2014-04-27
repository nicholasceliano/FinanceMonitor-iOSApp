//
//  XYZWebServices.m
//  FinanceMonitor
//
//  Created by NEC on 4/20/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import "XYZWebServices.h"
#import "XYZAccountInfoViewController.h"
#import "XYZHomePageTableViewController.h"
#import "XYZAccountsListTableViewController.h"
#import "GlobalObjects.h"

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
    NSMutableArray *object = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingMutableContainers error:&e];
    
    [GlobalObjects load:object];
    
    //Load controls
    if([_controller isKindOfClass:[XYZHomePageTableViewController class]])
        [(XYZHomePageTableViewController*)_controller setPageValues];
    else if ([_controller isKindOfClass:[XYZAccountInfoViewController class]])
        [(XYZAccountInfoViewController*)_controller setPageValues];
    else if ([_controller isKindOfClass:[XYZAccountsListTableViewController class]])
        [(XYZAccountsListTableViewController*)_controller setPageValues];
    
}

@end
