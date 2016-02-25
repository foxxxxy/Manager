//
//  ReviewViewController.m
//  SalesManager
//
//  Created by Student on 2/18/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "ReviewViewController.h"
#import "ReviewTableViewCell.h"
#import "Evaluation.h"

@interface ReviewViewController ()

@property (strong, nonatomic) NSArray *identifierCellList;
@property (strong, nonatomic) NSArray *raitingCategotiesLabelList;
@property (strong, nonatomic) NSMutableArray *evaluationList;

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.identifierCellList = @[@"ReviewCell", @"ReviewCell", @"ReviewCell", @"ReviewCell"];
    self.raitingCategotiesLabelList = @[@"Professionalism and Integrity", @"Business Acumen", @"Results Orientation", @"Selling Skills"];
    
    self.subCategotiesLabelList = [NSMutableArray arrayWithObjects:
                                   @[@"Builds trust", @"Behavior is honest, ethical, respectful and fair", @"Behaves like an owner", @"Conducts oneself in a professional manager"],
                                   @[@"Manages time and workflow",@"Effectively analezws data", @"Problem solves",@"Utilizes available  resources effectively, including sales aids and clinical data", @"Demonstrates product knowelege",@"Effectively positions. Edwards vs. competitors"],
                                   @[@"Focuses on customer needs", @"Delivers on commitments"],
                                   @[@"Planning", @"Opening", @"Exploring", @"Demonstrating", @"Negotiating", @"Closing"], nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEvaluationFullList:(NSMutableArray *)evaluationListFromServer{
    self.evaluationList = evaluationListFromServer;
    self.evaluationList = [self sortEvaluationList:self.evaluationList];
}

-(NSMutableArray *)sortEvaluationList:(NSMutableArray *)list{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"category" ascending:YES];
    NSMutableArray *sortedList = (NSMutableArray *)[list sortedArrayUsingDescriptors:@[sortDescriptor]];
    return sortedList;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 214;
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
    cell.subLabelList = [self.subCategotiesLabelList objectAtIndex:indexPath.row];
    cell.currentEvaluation = [self.evaluationList objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}



- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonPressed:(id)sender {
    
}

- (IBAction)deleteButtonPressed:(id)sender {
}

- (IBAction)infoButtonPressed:(id)sender {
    [self showPopup];
//    for (int i = 0; i < self.titles.count; i++) {
//        if(((ReviewTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]).infoButton == sender) {
//            self.infoButtonIndex = i;
//            break;
//        }
//    }
}

-(void)showPopup{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"CategoriesInformationPopup"];

    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popController.sourceView = self.reviewTableView;
    popController.sourceRect = CGRectMake(50, 10, 10, 10);
}
@end
