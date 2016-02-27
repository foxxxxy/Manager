//
//  CommentsEvaluationViewController.h
//  SalesManager
//
//  Created by Student on 2/16/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsEvaluationViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *commentsTextView;
@property (strong, nonatomic) NSString *evaluationComment;

- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)clearButtonPressed:(id)sender;

@end
