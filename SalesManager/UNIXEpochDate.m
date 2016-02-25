//
//  UNIXEpochDate.m
//  SalesManager
//
//  Created by Student on 2/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "UNIXEpochDate.h"

@implementation UNIXEpochDate

-(NSDate *)toDateUTCFormat:(NSString *)unixTimeStamp{
    NSDate *returnValue = [NSDate dateWithTimeIntervalSince1970:((NSTimeInterval)[unixTimeStamp doubleValue]/1000)];
    return returnValue;
}

-(NSString *)toStringUTCFormateDate:(NSDate *)dateUTC{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:@"MM.dd.yyyy"];
    NSString *dateString=[dateformatter stringFromDate:dateUTC];
    return dateString;
}

@end
