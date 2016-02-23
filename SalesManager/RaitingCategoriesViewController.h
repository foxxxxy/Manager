//
//  RaitingViewController.h
//  SalesManager
//
//  Created by Student on 2/11/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaitingCategoriesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *raitingTableView;

- (IBAction)backButtonPressed:(id)sender;

@end
