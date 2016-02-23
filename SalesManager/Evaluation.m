//
//  Evaluation.m
//  SalesManager
//
//  Created by Student on 2/23/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "Evaluation.h"

@implementation Evaluation

+(void)mappingToObject:(RKObjectManager *) objectManager{
    
    RKObjectMapping *evaluationMapping = [RKObjectMapping mappingForClass:[Evaluation class]];
    [evaluationMapping addAttributeMappingsFromDictionary:@{@"id": @"evaluationId",
                                                            @"representativeName": @"representativeName",
                                                            @"dateUTC": @"dateUTC",
                                                            @"status": @"status",
                                                            @"customer": @"customerInfo"}];
    
    
    RKResponseDescriptor *responseEvaluationDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:evaluationMapping
                                                                                                      method:RKRequestMethodGET
                                                                                                 pathPattern:@"evaluation/history/:identity"
                                                                                                     keyPath:@"result"
                                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseEvaluationDescriptor];
}

@end
