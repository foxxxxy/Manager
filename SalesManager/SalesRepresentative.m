//
//  SalesRepresentative.m
//  SalesManager
//
//  Created by Student on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "SalesRepresentative.h"

@implementation SalesRepresentative

+(void)mappingToObject:(RKObjectManager *) objectManager{
    RKObjectMapping *representativeMapping = [RKObjectMapping mappingForClass:[SalesRepresentative class]];
    [representativeMapping addAttributeMappingsFromDictionary:@{@"representativeId": @"representativeId",
                                                                @"fullname": @"name",
                                                                @"title": @"title",
                                                                @"managerName": @"managerName",
                                                                @"managerId": @"managerId",
                                                                @"region": @"region"}];
    
    RKResponseDescriptor *responseRepresentativeDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:representativeMapping
                                                                                                          method:RKRequestMethodGET
                                                                                                     pathPattern:@"user/representatives"
                                                                                                         keyPath:@"result"
                                                                                                     statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseRepresentativeDescriptor];
}

@end
