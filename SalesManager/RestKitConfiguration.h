//
//  RestKitConfiguration.h
//  SalesManager
//
//  Created by Student on 2/18/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestKitConfiguration : NSObject

-(void)configureRestKit;
-(void) loginEmail: (NSString*) email password: (NSString*) password access: (void(^)(BOOL))checkAccess;
-(void) forgotPassword: (NSString *) email access: (void(^)(BOOL))checkAccess;
-(void) getRepresentative: (void(^)(NSMutableArray *))getRepresentativeList;
-(void) logoutUser: (void(^)(BOOL))checkCompletion;
-(void) getEvaluationHistory:(NSInteger) identity : (void(^)(NSMutableArray *))getEvaluationList;
-(void) getEvaluation:(NSInteger) identity : (void(^)(NSMutableArray *))getEvaluationList;

@end
