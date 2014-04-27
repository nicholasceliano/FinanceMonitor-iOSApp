//
//  XYZAccountInfoViewController.h
//  FinanceMonitor
//
//  Created by NEC on 4/19/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZAccountInfoViewController : UIViewController
- (IBAction)refreshPage:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *lblRequestDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountType;
@property NSInteger accountID;
@property NSString*pageTitle;
- (void)setPageValues;

@end
