//
//  XYZWebServices.h
//  FinanceMonitor
//
//  Created by NEC on 4/20/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZWebServices: NSObject

- (void)RetrieveAccountValues:(NSString *)extURI:(NSObject *)controler;

@end
