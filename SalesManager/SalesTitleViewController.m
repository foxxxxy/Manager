//
//  SalesTitleViewController.m
//  SalesManager
//
//  Created by Student on 2/9/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "SalesTitleViewController.h"

@interface SalesTitleViewController ()

@property (strong, nonatomic) NSArray *pickerData;

@end

@implementation SalesTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pickerData = @[@"Sales Rep", @"Senior Sales Rep", @"Key Account Manager"];
    
    self.salesTitelPicker.delegate = self;
    self.salesTitelPicker.dataSource = self;
    
    self.preferredContentSize = CGSizeMake(380, 275);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeSalesTitlePopover:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (row) {
        case 0:
            [self.delegatePopover popoverItemSelected: [_pickerData objectAtIndex:row]];
            break;
        case 1:
            [self.delegatePopover popoverItemSelected: [_pickerData objectAtIndex:row]];
            break;
        case 2:
            [self.delegatePopover popoverItemSelected: [_pickerData objectAtIndex:row]];
            break;
        default:
            break;
    }
}

@end
