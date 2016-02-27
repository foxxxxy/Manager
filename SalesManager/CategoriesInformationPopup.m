//
//  CategoriesInformationPopup.m
//  SalesManager
//
//  Created by Student on 2/25/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "CategoriesInformationPopup.h"

@interface CategoriesInformationPopup ()

@property (strong, nonatomic) NSMutableArray *popoverInfoList;

@end

@implementation CategoriesInformationPopup

-(void)viewDidLoad{
    self.popoverInfoList = [NSMutableArray arrayWithObjects:
                                        @"Demonstrates throught all actions, both with internal coworkers and external customers and partners, behavior that is aligned with the Edwards` Credo and shared values, based on ethical, legal and sound moral standards.",
                                        @"Demonstrates competence of Edwards` business and financial fundamentals essential to the company`s success. Business Acumen includes:\n ○ Acquisition and maintenance of knowledge related to the medical device industry ,markets, customers, product, clinical acumen, and cultural environment\n ○ Decision making capability where by the individual clearly demonstrates the ability to gather and assess factual information and ideas from others in order to make informed and throghtfull decisions \n ○ The ability to use inductive thinking to solve problems or create ideas.\n ○ Understanding and effectively managing various levels in the organization as well as various external key stakeholders \n ○ The ability to understand opportunities and issues and integrate current information with business and organizational knowledge to comprehend consequences and construct appropriate actions",
                                        @"Demonstrates strong goal orientation in behavior and action,with emphasis on improving areas that affect business success.It relies on the ability to continuously learn and plan, as well as a propensity for seeking, integrating and applying information that results in increased proficiency, the achievement of PMOs, and preferred business outcomes.",
                                        @"Demonstrates the ability to execute the 6 steps in the Selling with Edwards sales process and navigate between the steps appropriately in each unique sales situation.",
                                        nil];
    [self showInformation];
    
    self.preferredContentSize = CGSizeMake(self.view.frame.size.width,  self.informationTextView.contentSize.height);
}

-(void)setButtonIndex:(NSInteger)buttonIndex{
    _buttonIndex = buttonIndex;
}

-(void)showInformation{
    self.informationTextView.text = [self.popoverInfoList objectAtIndex:self.buttonIndex];
}

@end
