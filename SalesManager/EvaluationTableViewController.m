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
#import "SalesNameTableViewCell.h"
#import "SalesRepresentative.h"
#import "EvaluationHistoryRequest.h"
#import "EvaluationExistCell.h"
#import "Container.h"
#import "Evaluation.h"
#import "SpinnerViewController.h"
#import "CustomerInfoViewController.h"
#import "ReviewViewController.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface EvaluationTableViewController ()

@property (strong, nonatomic) NSMutableArray* identifierCellList;
@property (strong,nonatomic) UIPopoverPresentationController* salesTitlePopover;
@property (strong, nonatomic) SalesTitleViewController *titlePopover;
@property (strong, nonatomic) SalesTitleViewCell *titleCell;
@property (strong, nonatomic) NSMutableArray *representativesList;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (nonatomic) BOOL isRepresentativeExist;
@property (strong, nonatomic) NSMutableArray *evaluationList;
@property (strong, nonatomic) SpinnerViewController *spinnerController;
@property (strong, nonatomic) NSMutableArray *evaluationListFromServer;

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
    [self showCustomerInfoPopover];
}

-(void)showCustomerInfoPopover{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CustomerInfoViewController *controller = (CustomerInfoViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CustomerInfoPopover"];
    
    controller.delegate = self;
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = 0;
    popController.delegate = self;
    popController.sourceView = self.view;
    
    CGRect parent = self.view.frame;
    popController.sourceRect = CGRectMake(parent.size.width/2, parent.size.height/2, 0, 0);
    
    self.salesTitlePopover = popController;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
            EvaluationHistoryRequest *evaluation = [self.evaluationList objectAtIndex:indexPath.row-self.identifierCellList.count+self.evaluationList.count];
            [self changeStatusBackground:((EvaluationExistCell *)cell).statusImage :evaluation];
            [((EvaluationExistCell *) cell).timeLabel setText:[self getEvaluationGeneratedDate:evaluation]];
        }
    }
    return cell;
}

-(void)changeStatusBackground :(UIImageView*)statusImage : (EvaluationHistoryRequest *) evaluation{
    if ([evaluation.status isEqualToString:@"DRAFT"]) {
        UIImage *image = [UIImage imageNamed:@"status-background-draft.png"];
        NSString *statusDraft = @"Draft";
        CGPoint point = CGPointMake(0, 4);
        [statusImage setImage:[EvaluationTableViewController drawText:statusDraft inImage:image atPoint:point rgbValue:0x00A5E3]];
    }else{
        UIImage *image = [UIImage imageNamed:@"status-background-complete.png"];
        NSString *statusDraft = @"Complete";
        CGPoint point = CGPointMake(0, 4);
        [statusImage setImage:[EvaluationTableViewController drawText:statusDraft inImage:image atPoint:point rgbValue:0xFFFFFF]];
    }
}

-(NSString *)getEvaluationGeneratedDate:(EvaluationHistoryRequest *) evaluation{
    NSDate *evaluationTime = [[Container sharedInstance].unixData toDateUTCFormat:evaluation.dateUTC];
    NSString *time = [[Container sharedInstance].unixData toStringUTCFormateDate:evaluationTime];
    NSString *timeLabel = [NSString stringWithFormat:@"(Generated: %@)", time];
    return timeLabel;
}


+(UIImage*) drawText:(NSString*) text inImage:(UIImage*)  image atPoint:(CGPoint) point rgbValue: (int)rgbValueF
{
    UIFont *font = [UIFont systemFontOfSize:13];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: paragraphStyle,
                                  NSForegroundColorAttributeName: UIColorFromRGB(rgbValueF)};
    [text drawInRect:CGRectIntegral(rect) withAttributes:attributes];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
    if ([identifier isEqualToString:@"EvaluationCell"]){
        [self showSpinner];
        EvaluationHistoryRequest *evaluation = [self.evaluationList objectAtIndex:indexPath.row-self.identifierCellList.count+self.evaluationList.count];
        [self downloadEvaluation:evaluation.evaluationId];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showEvaluationReview"])
    {
        [segue.destinationViewController setEvaluationFullList:_evaluationListFromServer];
    }
}


-(void)downloadEvaluation:(NSInteger) evaluationURL{
    self.evaluationListFromServer = [[NSMutableArray alloc] init];
    [[Container sharedInstance].restConfiguration getEvaluation:evaluationURL :^(NSMutableArray *evaluationFullList){
        self.evaluationListFromServer = evaluationFullList;
        [self stopSpinner:^(){
            [self performSegueWithIdentifier:@"showEvaluationReview" sender:self];
        }];
    }];
}

-(void)showSpinner{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Spinner"];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    self.spinnerController = (SpinnerViewController *) controller;
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = 0;
    popController.delegate = self;
    popController.sourceView = self.view;
    
    CGRect parent = self.view.frame;
    popController.sourceRect = CGRectMake(parent.size.width/2, parent.size.height/2, 0, 0);
}

-(void)stopSpinner:(void(^)())dismissed{
    [self.spinnerController dismissViewControllerAnimated:YES completion:^(){dismissed();}];
}

- (void)save:(NSString *)text {
    NSLog(@"SAVE:\n%@", text);
<<<<<<< HEAD
    [self performSegueWithIdentifier:@"showRaitingCategories" sender:self];
=======
>>>>>>> 1d559a733e2b2a999a346c8ca74c724937e9a2e1
}

- (void)skip {
    NSLog(@"Skip");
<<<<<<< HEAD
    [self performSegueWithIdentifier:@"showRaitingCategories" sender:self];
=======
>>>>>>> 1d559a733e2b2a999a346c8ca74c724937e9a2e1
}

@end
