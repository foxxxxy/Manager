//
//  EvaluationTableViewController.h
//  SalesManager
//
//  Created by Student on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverSelectionDelegate.h"
<<<<<<< HEAD
#import "CustomerInfoViewControllerDelegate.h"
=======
#import "CustomerInfoViewController.h"
>>>>>>> 1d559a733e2b2a999a346c8ca74c724937e9a2e1

@interface EvaluationTableViewController : UITableViewController <UIPopoverPresentationControllerDelegate, PopoverSelectionDelegate, CustomerInfoViewControllerDelegate>

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)newEvaluationButtonPressed:(id)sender;

-(void)setRepresentativesList:(NSMutableArray *)representativesList :(NSIndexPath *) currentIndexPath;
-(void)setRepresentativExist:(BOOL) isExist;
-(void)setEvaluationList:(NSMutableArray *)evaluationList;
@end
