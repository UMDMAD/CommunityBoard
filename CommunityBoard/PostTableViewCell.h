//
//  PostTableViewCell.h
//  CommunityBoard
//
//  Created by David LoBosco on 3/16/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *postTitle;
@property (strong, nonatomic) IBOutlet UITextView *textField;

@end
