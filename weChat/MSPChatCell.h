//
//  MSPChatCell.h
//  weChat
//
//  Created by 马了个马里奥 on 16/8/8.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSPChatModel;

@protocol MSPChatCellDelegate <NSObject>

@optional
- (void)playVoice:(MSPChatModel *)model indexPath:(NSIndexPath *)indexPath;

@end

@interface MSPChatCell : UITableViewCell

@property (nonatomic, readwrite, strong) MSPChatModel *model;

@property (nonatomic, readwrite, assign) CGFloat preferedHeight;

@property (nonatomic, readwrite, assign) NSIndexPath *indexPath;

@property (nonatomic, readwrite, assign) id <MSPChatCellDelegate> delegate;

- (void)updatePlayingStatusView;

- (void)resetVoiceView;

@end
