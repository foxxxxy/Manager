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
#import "CategoriesInformationPopup.h"
#import "RaitingViewController.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface ReviewViewController ()

@property (strong, nonatomic) NSArray *identifierCellList;
@property (strong, nonatomic) NSArray *raitingCategotiesLabelList;
@property (strong, nonatomic) NSArray *subRaitingCategotiesLabelList;
@property (strong, nonatomic) NSMutableArray *evaluationList;
@property (nonatomic) NSInteger infoButtonIndex;

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
    
    self.subRaitingCategotiesLabelList = @[@[@"Has a writen weekly visit plan",
                                             @"Has an up-to-date S.W.O.T analysis for agreed key Hospitals",
                                             @"Has a written customer plan for agreed key Hospitals",
                                             @"Stores customer information which is accessible",
                                             @"Uses a day plan (which specifies time with key Stakeholders)"],
                                           
                                           @[@"Uses a purpose benefit statement",
                                             @"Gains full audience attention",
                                             @"States agenda and duration",
                                             @"Gains agreement to proced",
                                             @"Uses eye contact comfortably"],
                                           
                                           @[@"Prepares questions",
                                             @"Asks a balance of open & closed questions",
                                             @"Probes answers deeply",
                                             @"Takes notes",
                                             @"Plants idea to help the pitch",
                                             @"Summarises"],
                                           
                                           @[@"Presents with structure",
                                             @"Keeps attention",
                                             @"Uses visual adis",
                                             @"Provides clinical evidence",
                                             @"Handles objections with confidence",
                                             @"Closes clearly"],
                                           
                                           @[@"Has a written plan",
                                             @"Aims high",
                                             @"Has a walk away position",
                                             @"Takes a strong stance",
                                             @"Asks about customer needs and interests",
                                             @"Trades low cost for high value"],
                                           
                                           @[@"Summarises needs",
                                             @"Restates benefits of Edwards' proposal",
                                             @"Asks for the order",
                                             @"Handles objections",
                                             @"Gets the order",
                                             @"Agrees next steps"]];
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
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"categoryName" ascending:YES];
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
    cell.raitingLabel.text = [self showOverallRating:[self calculateRating:cell.currentEvaluation] cell:cell];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(NSInteger)calculateRating:(Evaluation *) currentEvaluation{
    NSInteger overallRating = 0;
    NSInteger sum = 0;
    NSLog(@"currentEvaluation.actionPlans.count %d", currentEvaluation.actionPlans.count);
    
    for (int i = 0; i < currentEvaluation.actionPlans.count; i++) {
        if (currentEvaluation.actionPlans[i].rating > 0) {
            sum += currentEvaluation.actionPlans[i].rating;
        }
    }
    
    overallRating = sum/currentEvaluation.actionPlans.count;
    NSLog(@"overallRating %d", overallRating);
    return overallRating;
}

-(NSString *)showOverallRating:(NSInteger)rating cell :(UITableViewCell *) cell{
    if (rating <= 0) {
        return @"Raiting";
    }
    [self styleGeneralRaitingLabel:cell withRaiting:rating];
    return [NSString stringWithFormat:@"%d", rating];
}

-(void)styleGeneralRaitingLabel:(UITableViewCell *)cell withRaiting: (NSInteger) raiting{
    ((ReviewTableViewCell *)cell).raitingLabel.font = [((ReviewTableViewCell *)cell).raitingLabel.font fontWithSize:14.0f];
    switch (raiting) {
        case 1:
            ((ReviewTableViewCell *)cell).raitingLabel.textColor = [UIColor redColor];
            ((ReviewTableViewCell *)cell).raitingLabel.font = [((ReviewTableViewCell *)cell).raitingLabel.font fontWithSize:14.0f];
            break;
        case 2:
            ((ReviewTableViewCell *)cell).raitingLabel.textColor = [UIColor redColor];
            break;
        case 3:
            ((ReviewTableViewCell *)cell).raitingLabel.textColor = [UIColor orangeColor];
            break;
        case 4:
            ((ReviewTableViewCell *)cell).raitingLabel.textColor = UIColorFromRGB(0x5D8C17);;
            break;
        case 5:
            ((ReviewTableViewCell *)cell).raitingLabel.textColor = UIColorFromRGB(0x5D8C17);;
            break;
        default:
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonPressed:(id)sender {
    
}

- (IBAction)deleteButtonPressed:(id)sender {
}

- (IBAction)infoButtonPressed:(id)sender {
    [self indexButtonPressed:sender];
    [self showPopup];
}

-(void)indexButtonPressed:(id) sender{
    for (int i = 0; i < self.raitingCategotiesLabelList.count; i++) {
        if(((ReviewTableViewCell*)[self.reviewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]).infoButton == sender) {
            self.infoButtonIndex = i;
            break;
        }
    }
}

-(void)showPopup{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CategoriesInformationPopup *controller = (CategoriesInformationPopup *)[storyboard instantiateViewControllerWithIdentifier:@"CategoriesInformationPopup"];
    controller.buttonIndex = self.infoButtonIndex;
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popController.sourceView = ((ReviewTableViewCell*)[self.reviewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:self.infoButtonIndex inSection:0]]).infoButton;
    popController.sourceRect = CGRectMake(13, 20, 10, 10);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCurrentRaiting"])
    {
        NSIndexPath *indexPath = [self.reviewTableView indexPathForSelectedRow];
        
        if(indexPath){
            [segue.destinationViewController setCurrentIndex:indexPath];
            [segue.destinationViewController setSubLabelList:[self.subCategotiesLabelList objectAtIndex:indexPath.row]];
            [segue.destinationViewController setCurrentEvaluation:[self.evaluationList objectAtIndex:indexPath.row]];
            [segue.destinationViewController setSubRaitingLabelList:self.subRaitingCategotiesLabelList];
        }
    }
}

@end
