//
//  RepresentativesViewController.h
//  SalesManager
//
//  Created by Student on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepresentativesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *representativesTableView;

- (IBAction)logoutButtonPressed:(id)sender;

-(void)setRepresentativesArray:(NSMutableArray *) representatives;

@end
