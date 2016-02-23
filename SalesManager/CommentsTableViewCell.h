//
//  CommentsTableViewCell.h
//  SalesManager
//
//  Created by Student on 2/15/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsTableViewCell : UITableViewCell <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *commentsTextView;

@end
