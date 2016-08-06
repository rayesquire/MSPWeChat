//
//  MSPContactModel.h
//  weChat
//
//  Created by 马了个马里奥 on 16/8/6.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import <Realm/Realm.h>

@interface MSPContactModel : RLMObject

@property (nonatomic, readwrite, assign) NSInteger uid;
@property (nonatomic, readwrite, copy) NSString *account;
@property (nonatomic, readwrite, copy) NSString *sex;
@property (nonatomic, readwrite, copy) NSString *remark;
@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readwrite, copy) NSString *userImage;
@property (nonatomic, readwrite, copy) NSString *region;
@property (nonatomic, readwrite, copy) NSString *pinYin;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<MSPContactModel>
RLM_ARRAY_TYPE(MSPContactModel)
