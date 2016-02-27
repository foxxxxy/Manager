//
//  ActionPlanRequest.h
//  SalesManager
//
//  Created by Student on 2/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface ActionPlanRequest : NSObject

@property (strong, nonatomic) NSString *criteriaName;
@property (strong, nonatomic) NSString *observationAction;
@property (strong, nonatomic) NSString *correctiveAction;
@property (strong, nonatomic) NSString *dueDateUTC;
@property (nonatomic) NSInteger rating;
@property (strong, nonatomic) NSMutableArray *subActionPlans;

@end
