//
//  ReviewTableViewCell.h
//  SalesManager
//
//  Created by Student on 2/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnpairedTableView.h"
#import "Evaluation.h"

@interface ReviewTableViewCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *reviewLabel;
@property (strong, nonatomic) IBOutlet UILabel *raitingLabel;
@property (strong, nonatomic) IBOutlet UILabel *perfomanceLabel;
@property (strong, nonatomic) IBOutlet UITableView *unpairedCategoryTableView;
@property (strong, nonatomic) IBOutlet UITableView *pairCategoryTableView;
@property (strong, nonatomic) IBOutletCollection(UITableView) NSArray *categoriesTables;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;

@property (strong, nonatomic) NSMutableArray *subLabelList;
@property (strong, nonatomic) Evaluation *currentEvaluation;

@end
