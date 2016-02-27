//
//  CommentsTableViewCell.m
//  SalesManager
//
//  Created by Student on 2/15/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "CommentsTableViewCell.h"

#define PLACEHOLDER_MESSAGE @"Type your comment"

@interface CommentsTableViewCell ()

@property (strong, nonatomic) UILabel *placeholderLabel;

@end

@implementation CommentsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self addPlaceholderLabelToTextview];
}

-(void)addPlaceholderLabelToTextview{
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0,self.commentsTextView.frame.size.width - 10.0, 34.0)];
    
    [_placeholderLabel setText:PLACEHOLDER_MESSAGE];
    [_placeholderLabel setBackgroundColor:[UIColor clearColor]];
    [_placeholderLabel setTextColor:[UIColor lightGrayColor]];
    
    self.commentsTextView.delegate = self;
    
    [self.commentsTextView addSubview:_placeholderLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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


@end
