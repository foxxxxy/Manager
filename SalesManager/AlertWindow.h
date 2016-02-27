//
//  AlertWindow.h
//  Edwardsver1
//
//  Created by Student on 2/23/16.
//  Copyright © 2016 Student. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertWindow : NSObject

+ (void)showInfoErrorWindow:(id)sender info:(NSString *)message;

@end
