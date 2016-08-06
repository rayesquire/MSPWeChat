//
//  MSPPersonalInformationModel.h
//  weChat
//
//  Created by 马了个马里奥 on 16/8/5.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>

@interface MSPPersonalInformationModel : RLMObject

@property (nonatomic, readwrite, assign) NSInteger ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *userImage;
@property (nonatomic, readwrite, copy) NSString *sex;
@property (nonatomic, readwrite, copy) NSString *region;
@property (nonatomic, readwrite, copy) NSString *autograph;

@end
