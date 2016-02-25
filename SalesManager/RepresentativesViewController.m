//
//  RepresentativesViewController.m
//  SalesManager
//
//  Created by Student on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "RepresentativesViewController.h"
#import "RepresentativesViewCell.h"
#import "SalesRepresentative.h"
#import "Container.h"
#import "SpinnerViewController.h"
#import "EvaluationTableViewController.h"
#import "EvaluationHistoryRequest.h"


@interface RepresentativesViewController ()

@property (strong, nonatomic) NSMutableArray *representativesList;
@property (strong, nonatomic) SpinnerViewController *spinnerController;
@property (nonatomic) BOOL isRepresentativExist;
@property (strong, nonatomic) NSMutableArray <EvaluationHistoryRequest *> *evaluationListFromServer;

@end

@implementation RepresentativesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _isRepresentativExist = NO;
}

- (void) setRepresentativesArray:(NSMutableArray *) representatives{
    self.representativesList = representatives;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.representativesList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"RepresentativesCell";
    SalesRepresentative *representative = [self.representativesList objectAtIndex:indexPath.row];
    RepresentativesViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.representativesName.text = representative.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showSpinner];
    SalesRepresentative *currentRepresentative = [_representativesList objectAtIndex:indexPath.row];
    [self downloadEvaluationHistory: currentRepresentative.representativeId];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showRepresentativesHistory"])
    {
        _isRepresentativExist = YES;
        NSIndexPath *indexPath = [self.representativesTableView indexPathForSelectedRow];
        
        if(indexPath){
            [segue.destinationViewController setRepresentativesList:_representativesList:indexPath];
            [segue.destinationViewController setRepresentativExist:_isRepresentativExist];
            [segue.destinationViewController setEvaluationList:_evaluationListFromServer];
        }
    }
}

- (IBAction)logoutButtonPressed:(id)sender {
    [self showSpinner];
    [self logoutUser];
    [self stopSpinner];
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)stopSpinner{
    [self.spinnerController dismissViewControllerAnimated:YES completion:nil];
}

-(void)stopSpinner:(void(^)())dismissed{
    [self.spinnerController dismissViewControllerAnimated:YES completion:^(){dismissed();}];
}

-(void)logoutUser{
    [[Container sharedInstance].restConfiguration logoutUser:^(BOOL isLogoutSuccessful){
        if (isLogoutSuccessful) {
            //DELETE DB
        }
    }];
}

-(void)downloadEvaluationHistory:(NSInteger) representativeURL{
    self.evaluationListFromServer = [[NSMutableArray alloc] init];
    [[Container sharedInstance].restConfiguration getEvaluationHistory:representativeURL :^(NSMutableArray * getEvaluationList){
        self.evaluationListFromServer = getEvaluationList;
        [self stopSpinner:^(){
            [self performSegueWithIdentifier:@"showRepresentativesHistory" sender:self];
        }];
    }];
}



@end
