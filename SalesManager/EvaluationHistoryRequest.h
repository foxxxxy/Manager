//
//  Evaluation.h
//  SalesManager
//
//  Created by Student on 2/23/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface EvaluationHistoryRequest : UITableViewCell

@property (nonatomic) NSInteger evaluationId;
@property (strong, nonatomic) NSString *representativeName;
@property (strong, nonatomic) NSString *dateUTC;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *customerInfo;

+(void)mappingToObject:(RKObjectManager *) objectManager;

@end
