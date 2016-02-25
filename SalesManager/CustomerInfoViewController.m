//
//  CustomerInfoViewController.m
//  SalesManager
//
//  Created by Student on 2/10/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "CustomerInfoViewController.h"

#define PLACEHOLDER_MESSAGE @"Customer Info"

@interface CustomerInfoViewController ()

@property (strong, nonatomic) UILabel *placeholderLabel;

@end

@implementation CustomerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.customerInfoTextView.frame.size.height - 1, self.customerInfoTextView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor redColor].CGColor;
    [self.customerInfoTextView.layer addSublayer:bottomBorder];
    
    self.preferredContentSize = CGSizeMake(550, 550);
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0,self.customerInfoTextView.frame.size.width - 10.0, 34.0)];
    
    
    [_placeholderLabel setText:PLACEHOLDER_MESSAGE];
    [_placeholderLabel setBackgroundColor:[UIColor clearColor]];
    [_placeholderLabel setTextColor:[UIColor lightGrayColor]];
    self.customerInfoTextView.delegate = self;
    
    [self.customerInfoTextView addSubview:_placeholderLabel];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (![textView hasText]) {
        _placeholderLabel.hidden = NO;
    }
}

- (void) textViewDidChange:(UITextView *)textView
{
    if(![textView hasText]) {
        _placeholderLabel.hidden = NO;
    }
    else{
        _placeholderLabel.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)skipButtonPressed:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(skip)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate skip];
        
    }
}

- (IBAction)saveButtonPressed:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(save:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate save:_customerInfoTextView.text];
    }
}
@end
