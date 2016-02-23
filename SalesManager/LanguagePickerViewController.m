//
//  PickerViewController.m
//  SalesManager
//
//  Created by Student on 2/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "LanguagePickerViewController.h"
#import "StartViewController.h"

@interface LanguagePickerViewController ()


@property (strong, nonatomic) NSArray *pickerData;

@end

@implementation LanguagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pickerData = @[@"English", @"中文"];
    self.languagePicker.delegate = self;
    self.languagePicker.dataSource = self;
    
    self.preferredContentSize = CGSizeMake(380, 275);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closePopoverButton:(id)sender {
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
        default:
            break;
    }
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return NO;
}


@end
