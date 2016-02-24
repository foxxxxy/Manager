//
//  UNIXEpochDate.h
//  SalesManager
//
//  Created by Student on 2/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UNIXEpochDate : NSObject

-(NSDate *)toDateUTCFormat:(NSString *)unixTimeStamp;

-(NSString *)toStringUTCFormateDate:(NSDate *)dateUTC;

@end
