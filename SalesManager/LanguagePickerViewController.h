//
//  PickerViewController.h
//  SalesManager
//
//  Created by Student on 2/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverSelectionDelegate.h"

@interface LanguagePickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *languagePicker;

- (IBAction)closePopoverButton:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@property (nonatomic,weak) id <PopoverSelectionDelegate> delegatePopover;

@end
