//
//  ForgotPasswordRequest.h
//  SalesManager
//
//  Created by Student on 2/19/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface ForgotPasswordRequest : NSObject

@property (strong, nonatomic) NSString *email;

+(void)mappingToObject :(RKObjectManager *)objectManager : (RKMapping *) loginResponseMapping;

@end
