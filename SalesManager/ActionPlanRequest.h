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

@property (nonatomic, strong) NSString *criteria;
@property (nonatomic, strong) NSString *dueDateUTC;
@property (nonatomic) NSInteger rating;
@property (nonatomic, strong) NSArray *subActionPlans;




@end
