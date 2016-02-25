//
//  ReviewViewController.h
//  SalesManager
//
//  Created by Student on 2/18/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *reviewTableView;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)submitButtonPressed:(id)sender;
- (IBAction)deleteButtonPressed:(id)sender;
- (IBAction)infoButtonPressed:(id)sender;

@property (strong, nonatomic) NSArray *subCategotiesLabelList;

-(void)setEvaluationFullList:(NSMutableArray *)evaluationListFromServer;

@end
