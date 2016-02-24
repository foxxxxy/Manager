//
//  ReviewTableViewCell.h
//  SalesManager
//
//  Created by Student on 2/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnpairedTableView.h"

@interface ReviewTableViewCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *reviewLabel;
@property (strong, nonatomic) IBOutlet UITableView *unpairedCategoryTableView;
@property (strong, nonatomic) IBOutlet UITableView *pairCategoryTableView;

@property (strong, nonatomic) IBOutletCollection(UITableView) NSArray *categoriesTables;

- (IBAction)infoButtonPressed:(id)sender;

@property (strong, nonatomic) NSMutableArray *subCategotiesLabelList;
@property (strong, nonatomic) NSMutableArray *subIdentifierCellList;

@end
