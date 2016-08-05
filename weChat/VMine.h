//
//  VMine.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/9.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class VMine;
//
//@protocol vMineDelegate <NSObject>
//
//- (void)clickUserImage:(VMine *)cell;
//
//@end

@class MSPPersonalInformationModel;

@interface VMine : UITableViewCell

@property (nonatomic,strong) MSPPersonalInformationModel *model;

- (void)setRightIcon:(UIImage *)image size:(CGSize)size;

//@property (nonatomic,assign) id<vMineDelegate> delegate;

@end
