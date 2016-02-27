//
//  ViewController.m
//  SalesManager
//
//  Created by Student on 2/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "StartViewController.h"
#import "Container.h"
#import "LoginRequest.h"
#import "RepresentativesViewController.h"
#import "LanguagePickerViewController.h"
#import "SpinnerViewController.h"
#import "AlertWindow.h"

@interface StartViewController ()

@property (strong,nonatomic) UIPopoverPresentationController* passwordRecoveryPopover;
@property (strong,nonatomic) LoginRequest* loginRequest;
@property (strong, nonatomic) NSMutableArray *representativesListFromServer;
@property (strong, nonatomic) LanguagePickerViewController *languagePopover;
@property (strong, nonatomic) SpinnerViewController *spinnerController;

@property (nonatomic) BOOL isSegueAccess;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addTapRecognizerForgotPasswordLabel];
    
    self.loginRequest = [[LoginRequest alloc] init];
    [[Container sharedInstance].restConfiguration configureRestKit];
}

-(void)addTapRecognizerForgotPasswordLabel{
    self.forgotPasswordLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetPassword)];
    [self.forgotPasswordLabel addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.loginTextField.text = @"adammanager@company.com";
    self.passwordTextField.text = @"123";
}

- (IBAction)loginButtonPressed:(id)sender {
    self.loginRequest.email = self.loginTextField.text;
    self.loginRequest.password = self.passwordTextField.text;
    [self showSpinner];
    [self checkSegueАvailability];
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

-(void)checkSegueАvailability{
    [[Container sharedInstance].restConfiguration loginEmail:self.loginRequest.email password:self.loginRequest.password access:^(BOOL isLoginSuccessful){
        if (isLoginSuccessful) {
            self.isSegueAccess = YES;
            [self downloadRepresentative];
        }else if(!isLoginSuccessful){
            self.isSegueAccess = NO;
            [self stopSpinner:^(){}];
            [AlertWindow showInfoErrorWindow:self info:@"Invalid username or password"];
        }
    }];
}

- (IBAction)chooseLanguage:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"LanguagePopover"];
    
    self.languagePopover = (LanguagePickerViewController *)controller;
    ((LanguagePickerViewController *)controller).delegatePopover = self;
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popController.delegate = self;
    popController.sourceView = sender;
    popController.sourceRect = CGRectMake(50, 10, 10, 10);
    
}

-(void)downloadRepresentative{
    self.representativesListFromServer = [[NSMutableArray alloc] init];
    [[Container sharedInstance].restConfiguration getRepresentative:^(NSMutableArray* gotRepresentativesList){
        self.representativesListFromServer = gotRepresentativesList;
        [self stopSpinner:^(){
            [self performSegueWithIdentifier:@"showRepresentatives" sender:self];
        }];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showRepresentatives"]) {
        [segue.destinationViewController setRepresentativesArray:_representativesListFromServer];
    }
}

-(void)resetPassword{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"ResetPasswordPopover"];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = 0;
    popController.delegate = self;
    popController.sourceView = self.view;
    
    CGRect parent = self.view.frame;
    popController.sourceRect = CGRectMake(parent.size.width/2, parent.size.height/2, 0, 0);
    
    self.passwordRecoveryPopover = popController;
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return NO;
}

- (void)resizeLogo{
    if(self.view.frame.size.height<self.view.frame.size.width)
        _logoImageView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    else
        _logoImageView.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        CGRect parent = self.view.frame;
        self.passwordRecoveryPopover.sourceRect = CGRectMake(parent.size.width/2, parent.size.height/2, 0, 0);
        
    } completion:nil];
    [self resizeLogo];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

-(void)popoverItemSelected:(NSString *)selectedItem{
    [self.languageChangeButton setTitle:selectedItem forState:UIControlStateNormal];
}
@end
