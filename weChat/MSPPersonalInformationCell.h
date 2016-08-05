//
//  MSPPersonalInformationCell.h
//  weChat
//
//  Created by 马了个马里奥 on 16/8/5.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSPPersonalInformationModel;

@interface MSPPersonalInformationCell : UITableViewCell

@property (nonatomic,strong) MSPPersonalInformationModel *model;

- (void)setRightIcon:(UIImage *)image size:(CGSize)size;

@end
