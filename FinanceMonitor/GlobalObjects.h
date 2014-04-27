//
//  GlobalObjects.h
//  FinanceMonitor
//
//  Created by NEC on 4/26/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYZAllAccountsInformation.h"

@interface GlobalObjects : NSObject
+(void)load:(NSMutableArray*)loadData;
+(NSMutableArray*)allAccInfoForUser;
@end
