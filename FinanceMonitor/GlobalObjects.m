	//
//  GlobalObjects.m
//  FinanceMonitor
//
//  Created by NEC on 4/26/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import "GlobalObjects.h"

static NSMutableArray* allAccInfoForUser = nil;
@implementation GlobalObjects
+(void)load:(NSMutableArray*)loadData {
    allAccInfoForUser = [[NSMutableArray alloc] init];
    allAccInfoForUser = loadData;
}
+(NSMutableArray*)allAccInfoForUser {
    return allAccInfoForUser;
}
@end
