//
//  ResetPasswordViewController.h
//  SalesManager
//
//  Created by Student on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *emailTextView;

- (IBAction)cancelPopoverButton:(id)sender;
- (IBAction)resetPasswordButtonPressed:(id)sender;

@end
