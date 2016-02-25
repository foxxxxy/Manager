//
//  ReviewTableViewCell.m
//  SalesManager
//
//  Created by Student on 2/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "ReviewTableViewCell.h"
#import "SubReviewTableCell.h"
#import "ReviewViewController.h"
#import "Evaluation.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface ReviewTableViewCell ()

@property (strong, nonatomic) NSMutableArray *evalTitles;

@end

@implementation ReviewTableViewCell


-(void)awakeFromNib{
}

-(void)setSubLabelList:(NSMutableArray *)subLabelList{
    _subLabelList = subLabelList;
    [self dividedTtwoColumns];
    [self.unpairedCategoryTableView reloadData];
    [self.pairCategoryTableView reloadData];
}

-(void)setCurrentEvaluation:(Evaluation *)currentEvaluation{
    _currentEvaluation = currentEvaluation;
    NSLog(@"%@", [NSString stringWithFormat:@"%@ %@ %@", _currentEvaluation.category, _currentEvaluation.comment, _currentEvaluation.actionPlans]);
}

-(void)dividedTtwoColumns{
    self.evalTitles = [NSMutableArray array];
    for (int i = 0; i < self.categoriesTables.count; i++) {
        [self.evalTitles addObject:[NSMutableArray array]];
    }
    for (int i = 0, tableViewIndex = -1; i < self.subLabelList.count; i++) {
        if(++tableViewIndex >= self.categoriesTables.count) {
            tableViewIndex = 0;
        }
        [self.evalTitles[tableViewIndex] addObject:self.subLabelList[i]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray*)self.evalTitles[[self.categoriesTables indexOfObject:tableView]]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"SubReviewCell";
    SubReviewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.categoryNameLabel.text = ((NSArray*)self.evalTitles[[self.categoriesTables indexOfObject:tableView]])[indexPath.row];
    cell.raitingLabel.text = [self raitingToString:indexPath cell: cell];
    return cell;
}

-(NSString *)raitingToString:(NSIndexPath *)indexPath cell :(UITableViewCell *) cell{
    NSInteger raiting = [[self.currentEvaluation.actionPlans objectAtIndex:indexPath.row] rating];
    ((SubReviewTableCell *)cell).raitingLabel.font = [((SubReviewTableCell *)cell).raitingLabel.font fontWithSize:14.0f];
    if (raiting < 0) {
        return @"";
    }
    switch (raiting) {
        case 1:
            ((SubReviewTableCell *)cell).raitingLabel.textColor = [UIColor redColor];
            ((SubReviewTableCell *)cell).raitingLabel.font = [((SubReviewTableCell *)cell).raitingLabel.font fontWithSize:14.0f];
            break;
        case 2:
            ((SubReviewTableCell *)cell).raitingLabel.textColor = [UIColor redColor];
            break;
        case 3:
            ((SubReviewTableCell *)cell).raitingLabel.textColor = [UIColor orangeColor];
            break;
        case 4:
            ((SubReviewTableCell *)cell).raitingLabel.textColor = UIColorFromRGB(0x5D8C17);;
            break;
        case 5:
            ((SubReviewTableCell *)cell).raitingLabel.textColor = UIColorFromRGB(0x5D8C17);;
            break;
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%d", raiting];
}
@end
