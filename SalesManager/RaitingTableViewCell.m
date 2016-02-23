//
//  RaitingTableViewCell.m
//  SalesManager
//
//  Created by Student on 2/15/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "RaitingTableViewCell.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
    green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
    blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
    alpha:1.0]

@interface RaitingTableViewCell ()

@property (nonatomic) BOOL isSubMenuShowed;
@property (nonatomic) SubMenuAction subMenuAction;

@end

@implementation RaitingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self setTapListeners];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void) setTapListeners {
    for (UIView* point in self.pointViewCollection) {
        point.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pointTaped:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        
        [point addGestureRecognizer:tapGestureRecognizer];
    }
}



-(void)pointTaped:(UIGestureRecognizer*)gestureRecognizer{
    for (EmptyPointView *pointView in self.pointViewCollection) {
        pointView.pointImage.image = [UIImage imageNamed:@"empty-point.png"];
        pointView.pointLabel.textColor = [UIColor blackColor];
        pointView.pointLabel.font = [pointView.pointLabel.font fontWithSize:14.0];
    }
    EmptyPointView *pointView = (EmptyPointView *)gestureRecognizer.view;
        NSInteger index = [self.pointViewCollection indexOfObject:pointView];
    switch (index) {
        case 0:
            pointView.pointImage.image = [UIImage imageNamed:@"gray-point.png"];
            pointView.pointLabel.font = [pointView.pointLabel.font fontWithSize:15.0];
            break;
        case 1:
            pointView.pointImage.image = [UIImage imageNamed:@"red-point.png"];
            pointView.pointLabel.textColor = [UIColor redColor];
            pointView.pointLabel.font = [pointView.pointLabel.font fontWithSize:15.0];
            break;
        case 2:
            pointView.pointImage.image = [UIImage imageNamed:@"red-point.png"];
            pointView.pointLabel.textColor = [UIColor redColor];
            pointView.pointLabel.font = [pointView.pointLabel.font fontWithSize:15.0];
            break;
        case 3:
            pointView.pointImage.image = [UIImage imageNamed:@"orange-point.png"];
            pointView.pointLabel.textColor = [UIColor orangeColor];
            pointView.pointLabel.font = [pointView.pointLabel.font fontWithSize:15.0];
            break;
        case 4:
            pointView.pointImage.image = [UIImage imageNamed:@"green-point.png"];
            pointView.pointLabel.textColor = UIColorFromRGB(0x5D8C17);
            pointView.pointLabel.font = [pointView.pointLabel.font fontWithSize:15.0];
            break;
        case 5:
            pointView.pointImage.image = [UIImage imageNamed:@"green-point.png"];
            pointView.pointLabel.textColor = UIColorFromRGB(0x5D8C17);
            pointView.pointLabel.font = [pointView.pointLabel.font fontWithSize:15.0];
            break;
        default:
            break;
    }
    if (index > 0 && index < 3) {
        if (self.isSubMenuShowed) {
            self.subMenuAction = SubMenuActionNull;
        } else {
            self.subMenuAction = SubMenuActionShow;
            self.isSubMenuShowed = YES;
        }
    }else{
        if (self.isSubMenuShowed) {
            self.subMenuAction = SubMenuActionHide;
            self.isSubMenuShowed = NO;
        } else {
            self.subMenuAction = SubMenuActionNull;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"addBottomRows" object:nil userInfo:@{@"cell":self, @"subMenuAction":@(self.subMenuAction)}]];
}

@end
