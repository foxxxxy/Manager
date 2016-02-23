//
//  Login.h
//  SalesManager
//
//  Created by Student on 2/18/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface Authentication : NSObject

@property (nonatomic, strong) NSString* success;
@property (nonatomic, strong) NSString* result;
@property (nonatomic, strong) NSString* errorCode;

+(void)mappingToObject : (RKObjectManager *)objectManager :(RKMapping *) loginRequestMapping :(RKMapping *) loginResponseMapping;

@end
