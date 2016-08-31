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
#import "MSPVoiceMessageProgressView.h"

#import "UIView+Extension.h"

#import <Realm.h>
#import <Masonry.h>

#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>

static NSString *cellIdentifier = @"mspchatcell";

@interface MSPChatVC () <UITableViewDelegate,
                         UITableViewDataSource,
                         AVAudioRecorderDelegate,
                         MSPInputBarDelegate,
                         MSPChatCellDelegate>

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) MSPInputBar *inputBar;
@property (nonatomic, readwrite, strong) RLMResults *results;
@property (nonatomic, readwrite, strong) RLMRealm *realm;
@property (nonatomic, readwrite, strong) NSMutableDictionary *cellDictionary;
@property (nonatomic, readwrite, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, readwrite, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, readwrite, strong) NSTimer *timer;    //录音声波监控
@property (nonatomic, readwrite, strong) NSDate *startDate;  // 语音开始的时间
@property (nonatomic, readwrite, strong) MSPVoiceMessageProgressView *voiceProgressView;   // 灰色提示框
@property (nonatomic, readwrite, assign) NSTimeInterval voiceInterval; // 语音时长
@property (nonatomic, readwrite, strong) NSString *urlString;  // 语音urlstring
@property (nonatomic, readwrite, strong) MSPChatCell *currentCell;

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
    self.title = _model.remark;
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[MSPChatCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [_tableView setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:_tableView];
    
    _inputBar = [[MSPInputBar alloc] init];
    _inputBar.delegate = self;
    [self.view addSubview:_inputBar];
    
    _voiceProgressView = [[MSPVoiceMessageProgressView alloc] init];
    [self.view addSubview:_voiceProgressView];
    [_voiceProgressView setHidden:YES];
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
    cell.indexPath = indexPath;
    cell.userInteractionEnabled = NO;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

#pragma mark - MSPChatCell delegate
- (void)playVoice:(MSPChatModel *)model indexPath:(NSIndexPath *)indexPath{
    _urlString = model.audioURL;
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
    }
    _currentCell = [_tableView cellForRowAtIndexPath:indexPath];
    [_currentCell updatePlayingStatusView];
}

#pragma mark - 发送文字消息
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

#pragma mark - 发送语音消息
- (void)sendAudioMessage:(double)timeInterval {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *time = [formatter stringFromDate:date];
    MSPChatModel *model = [[MSPChatModel alloc] init];
    model.audioTimeInterval = _voiceInterval;
    model.isAudio = YES;
    model.time = time;
    model.audioURL = [self getSavePath];
    model.posterUid = [[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] integerValue];
    model.content = nil;
    model.userImage = @"dog.jpg";
    [_realm beginWriteTransaction];
    [MSPChatModel createOrUpdateInRealm:_realm withValue:model];
    [_realm commitWriteTransaction];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_results.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
//    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_mChats.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

- (void)sendAudioMessageAnimation {
    // insert a temporary shining voice message to tableview
}

#pragma mark - Keyboard
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

#pragma mark - MSPInputBarDelegate
- (void)voiceTouchUpInside {

}

- (void)voiceHoldOnTouchDown {
    _startDate = [NSDate date];   // record current date
    //    _inputBar.voiceHoldOn.selected = YES;
    [_voiceProgressView updateStatus:MSPVoiceViewRecordBegin value:0];
    [self recordVoice];   // record
    [self performSelector:@selector(sendAudioMessageAnimation) withObject:nil afterDelay:0.7];  // insert audio record to tableview
}

- (void)voiceHoldOnTouchUpInside {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordVoice) object:nil];
    _voiceInterval = [[NSDate date] timeIntervalSinceDate:_startDate];
    [_voiceProgressView updateStatus:MSPVoiceViewRecordReleaseInside value:_voiceInterval];
    [_audioRecorder stop];
    [_timer invalidate];
    _timer.fireDate = [NSDate distantFuture];
    
    if (_voiceInterval < 1) [self performSelector:@selector(cancel) withObject:nil afterDelay:0.5];
    else [self sendAudioMessage:_voiceInterval];
    
    _voiceInterval = 0;
    _audioRecorder = nil;
    _audioPlayer = nil;
}

- (void)voiceHoldOnTouchUpOutside {
    [_voiceProgressView updateStatus:MSPVoiceViewRecordReleaseOutside value:0];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordVoice) object:nil];
    [self.audioRecorder stop];
    _timer.fireDate = [NSDate distantFuture];
    [_timer invalidate];
    //    _inputBar.voiceHoldOn.selected = NO;
    _voiceInterval = 0;
    _audioRecorder = nil;
}

- (void)voiceHoldOnTouchDragInside {
    [_voiceProgressView updateStatus:MSPVoiceViewRecordHoldInside value:0];
}

- (void)voiceHoldOnTouchDragOutside {
    [_voiceProgressView updateStatus:MSPVoiceViewRecordHoldOutside value:0];
}

#pragma mark - Audio
- (void)playAudio {
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
        // change view
        [_currentCell updatePlayingStatusView];
    }
}

- (void)cancel {
    //    _inputBar.voiceHoldOn.selected = NO;
    [_voiceProgressView setHidden:YES];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [_currentCell resetVoiceView];
}

/**
 *  录音声波状态设置
 */
- (void)audioPowerChange {
    [_audioRecorder updateMeters];//更新测量值
    CGFloat power= [_audioRecorder averagePowerForChannel:0] + 160; //取得第一个通道的音频，注意音频强度范围时-160到0
    [_voiceProgressView updateProgress:power];
}

/**
 *  设置音频会话
 */
- (void)setAudioSession {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&setCategoryError];
    //    [audioSession setActive:YES error:nil];
    if (setCategoryError) {
        NSLog(@"%@",[setCategoryError description]);
    }
}

/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
- (NSString *)getSavePath {
    NSString *urlStr = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *videoName = [NSString stringWithFormat:@"%@.caf",[formatter stringFromDate:_startDate]];
    urlStr = [urlStr stringByAppendingPathComponent:videoName];
    _urlString = urlStr;
    return urlStr;
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
- (NSDictionary *)getAudioSetting {
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
- (AVAudioRecorder *)audioRecorder {
    if (!_audioRecorder) {
        [self setAudioSession];
        //创建录音文件保存路径
        NSURL *url = [NSURL URLWithString:[self getSavePath]];
        //创建录音格式设置
        NSDictionary *setting = [self getAudioSetting];
        //创建录音机
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
- (AVAudioPlayer *)audioPlayer {
    if (!_audioPlayer) {
        NSURL *url = [NSURL URLWithString:_urlString];
        NSError *error;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops = 0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    else {
        NSError *error;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:_urlString] error:&error];
    }
    return _audioPlayer;
}

/**
 *  录音
 */
- (void)recordVoice {
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
        _timer.fireDate=[NSDate distantPast];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
