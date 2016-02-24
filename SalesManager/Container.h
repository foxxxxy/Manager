//
//  Container.h
//  SalesManager
//
//  Created by Student on 2/19/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestKitConfiguration.h"
#import "UNIXEpochDate.h"


@interface Container : NSObject

@property (strong, nonatomic) RestKitConfiguration *restConfiguration;
@property (strong, nonatomic) UNIXEpochDate *unixData;

+(Container *)sharedInstance;

@end
