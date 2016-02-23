//
//  Container.h
//  SalesManager
//
//  Created by Student on 2/19/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestKitConfiguration.h"
#import "LoginRequest.h"

@interface Container : NSObject

@property (strong, nonatomic) RestKitConfiguration *restConfiguration;

+(Container *)sharedInstance;

@end
