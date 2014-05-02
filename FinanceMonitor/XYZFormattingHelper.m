//
//  XYZFormattingHelper.m
//  FinanceMonitor
//
//  Created by NEC on 4/20/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import "XYZFormattingHelper.h"

@implementation XYZFormattingHelper

+ (NSString*)SetProperDateTime:(NSString*)stringDate
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SS"];
    NSDate *date = [formatter dateFromString:stringDate];
    
    [formatter setDateFormat: @"MMM dd, yyyy hh:mm:ss a"];
    
    return [formatter stringFromDate:date];
}

+ (NSString*)FormatDecimalToMoneyString:(double)decimalValue
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setUsesGroupingSeparator:YES];
    
    return [formatter stringFromNumber:[NSNumber numberWithDouble:decimalValue]];
}

+ (BOOL)ValidateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
