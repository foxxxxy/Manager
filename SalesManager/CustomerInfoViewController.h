//
//  CustomerInfoViewController.h
//  SalesManager
//
//  Created by Student on 2/10/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerInfoViewControllerDelegate.h"

@protocol CustomerInfoViewControllerDelegate <NSObject>

- (void)save:(NSString *)text;
- (void)skip;

@end

@interface CustomerInfoViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) id <CustomerInfoViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextView *customerInfoTextView;

@property (weak, nonatomic) id <CustomerInfoViewControllerDelegate> delegate;
- (IBAction)skipButtonPressed:(id)sender;

- (IBAction)saveButtonPressed:(id)sender;

@end
