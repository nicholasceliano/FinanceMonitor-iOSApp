//
//  XYZAccountInfoViewController.h
//  FinanceMonitor
//
//  Created by NEC on 4/19/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZAccountInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitleAmount;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;

@end
