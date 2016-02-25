//
//  ReviewTableViewCell.m
//  SalesManager
//
//  Created by Student on 2/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "ReviewTableViewCell.h"
#import "SubReviewTableCell.h"

#define TABLEVIEWS_COUNT 2

@interface ReviewTableViewCell ()

@property (strong, nonatomic) NSMutableArray *evalTitles;

@end

@implementation ReviewTableViewCell

- (IBAction)infoButtonPressed:(id)sender {
}

-(void)awakeFromNib{
    self.subCategotiesLabelList = [NSMutableArray arrayWithObjects:@"Builds trust", @"Behavior is honest, ethical, respectful and fair", @"Behaves like an owner", @"Conducts oneself in a professional manager", nil];
    self.subIdentifierCellList = [NSMutableArray arrayWithObjects:@"SubReviewCellUnpaired", @"SubReviewCellPaired", nil];
    
    self.evalTitles = [NSMutableArray array];
    for (int i = 0; i < TABLEVIEWS_COUNT; i++) {
        [self.evalTitles addObject:[NSMutableArray array]];
    }
    for (int i = 0, tableViewIndex = -1; i < self.subCategotiesLabelList.count; i++) {
        if(++tableViewIndex >= TABLEVIEWS_COUNT) {
            tableViewIndex = 0;
        }
        [self.evalTitles[tableViewIndex] addObject:self.subCategotiesLabelList[i]];
    }
    
    for (NSString *i in self.evalTitles) {
        NSLog(@"eval %@", i);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subCategotiesLabelList.count/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"fucking index.path! %d", indexPath.row);
    NSString *identifier = @"SubReviewCell";
    SubReviewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.categoryNameLabel.text = ((NSArray*)self.evalTitles[[self.categoriesTables indexOfObject:tableView]])[indexPath.row];
    return cell;
}
@end
