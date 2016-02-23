//
//  SalesRepresentative.h
//  SalesManager
//
//  Created by Student on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface SalesRepresentative : NSObject

@property (nonatomic) NSInteger representativeId;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* managerName;
@property (nonatomic) NSInteger managerId;
@property (strong, nonatomic) NSString* region;
@property (strong, nonatomic) NSString* email;

+(void)mappingToObject:(RKObjectManager *) objectManager;

@end
