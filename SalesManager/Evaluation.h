//
//  Evaluation.h
//  SalesManager
//
//  Created by Student on 2/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "ActionPlanRequest.h"

@interface Evaluation : NSObject

@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSMutableArray <ActionPlanRequest *> *actionPlans;

+(void) mapToObjectManager:(RKObjectManager *)objectManager;

@end
