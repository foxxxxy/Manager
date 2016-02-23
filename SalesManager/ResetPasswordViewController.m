//
//  ResetPasswordViewController.m
//  SalesManager
//
//  Created by Student on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "Container.h"

#define  REGULAREXPRESSIONPATTERN @"\\w+@\\w+.\\w+"

@interface ResetPasswordViewController ()

@property (strong, nonatomic) NSString *email;
@property (nonatomic) BOOL isEmailValueValid;
@property (strong,nonatomic) LoginRequest* loginRequest;

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.preferredContentSize = CGSizeMake(400, 220);
    
    [[Container sharedInstance].restConfiguration configureRestKit];
    
    self.loginRequest = [[LoginRequest alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelPopoverButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)resetPasswordButtonPressed:(id)sender {
    self.email = self.emailTextView.text;
    _isEmailValueValid = [self validateString:self.email withPattern:REGULAREXPRESSIONPATTERN];
    if (_isEmailValueValid) {
        [[Container sharedInstance].restConfiguration forgotPassword:self.email access:^(BOOL isLoginSuccessful){
            if (isLoginSuccessful) {
                [self dismissViewControllerAnimated:YES completion:nil];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"Password reset successfully. Reset instructions sent to your email"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
            }else if(!isLoginSuccessful){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"Invalid email adress"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Invalid email adress"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    
    BOOL didValidate = NO;
    
    // Did we find a matching range
    if (matchRange.location != NSNotFound)
        didValidate = YES;
    
    return didValidate;
}

@end
