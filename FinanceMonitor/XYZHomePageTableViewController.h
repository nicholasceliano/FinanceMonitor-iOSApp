//
//  XYZHomePageTableViewController.h
//  FinanceMonitor
//
//  Created by NEC on 4/20/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZAccountInformation.h"

@interface XYZHomePageTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *lblRetirementDate;
@property (weak, nonatomic) IBOutlet UILabel *lblRetirementTotal;


- (void)setPageValues:(XYZAccountInformation*)accInfo;

@end
