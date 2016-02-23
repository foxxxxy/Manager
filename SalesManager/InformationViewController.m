//
//  InformationViewController.m
//  SalesManager
//
//  Created by Student on 2/16/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationViewCell.h"

@interface InformationViewController ()

@property (strong, nonatomic) NSArray *textForInfoLabels;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.preferredContentSize = CGSizeMake(265,  295);
    
    _textForInfoLabels =@[@"1 - Hurting perfomance, strong need to improve",
                          @"2 - Not always up to standart; result fall short",
                          @"3 - Does what is expected; if enyone performed this well the campany would be successful",
                          @"4 - Not always up to standart; result fall short",
                          @"5 - Hurting perfomance, strong need to improve"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textForInfoLabels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"InfoCell";
    InformationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.informationLabel.text = [self.textForInfoLabels objectAtIndex:indexPath.row];
        cell.informationLabel.font = [cell.informationLabel.font fontWithSize:12.0];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
