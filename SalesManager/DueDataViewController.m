//
//  DueDataViewController.m
//  SalesManager
//
//  Created by Student on 2/16/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "DueDataViewController.h"

@interface DueDataViewController ()

@end

@implementation DueDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.preferredContentSize = CGSizeMake(380, 275);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
