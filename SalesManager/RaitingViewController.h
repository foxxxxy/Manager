//
//  RaitingViewController.h
//  SalesManager
//
//  Created by Student on 2/15/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Evaluation.h"

@interface RaitingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *raitingTableView;
@property (strong, nonatomic) NSMutableArray *subLabelList;
@property (strong, nonatomic) Evaluation *currentEvaluation;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)infoButtonPressed:(id)sender;

-(void)setCurrentIndex:indexPath;
-(void)setSubLabelList:(NSMutableArray *)subLabelList;
-(void)setCurrentEvaluation:(Evaluation *)currentEvaluation;
@end
