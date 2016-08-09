//
//  MSPChatVC.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/8.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPChatVC.h"
#import "MSPChatCell.h"
#import "MSPChatModel.h"
#import "MSPInputBar.h"

#import "UIView+Extension.h"

#import <Realm.h>
#import <Masonry.h>

#import <AVFoundation/AVFoundation.h>

@interface MSPChatVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) MSPInputBar *inputBar;
@property (nonatomic, readwrite, strong) RLMResults *results;
@property (nonatomic, readwrite, assign) CGFloat keyboardHeight;

@end

@implementation MSPChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MYColor(234, 234, 234);
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.equalTo(self.view.mas_top);
        maker.left.equalTo(self.view.mas_left);
        maker.right.equalTo(self.view.mas_right);
        maker.bottom.equalTo(self.view.mas_bottom);
    }];
    
    _inputBar = [[MSPInputBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    [self.view addSubview:_inputBar];
    
    [self registerKeyboardNotification];
    
}

#pragma mark - UITableView delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"mspchatcell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    
    return cell;
}

- (void)registerKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// 搜狗输入法会多次调用键盘通知获取高度
- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    if (keyboardRect.size.height > _keyboardHeight) {
        _keyboardHeight = keyboardRect.size.height;
//    }
    [self autoMoveKeyBoard:_keyboardHeight];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self autoMoveKeyBoard:0];
}

- (void)autoMoveKeyBoard:(CGFloat)height {
    [UIView animateWithDuration:0.3 animations:^{
        _inputBar.y = SCREEN_HEIGHT - _inputBar.height - height;
        _tableView.y = -height;
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


@end
