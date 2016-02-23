//
//  DueDataViewController.h
//  SalesManager
//
//  Created by Student on 2/16/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DueDataViewController : UIViewController 
@property (strong, nonatomic) IBOutlet UIDatePicker *dueDataPicker;

- (IBAction)cancelButtonPressed:(id)sender;


@end
