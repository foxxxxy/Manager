//
//  Login.m
//  SalesManager
//
//  Created by Student on 2/18/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "Authentication.h"
#import "LoginRequest.h"

@implementation Authentication

+(void)mappingToObject : (RKObjectManager *)objectManager :(RKMapping *) loginRequestMapping : (RKMapping *) loginResponseMapping{
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:loginRequestMapping
                                                                                   objectClass:[LoginRequest class]
                                                                                   rootKeyPath:nil
                                                                                        method:RKRequestMethodPOST];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:loginResponseMapping
                                                                                            method:RKRequestMethodPOST
                                                                                       pathPattern:@"user/login"
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responseLogoutDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:loginResponseMapping
                                                                                                  method:RKRequestMethodPOST
                                                                                             pathPattern:@"user/logout"
                                                                                                 keyPath:nil
                                                                                             statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addRequestDescriptor:requestDescriptor];
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager addResponseDescriptor:responseLogoutDescriptor];
}

@end
