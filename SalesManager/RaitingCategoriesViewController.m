//
//  RaitingViewController.m
//  SalesManager
//
//  Created by Student on 2/11/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "RaitingCategoriesViewController.h"
#import "RaitingCategoriesTableViewCell.h"

@interface RaitingCategoriesViewController ()

@property (strong, nonatomic) NSArray *raitingCategotiesLabelList;

@end

@implementation RaitingCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.raitingCategotiesLabelList = @[@"Professionalism and Integrity", @"Business Acumen", @"Results Orientation", @"Selling Skills"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"RaitingCategoriesCell";
    RaitingCategoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.categoriesLabel.text = [self.raitingCategotiesLabelList objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
@end
