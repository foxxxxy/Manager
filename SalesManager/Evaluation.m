//
//  Evaluation.m
//  SalesManager
//
//  Created by Student on 2/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "Evaluation.h"
#import "ActionPlanRequest.h"

@implementation Evaluation

+(void) mapToObjectManager:(RKObjectManager *)objectManager {
    
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Evaluation class]];
    [mapping addAttributeMappingsFromDictionary:@{ @"category" : @"categoryName",
                                                   @"comment": @"comment"}];
    
    RKObjectMapping* childMapping = [RKObjectMapping mappingForClass:[ActionPlanRequest class]];
    [childMapping addAttributeMappingsFromDictionary:@{ @"criteria" : @"criteriaName",
                                                        @"observationAction" : @"observationAction",
                                                        @"correctiveAction" : @"correctiveAction",
                                                        @"rating": @"rating",
                                                        @"dueDateUTC" : @"dueDateUTC"}];
    
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"actionPlans" toKeyPath:@"actionPlans" withMapping:childMapping]];
    
    [childMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"actionPlans" toKeyPath:@"actionPlans" withMapping:childMapping]];
    
    [objectManager addResponseDescriptor: [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                       method:RKRequestMethodAny
                                                                                  pathPattern:@"evaluation/:identity"
                                                                                      keyPath:@"result"
                                                                                  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
}


@end
