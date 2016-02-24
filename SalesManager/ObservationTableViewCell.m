//
//  ObservationTableViewCell.m
//  SalesManager
//
//  Created by Student on 2/22/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "ObservationTableViewCell.h"

@interface ObservationTableViewCell ()

@property (strong, nonatomic) NSString *observationComment;

@end

@implementation ObservationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showEwaluationComment:) name:@"saveComment" object:nil];
}

-(void)showEwaluationComment:(NSNotification*) notification {
    self.observationComment = [notification.userInfo objectForKey:@"evaluationComment"];
        self.observationLabel.text = self.observationComment;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
