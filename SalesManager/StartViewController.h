//
//  ViewController.h
//  SalesManager
//
//  Created by Student on 2/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverSelectionDelegate.h"

@interface StartViewController : UIViewController <UIPopoverPresentationControllerDelegate, PopoverSelectionDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

@property (strong, nonatomic) IBOutlet UILabel *forgotPasswordLabel;
@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *languageChangeButton;

- (IBAction)chooseLanguage:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;

@end

