//
//  EvaluationTableViewController.m
//  SalesManager
//
//  Created by Student on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "EvaluationTableViewController.h"
#import "SalesTitleViewController.h"
#import "SalesTitleViewCell.h"
#import "EmailTableViewCell.h"
#import "SalesNameTableViewCell.h"
#import "RepresentativesViewController.h"
#import "SalesRepresentative.h"
#import "Evaluation.h"
#import "EvaluationExistCell.h"
#import "CustomerInfoViewController.h"


@interface EvaluationTableViewController () {
    UIPopoverController *popover;
}


@property (strong, nonatomic) NSMutableArray* identifierCellList;

@property (strong,nonatomic) UIPopoverPresentationController* salesTitlePopover;
@property (strong, nonatomic) SalesTitleViewController *titlePopover;
@property (strong, nonatomic) SalesTitleViewCell *titleCell;
@property(strong, nonatomic) NSString *email;
@property(strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSMutableArray *representativesList;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (nonatomic) BOOL isRepresentativeExist;
@property (strong, nonatomic)NSMutableArray *evaluationList;

@end

@implementation EvaluationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.identifierCellList = [[NSMutableArray alloc] initWithObjects:@"HeaderCell", @"NameCell", @"TitleCell", @"EmailCell", @"ButtonCell", @"HeaderHistoryCell", nil];
    
    if (_isRepresentativeExist) {
        [self.identifierCellList removeObject:@"EmailCell"];
        for (int i= 0; i<self.evaluationList.count; i++) {
            [self.identifierCellList addObject:@"EvaluationCell"];
        }
    }
}

-(void)setRepresentativesList:(NSMutableArray *)representativesList :(NSIndexPath *) currentIndexPath{
    _representativesList = representativesList;
    _currentIndexPath = currentIndexPath;
}

-(void)setEvaluationList:(NSMutableArray *)evaluationList{
    _evaluationList = evaluationList;
}

-(void)setRepresentativExist:(BOOL) isExist{
    _isRepresentativeExist = isExist;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)newEvaluationButtonPressed:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CustomerInfoViewController *controller = (CustomerInfoViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CustomerInfoPopover"];
    controller.delegate = self;
    
    //    controller.modalPresentationStyle = UIModalPresentationPopover;
    //    [self presentViewController:controller animated:YES completion:nil];
    //
    //    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    //    popController.permittedArrowDirections = 0;
    //    popController.delegate = self;
    //    popController.sourceView = self.view;
    //
    //    CGRect parent = self.view.frame;
    //    popController.sourceRect = CGRectMake(parent.size.width/2, parent.size.height/2, 0, 0);
    //
    //    self.salesTitlePopover = popController;
    CGPoint center = self.view.center;
    
    CGRect popverRect = CGRectMake(center.x-150, center.y-200, 300, 400);
    
    popover = [[UIPopoverController alloc] initWithContentViewController:controller];
    [popover presentPopoverFromRect:((UIView *)sender).frame inView:self.tableView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)showCustomerInfoPopover{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"CustomerInfoPopover"];
//    
//    controller.modalPresentationStyle = UIModalPresentationPopover;
//    [self presentViewController:controller animated:YES completion:nil];
//    
//    UIPopoverPresentationController *popController = [controller popoverPresentationController];
//    popController.permittedArrowDirections = 0;
//    popController.delegate = self;
//    popController.sourceView = self.view;
//    
//    CGRect parent = self.view.frame;
//    popController.sourceRect = CGRectMake(parent.size.width/2, parent.size.height/2, 0, 0);
//    
//    self.salesTitlePopover = popController;
}

-(BOOL)checkSalesTitle{
    if(self.titleCell.titleSalesLabel.text == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Please enter the representative's title."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *inidentifier = self.identifierCellList[indexPath.row];
    if ([inidentifier isEqualToString:@"ButtonCell"]) {
        return 101;
    }
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.identifierCellList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = self.identifierCellList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (_isRepresentativeExist) {
        SalesRepresentative *representative = [_representativesList objectAtIndex:_currentIndexPath.row];
        if ([identifier isEqualToString:@"NameCell"]){
            [((SalesNameTableViewCell *)cell).fullNameTextView setUserInteractionEnabled:NO];
            ((SalesNameTableViewCell *)cell).fullNameTextView.text = representative.name;
            
        }
        if ([identifier isEqualToString:@"TitleCell"]){
            [((SalesTitleViewCell *)cell).titleSalesLabel setText:representative.title];
            ((SalesTitleViewCell *)cell).bottomRowImageView.hidden = YES;
        }
        if ([identifier isEqualToString:@"EvaluationCell"]){
            Evaluation *evaluation = [self.evaluationList objectAtIndex:indexPath.row-self.identifierCellList.count+self.evaluationList.count];
            [self changeStatusBackground:((EvaluationExistCell *)cell).statusImage :evaluation];
        }
    }
    return cell;
}

-(void)changeStatusBackground :(UIImageView*)statusImage : (Evaluation *) evaluation{
    if ([evaluation.status isEqualToString:@"DRAFT"]) {
        [statusImage setImage:[UIImage imageNamed:@"status-background-draft.png"]];
    }else{
        [statusImage setImage:[UIImage imageNamed:@"status-background-complete.png"]];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *identifier = self.identifierCellList[indexPath.row];
    self.titleCell = [tableView cellForRowAtIndexPath:indexPath];
    if (!_isRepresentativeExist) {
        if ([identifier isEqualToString:@"TitleCell"]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"ChoosingTitlePopover"];
            
            self.titlePopover = (SalesTitleViewController *)controller;
            ((SalesTitleViewController *)controller).delegatePopover = self;
            
            controller.modalPresentationStyle = UIModalPresentationPopover;
            [self presentViewController:controller animated:YES completion:nil];
            
            UIPopoverPresentationController *popController = [controller popoverPresentationController];
            popController.permittedArrowDirections = UIPopoverArrowDirectionUp;
            popController.delegate = self;
            popController.sourceView = self.view;
            
            CGRect parent = self.view.frame;
            popController.sourceRect = CGRectMake(parent.size.width/2, parent.size.height/10, 10, 10);
            self.salesTitlePopover = popController;
        }
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        CGRect parent = self.view.frame;
        self.salesTitlePopover.sourceRect = CGRectMake(parent.size.width/2, parent.size.height/10, 10, 10);
    } completion:nil];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

-(void)popoverItemSelected:(NSString *)selectedItem{
    self.titleCell.titleSalesLabel.text = selectedItem;
}

@end
