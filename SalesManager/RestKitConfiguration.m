//
//  RestKitConfiguration.m
//  SalesManager
//
//  Created by Student on 2/18/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "RestKitConfiguration.h"
#import <RestKit/RestKit.h>
#import "Authentication.h"
#import "LoginRequest.h"
#import "Container.h"
#import "ForgotPasswordRequest.h"
#import "SalesRepresentative.h"
#import "EvaluationHistoryRequest.h"
#import "Evaluation.h"

@implementation RestKitConfiguration

- (void)configureRestKit{
//        RKLogConfigureByName("RestKit/Request", RKLogLevelTrace);
//        RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    NSURL *baseURL = [NSURL URLWithString:@"http://52.91.82.122:80/api"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    [objectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Content-Type" value:RKMIMETypeJSON];
    
    
    RKObjectMapping *loginRequestMapping = [RKObjectMapping requestMapping];
    [loginRequestMapping addAttributeMappingsFromDictionary:@{@"email" : @"email",
                                                              @"password" : @"password"}];
    
    
    
    RKObjectMapping* loginResponseMapping = [RKObjectMapping mappingForClass:[Authentication class]];
    [loginResponseMapping addAttributeMappingsFromDictionary:@{@"success" : @"success",
                                                               @"result" : @"result",
                                                               @"error_code" : @"errorCode"}];
    
    
    
    [Authentication mappingToObject:objectManager :loginRequestMapping :loginResponseMapping];
//    [ForgotPasswordRequest mappingToObject:objectManager :loginResponseMapping];
    [SalesRepresentative mappingToObject:objectManager];
    [EvaluationHistoryRequest mappingToObject:objectManager];
    [Evaluation mapToObjectManager:objectManager];
}

-(void) loginEmail: (NSString*) email password: (NSString*) password access: (void(^)(BOOL))checkAccess  {
    LoginRequest *request = [[LoginRequest alloc] init];
    request.email = email;
    request.password = password;
    
    [[RKObjectManager sharedManager] postObject:request path:@"user/login" parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                            Authentication *login = result.array[0];
                                            if ([login.success isEqualToString:@"true"]) {
                                                [self registerAuthenticationTocken:login.result];
                                                BOOL isLoginSuccessful = YES;
                                                checkAccess(isLoginSuccessful);
                                            }
                                            NSLog(@"%@", login.result);
                                        }
                                        failure:^(RKObjectRequestOperation *operation, NSError *error){
                                            BOOL isLoginSuccessful = NO;
                                            checkAccess(isLoginSuccessful);
                                            NSLog(@"%@", error.localizedDescription);
                                        }];
    
}

-(void) forgotPassword: (NSString *) email access: (void(^)(BOOL))checkAccess{
    ForgotPasswordRequest *request = [[ForgotPasswordRequest alloc] init];
    request.email = email;
    
    [[RKObjectManager sharedManager] postObject:request path:@"user/forgot-password" parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                            Authentication *login = result.array[0];
                                            if ([login.success isEqualToString:@"true"]) {
                                                BOOL isLoginSuccessful = YES;
                                                checkAccess(isLoginSuccessful);
                                            }
                                            NSLog(@"%@", request.email);
                                        }
                                        failure:^(RKObjectRequestOperation *operation, NSError *error){
                                            BOOL isLoginSuccessful = NO;
                                            checkAccess(isLoginSuccessful);
                                            NSLog(@"%@", error.localizedDescription);
                                        }];
}

-(void) getRepresentative: (void(^)(NSMutableArray *))getRepresentativeList{
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"user/representatives" parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                                  getRepresentativeList((NSMutableArray *)result.array);
                                                  NSLog(@"%@", result.array[0]);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  NSLog(@"%@", error.localizedDescription);
                                              }];
}

-(void) logoutUser: (void(^)(BOOL))checkCompletion{
    [[RKObjectManager sharedManager] postObject:nil path:@"user/logout" parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                            Authentication *login = result.array[0];
                                            if ([login.success isEqualToString:@"true"]) {
                                                BOOL isLogoutSuccessful = YES;
                                                checkCompletion(isLogoutSuccessful);
                                            }
                                            NSLog(@"logoutUser %@", login.result);
                                        }
                                        failure:^(RKObjectRequestOperation *operation, NSError *error){
                                            BOOL isLogoutSuccessful = NO;
                                            checkCompletion(isLogoutSuccessful);
                                            NSLog(@"%@", error.localizedDescription);
                                        }];
    
}

-(void) getEvaluationHistory:(NSInteger) identity : (void(^)(NSMutableArray *))getEvaluationList{
    NSString *identityUrl = [NSString stringWithFormat:@"%@%d", @"evaluation/history/", identity];
    [[RKObjectManager sharedManager] getObjectsAtPath:identityUrl parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                                  getEvaluationList((NSMutableArray *)result.array);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  NSLog(@"%@", error.localizedDescription);
                                              }];
}

-(void) getEvaluation:(NSInteger) identity : (void(^)(NSMutableArray *))getEvaluationList{    
    NSString *identityUrl = [NSString stringWithFormat:@"%@%d", @"evaluation/", identity];
    [[RKObjectManager sharedManager] getObjectsAtPath:identityUrl parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                                                  getEvaluationList((NSMutableArray *)result.array);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  NSLog(@"%@", error.localizedDescription);
                                              }];
}

-(void)registerAuthenticationTocken: (NSString *) authorizationToken{
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"authToken" value:authorizationToken];
}

@end
