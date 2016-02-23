//
//  ObservationTableViewCell.m
//  SalesManager
//
//  Created by Student on 2/22/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "ObservationTableViewCell.h"

@interface ObservationTableViewCell ()

@property (strong, nonatomic) NSString *observation;

@end

@implementation ObservationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showEwaluationComment:) name:@"saveComment" object:nil];
}

-(void)showEwaluationComment:(NSNotification*) notification {
    self.observation = [notification.userInfo objectForKey:@"evaluationComment"];
        self.observationLabel.text = self.observation;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
