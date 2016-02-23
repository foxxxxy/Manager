//
//  PopoverSelectionDelegate.h
//  SalesManager
//
//  Created by Student on 2/22/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopoverSelectionDelegate <NSObject>

@optional

- (void)popoverItemSelected:(NSString *)selectedItem;

@end
