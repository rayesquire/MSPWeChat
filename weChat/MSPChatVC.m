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
#import <objc/runtime.h>

static NSString *cellIdentifier = @"mspchatcell";

@interface MSPChatVC () <UITableViewDelegate,UITableViewDataSource,MSPInputBarDelegate>

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) MSPInputBar *inputBar;
@property (nonatomic, readwrite, strong) RLMResults *results;
@property (nonatomic, readwrite, strong) RLMRealm *realm;

@property (nonatomic, readwrite, strong) NSMutableDictionary *cellDictionary;

@end

@implementation MSPChatVC

- (instancetype)init {
    if (self = [super init]) {
        _cellDictionary = [NSMutableDictionary dictionary];
        _realm = [RLMRealm defaultRealm];
        _results = [MSPChatModel objectsInRealm:_realm where:@"posterUid = %d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] integerValue]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MYColor(234, 234, 234);
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[MSPChatCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_tableView];
    
    _inputBar = [[MSPInputBar alloc] init];
    _inputBar.delegate = self;
    [self.view addSubview:_inputBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self registerKeyboardNotification];
}

#pragma mark - UITableView delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _results.count > 15 ? 15 : _results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MSPChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    MSPChatModel *model = _results[indexPath.row];
    cell.model = model;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = cellIdentifier;
    MSPChatCell *cell = [_cellDictionary objectForKey:reuseIdentifier];
    if (!cell) {
        cell = [[MSPChatCell alloc] init];
        [_cellDictionary setObject:cell forKey:reuseIdentifier];
    }
    MSPChatModel *model = _results[indexPath.row];
    cell.model = model;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    cell.bounds = CGRectMake(0, 0, SCREEN_WIDTH, cell.bounds.size.height);
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    return cell.preferedHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

#pragma mark - MSPInputBar delegate
- (BOOL)textView:(UITextView *)textView shouldChangeWithReplacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self sendMessage:textView.text];
        textView.text = @"";
        [_inputBar reset];
    }
    return YES;
}

- (void)sendMessage:(NSString *)string {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *time = [formatter stringFromDate:date];
    MSPChatModel *model = [[MSPChatModel alloc] init];
    model.time = time;
    model.content = string;
    model.posterUid = [[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] integerValue];
    model.accepterUid = self.uid;
    model.isAudio = NO;
    model.audioURL = nil;
    model.audioTimeInterval = 0;
    model.userImage = @"dog.jpg";
    [_realm beginWriteTransaction];
    [MSPChatModel createOrUpdateInRealm:_realm withValue:model];
    [_realm commitWriteTransaction];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_results.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    //        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_mChats.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    //        [self updateRecentContacts];
}

// 搜狗输入法会多次调用键盘通知获取高度
- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self autoMoveKeyBoard:keyboardRect.size.height];
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

- (void)registerKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
