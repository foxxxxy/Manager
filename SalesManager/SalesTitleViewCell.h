//
//  SalesTitleViewCell.h
//  SalesManager
//
//  Created by Student on 2/22/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverSelectionDelegate.h"

@interface SalesTitleViewCell : UITableViewCell <PopoverSelectionDelegate>

@property (strong, nonatomic) IBOutlet UILabel *titleSalesLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bottomRowImageView;


@end
