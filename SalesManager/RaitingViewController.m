//
//  RaitingViewController.m
//  SalesManager
//
//  Created by Student on 2/15/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "RaitingViewController.h"
#import "RaitingTableViewCell.h"
#import "GeneralHeaderTableViewCell.h"
#import "ActionPlanRequest.h"

@interface RaitingViewController ()

@property (strong,nonatomic) UIPopoverPresentationController* salesTitlePopover;
@property (strong, nonatomic) NSMutableArray* identifierCellList;
@property (strong, nonatomic) NSArray* identifierBottomCellList;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (strong, nonatomic) NSMutableArray* subRaitingCellList;
@property (strong, nonatomic) NSArray *subratingTitles;

@end

@implementation RaitingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.identifierCellList = [[NSMutableArray alloc] init];
    self.subRaitingCellList = [NSMutableArray array];
    self.subratingTitles = [[NSArray alloc] init];
    self.identifierBottomCellList = @[@"ObservationCell", @"DevelopmentalActionCell", @"DueDataCell"];
    
    [self addRaitingTableCell:_currentIndexPath];
    [self.identifierCellList addObjectsFromArray:@[@"CommentHeaderCell", @"CommentCell"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showOrHideCommentRows:) name:@"addBottomRows" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)infoButtonPressed:(id)sender {
    [self showInformationPopover:sender];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setSubRaitingLabelList:(NSArray *)subRaitingLabelList{
    _subRaitingLabelList = subRaitingLabelList;
}

-(void)setSubLabelList:(NSMutableArray *)subLabelList{
    _subLabelList = subLabelList;
}

-(void)setCurrentEvaluation:(Evaluation *)currentEvaluation{
    _currentEvaluation = currentEvaluation;
}

-(void)addCellToIdentifierCellList: (NSInteger)count{
    for(int i = 0; i < count; i++){
        [self.identifierCellList addObject:@"RaitingCell"];
    }
}

-(void)addSubRaitingCell:(NSInteger)count{
    for (int i =0; i < count; i++) {
        [self.subRaitingCellList addObject:@"SubRaitingCell"];
    }
}

-(void)setCurrentIndex:indexPath{
    _currentIndexPath = indexPath;
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
    if([identifier isEqualToString:@"RaitingCell"]){
        if(_currentIndexPath.row == 3){
            ((RaitingTableViewCell *)cell).isSubRaitingExist = YES;
        }
        ((RaitingTableViewCell *)cell).raitingNameLabel.text = [_subLabelList objectAtIndex:[self getCellPositionByIndex:indexPath.row]];
        [((RaitingTableViewCell *)cell) currentPointStyle:[_currentEvaluation.actionPlans objectAtIndex:[self getCellPositionByIndex:indexPath.row]].rating];
    }if([identifier isEqualToString:@"SubRaitingCell"]){
        ((RaitingTableViewCell *)cell).raitingNameLabel.text = [self getTitleForSubratingCellAtIndex:indexPath.row];
    }
    return cell;
}

-(NSInteger) getCellPositionByIndex: (NSInteger) index {
    NSInteger result = 0;
    for (int i = 0; i < index; i++) {
        if([self.identifierCellList[i] isEqualToString:@"RaitingCell"]){
            result++;
        }
    }
    return result;
}

-(NSString*) getTitleForSubratingCellAtIndex: (NSInteger) index {
    NSInteger ratingCellIndex = 0;
    NSInteger subratingCellIndex = 0;
    
    for (int i = 0; i < index; i++) {
        if([self.identifierCellList[i] isEqualToString:@"RaitingCell"]) {
            ratingCellIndex++;
            subratingCellIndex = 0;
        }
        if([self.identifierCellList[i] isEqualToString:@"SubRaitingCell"]) {
            subratingCellIndex++;
        }
    }
    
    return self.subRaitingLabelList[ratingCellIndex - 1][subratingCellIndex];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = self.identifierCellList[indexPath.row];
    if ([identifier isEqualToString:@"RaitingCell"] || [identifier isEqualToString:@"CommentCell"]) {
        return 145;
    }
    if ([identifier isEqualToString:@"SubRaitingCell"]) {
        return 75;
    }
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 75.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GeneralHeaderTableViewCell* headerTableCell = [tableView dequeueReusableCellWithIdentifier:@"GeneralTableHeader"];
    return headerTableCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *identifier = self.identifierCellList[indexPath.row];
    
    if ([identifier isEqualToString:@"ObservationCell"] || [identifier isEqualToString:@"DevelopmentalActionCell"]) {
        [self showCommentsEvaluationPopover];
    }
    if ([identifier isEqualToString:@"DueDataCell"]) {
        [self showDueDataPopover];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        CGRect parent = self.view.frame;
        self.salesTitlePopover.sourceRect = CGRectMake(parent.size.width/2, parent.size.height/2, 10, 10);
    } completion:nil];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

-(void) showOrHideCommentRows: (NSNotification*) notification {
    NSNumber *subMenuAction = [notification.userInfo objectForKey:@"subMenuAction"];
    NSInteger subMenuActionIndex = [subMenuAction intValue];
    NSInteger rowIndex =  [self.raitingTableView indexPathForCell:[notification.userInfo objectForKey:@"cell"]].row;
    
    RaitingTableViewCell *currentCell = [notification.userInfo objectForKey:@"cell"];
    
    switch (subMenuActionIndex) {
        case SubMenuActionShow:
            [self addCellsIdentifierToTable:rowIndex];
            break;
        case SubMenuActionHide:
            [self removeCellsIdentifierToTable:rowIndex];
            break;
        case SubMenuActionNull:
            break;
        case SubMenuActionShowSubRaiting:
            [self addSubRaitingCellsToTable:rowIndex forCell: currentCell];
            break;
        case SubMenuActionHideSubRaiting:
            [self removeSubRaitingCellsToTable:rowIndex];
            break;
        default:
            break;
    }
}


-(void)addSubRaitingCellsToTable:(NSInteger) rowIndex forCell: (RaitingTableViewCell *) cell{
    self.subratingTitles = self.subRaitingLabelList[[self.subLabelList indexOfObject: cell.raitingNameLabel.text]];
    for (int i = 0; i < self.subratingTitles.count; i++) {
        [self.identifierCellList insertObject:@"SubRaitingCell" atIndex:i+1+rowIndex];
    }
    NSIndexPath *newIndexPath = [[NSIndexPath alloc] init];
    NSMutableArray *indexPathArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.subratingTitles.count; i++) {
        newIndexPath = [NSIndexPath indexPathForRow:rowIndex+i+1 inSection:0];
        [indexPathArray addObject:newIndexPath];
    }
    [self.raitingTableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationBottom];
}

