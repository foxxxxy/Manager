//
//  Container.m
//  SalesManager
//
//  Created by Student on 2/19/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "Container.h"

@implementation Container

+(Container *)sharedInstance{
    static Container *instance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        instance = [[Container alloc] init];
    });
    return instance;
}

-(RestKitConfiguration *)restConfiguration{
    if (_restConfiguration == nil) {
        _restConfiguration = [[RestKitConfiguration alloc] init];
    }
    return _restConfiguration;
}

@end
