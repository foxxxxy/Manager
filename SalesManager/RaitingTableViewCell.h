//
//  RaitingTableViewCell.h
//  SalesManager
//
//  Created by Student on 2/15/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyPointView.h"
#import "OnePointView.h"
#import "TwoPointView.h"
#import "ThreePointView.h"
#import "FourPointView.h"
#import "FivePointView.h"

typedef enum {
    SubMenuActionShow,
    SubMenuActionHide,
    SubMenuActionNull
}SubMenuAction ;

@interface RaitingTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *raitingNameLabel;
@property (strong, nonatomic) IBOutletCollection(EmptyPointView) NSArray *pointViewCollection;


-(void)setTapListeners;

@end