-(void)removeSubRaitingCellsToTable:(NSInteger) rowIndex{
    for (int i = 0; i < self.subratingTitles.count; i++) {
        [self.identifierCellList removeObjectAtIndex:rowIndex + 1];
    }
    NSIndexPath *newIndexPath = [[NSIndexPath alloc] init];
    NSMutableArray *indexPathArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.subratingTitles.count; i++) {
        newIndexPath = [NSIndexPath indexPathForRow:rowIndex+i+1 inSection:0];
        [indexPathArray addObject:newIndexPath];
    }
    [self.raitingTableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
}

-(void) addCellsIdentifierToTable:(NSInteger) rowIndex{
    for (int i = 0; i < self.identifierBottomCellList.count; i++) {
        [self.identifierCellList insertObject:self.identifierBottomCellList[i] atIndex:i+1+rowIndex];
    }
    NSIndexPath *newIndexPath = [[NSIndexPath alloc] init];
    NSMutableArray *indexPathArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.identifierBottomCellList.count; i++) {
        newIndexPath = [NSIndexPath indexPathForRow:rowIndex+i+1 inSection:0];
        [indexPathArray addObject:newIndexPath];
    }
    [self.raitingTableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationBottom];
}


-(void)removeCellsIdentifierToTable:(NSInteger) rowIndex{
    for (int i = 0; i < self.identifierBottomCellList.count; i++) {
        [self.identifierCellList removeObjectAtIndex:rowIndex + 1];
    }
    NSIndexPath *newIndexPath = [[NSIndexPath alloc] init];
    NSMutableArray *indexPathArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.identifierBottomCellList.count; i++) {
        newIndexPath = [NSIndexPath indexPathForRow:rowIndex+i+1 inSection:0];
        [indexPathArray addObject:newIndexPath];
    }
    [self.raitingTableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
}

-(void)addRaitingTableCell: (NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self addCellToIdentifierCellList:4];
            break;
        case 1:
            [self addCellToIdentifierCellList:6];
            break;
        case 2:
            [self addCellToIdentifierCellList:2];
            break;
        case 3:
            [self addCellToIdentifierCellList:6];
            break;
        default:
            break;
    }
}

-(void)showInformationPopover:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"InformationPopover"];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popController.delegate = self;
    popController.sourceView = sender;
    popController.sourceRect = CGRectMake(50, 10, 10, 10);
}

-(void)showCommentsEvaluationPopover{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"CommentsEvaluationPopover"];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = 0;
    popController.delegate = self;
    popController.sourceView = self.view;
    
    CGRect parent = self.view.frame;
    popController.sourceRect = CGRectMake(parent.size.width/2, parent.size.height/2, 10, 10);
    self.salesTitlePopover = popController;
}

-(void)showDueDataPopover{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"DueDataPopover"];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    popController.delegate = self;
    popController.sourceView = self.view;
    
    CGRect parent = self.view.frame;
    popController.sourceRect = CGRectMake(parent.size.width/2, parent.size.height/2, 10, 10);
    self.salesTitlePopover = popController;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
