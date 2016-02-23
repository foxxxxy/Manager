//
//  CommentsEvaluationViewController.m
//  SalesManager
//
//  Created by Student on 2/16/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "CommentsEvaluationViewController.h"

@interface CommentsEvaluationViewController ()

@end

@implementation CommentsEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.preferredContentSize = CGSizeMake(550, 550);
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.commentsTextView.frame.size.height - 1, self.commentsTextView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor redColor].CGColor;
    [self.commentsTextView.layer addSublayer:bottomBorder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(id)sender {
    self.evaluationComment = self.commentsTextView.text;
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"saveComment" object:nil userInfo:@{@"evaluationComment":self.evaluationComment}]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearButtonPressed:(id)sender {
    self.commentsTextView.text = @"";
}
@end
