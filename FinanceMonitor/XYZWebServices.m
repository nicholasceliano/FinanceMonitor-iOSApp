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

const NSString*baseURI = @"https://financemonitor.azurewebsites.net/";

- (void)GETWebService_async:(NSString *)extURI controller:(NSObject *)controller
{
    _controller = controller;
    
    NSMutableURLRequest*request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURI,extURI]]];
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [theConnection start];
}

- (NSData*)GETWebService_sync:(NSString *)extURI;
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseURI, extURI]]];
    
    [request setHTTPMethod:@"GET"];
    NSURLResponse *response;
    NSError *error = nil;
    
    //Capturing server response
    NSData *result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    return result;
}

- (void)POSTWebService_async:(NSString *)extURI POSTContent:(NSDictionary*)postContent controller:(NSObject *)controller
{
    _controller = controller;
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postContent options:0 error:nil];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest*request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseURI, extURI]]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];

    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [theConnection start];
}

- (NSData*)POSTWebService_sync:(NSString *)extURI POSTContent:(NSDictionary*)postContent
{
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postContent options:0 error:nil];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseURI, extURI]]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accepts"];
    [request setHTTPBody:postData];
    NSURLResponse *response;
    NSError *error = nil;
    
    //Capturing server response
    NSData *result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    return result;
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
