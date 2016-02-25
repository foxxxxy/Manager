//
//  ReviewViewController.m
//  SalesManager
//
//  Created by Student on 2/18/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "ReviewViewController.h"
#import "ReviewTableViewCell.h"

@interface ReviewViewController ()

@property (strong, nonatomic) NSArray *identifierCellList;
@property (strong, nonatomic) NSArray *raitingCategotiesLabelList;
@property (strong, nonatomic) NSArray *subCategotiesLabelList;

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.identifierCellList = @[@"ReviewCell", @"ReviewCell", @"ReviewCell", @"ReviewCell"];
    self.raitingCategotiesLabelList = @[@"Professionalism and Integrity", @"Business Acumen", @"Results Orientation", @"Selling Skills"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.identifierCellList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"ReviewCell";
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.reviewLabel.text = [self.raitingCategotiesLabelList objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonPressed:(id)sender {
}

- (IBAction)deleteButtonPressed:(id)sender {
}
@end
