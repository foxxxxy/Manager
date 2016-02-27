//
//  CustomerInfoViewController.h
//  SalesManager
//
//  Created by Student on 2/10/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerInfoViewControllerDelegate.h"

@interface CustomerInfoViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *customerInfoTextView;
@property (weak, nonatomic) id <CustomerInfoViewControllerDelegate> delegate;

- (IBAction)skipButtonPressed:(id)sender;

- (IBAction)saveButtonPressed:(id)sender;

@end
