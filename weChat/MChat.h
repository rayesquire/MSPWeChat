//
//  MChat.h
//  weChat
//
//  Created by 尾巴超大号 on 15/10/14.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MChat : NSObject

@property (nonatomic,copy) NSString *userImage;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) NSInteger from;
@property (nonatomic,assign) NSInteger to;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *audiourl;
@property (nonatomic,copy) NSString *audioInterval;

- (MChat *)initWithDictionary:(NSMutableDictionary *)dic;

- (MChat *)initWithTime:(NSString *)time content:(NSString *)content from:(NSInteger)fromid to:(NSInteger)toid audiourl:(NSString *)url audioInterval:(NSString *)audioInterval;

+ (MChat *)mChatWithDictionary:(NSMutableDictionary *)dic;
@end
