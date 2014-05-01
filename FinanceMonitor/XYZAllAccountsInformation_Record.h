//
//  XYZAllAccountsInformation_Record.h
//  FinanceMonitor
//
//  Created by NEC on 4/26/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZAllAccountsInformation_Record : NSObject
@property NSNumber *ID;
@property NSString *AccNickName;
@property NSNumber *AccountTypeID;
@property NSString *AccountType;
@property NSNumber *LatestAmount;
@property NSString *LatestRequestDate;
@property NSString *Active;
@end
