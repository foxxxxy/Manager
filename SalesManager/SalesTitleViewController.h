//
//  SalesTitleViewController.h
//  SalesManager
//
//  Created by Student on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverSelectionDelegate.h"

@interface SalesTitleViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *salesTitelPicker;

@property (nonatomic,weak) id <PopoverSelectionDelegate> delegatePopover;

- (IBAction)closeSalesTitlePopover:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@end
