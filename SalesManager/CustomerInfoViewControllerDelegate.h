//
//  CustomerInfoViewControllerDelegate.h
//  SalesManager
//
//  Created by Student on 2/25/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomerInfoViewControllerDelegate <NSObject>

@optional

- (void)save:(NSString *)text;
- (void)skip;

@end
