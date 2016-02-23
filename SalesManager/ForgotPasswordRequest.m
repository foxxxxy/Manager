//
//  ForgotPasswordRequest.m
//  SalesManager
//
//  Created by Student on 2/19/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "ForgotPasswordRequest.h"

@implementation ForgotPasswordRequest

+(void)mappingToObject:(RKObjectManager *) objectManager : (RKMapping *) loginResponseMapping{
    
    RKObjectMapping *forgotPasswordRequestMapping = [RKObjectMapping requestMapping];
    [forgotPasswordRequestMapping addAttributeMappingsFromDictionary:@{@"email" : @"email"}];
    
    RKRequestDescriptor *requestForgotPasswordDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:forgotPasswordRequestMapping
                                                                                                 objectClass:[ForgotPasswordRequest class]
                                                                                                 rootKeyPath:nil
                                                                                                      method:RKRequestMethodPOST];
    
    RKResponseDescriptor *responseForgotPasswordDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:loginResponseMapping
                                                                                                          method:RKRequestMethodPOST
                                                                                                     pathPattern:@"user/forgot-password"
                                                                                                         keyPath:nil
                                                                                                     statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addRequestDescriptor:requestForgotPasswordDescriptor];
    [objectManager addResponseDescriptor:responseForgotPasswordDescriptor];
}

@end
