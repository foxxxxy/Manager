//
//  ResetPasswordViewController.m
//  SalesManager
//
//  Created by Student on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "Container.h"
#import "LoginRequest.h"
#import "AlertWindow.h"

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
    self.loginRequest = [[LoginRequest alloc] init];
    [[Container sharedInstance].restConfiguration configureRestKit];
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
                [AlertWindow showInfoErrorWindow:self info:@"Password reset successfully. Reset instructions sent to your email"];
                
            }else if(!isLoginSuccessful){
                [AlertWindow showInfoErrorWindow:self info:@"Invalid email adress"];
            }
        }];
    }else{
        [AlertWindow showInfoErrorWindow:self info:@"Invalid email adress"];
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
    
    if (matchRange.location != NSNotFound)
        didValidate = YES;
    
    return didValidate;
}

@end
