//
//  XYZWebServices.h
//  FinanceMonitor
//
//  Created by NEC on 4/20/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZWebServices: NSObject

- (void)GETWebService_async:(NSString *)extURI controller:(NSObject *)controller;
- (NSData*)GETWebService_sync:(NSString *)extURI;
- (void)POSTWebService_async:(NSString *)extURI POSTContent:(NSDictionary*)postContent controller:(NSObject *)controller;
- (NSData*)POSTWebService_sync:(NSString *)extURI POSTContent:(NSDictionary*)postContent;
@end
