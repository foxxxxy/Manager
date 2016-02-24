//
//  RaitingViewController.h
//  SalesManager
//
//  Created by Student on 2/15/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaitingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *raitingTableView;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)infoButtonPressed:(id)sender;

-(void)setCurrentIndex:indexPath;

@end
