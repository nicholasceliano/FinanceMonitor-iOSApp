//
//  XYZAccountsListTableViewController.h
//  FinanceMonitor
//
//  Created by NEC on 4/19/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZAllAccountsInformation.h"

@interface XYZAccountsListTableViewController : UITableViewController


- (void)setPageValues:(XYZAllAccountsInformation*)accInfo;

@end
