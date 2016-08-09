//
//  CChat.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/14.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "CChat.h"

#import "MSPInputBar.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Extension.h"
#import "RecordVoice.h"
#import "sqlite3.h"
#import "AppDelegate.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define MYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define DATABASENAME @"chatRecord.sqlite"
#define TABLENAME @"chatRecord"
@interface CChat () <UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,AVAudioRecorderDelegate>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) NSInteger usd;   // id
@property (nonatomic,strong) AVAudioRecorder *audioRecorder;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;
@property (nonatomic,strong) NSTimer *timer;    //录音声波监控
@property (nonatomic,copy) NSMutableArray *mChats; // 聊天记录数组
@property (nonatomic,copy) NSMutableArray *heights;  // 高度数组
@property (nonatomic,strong) NSDate *startDate;  // 语音开始的时间
@property (nonatomic,strong) RecordVoice *recordVoice;   // 灰色提示框
@property (nonatomic,assign) NSTimeInterval voiceInterval; // 语音时长
@property (nonatomic,strong) NSString *urlString;  // 语音urlstring
@property (nonatomic,strong)NSString *userImage;  // 对方头像
@property (nonatomic) sqlite3 *database;
@property (nonatomic,strong) NSString *remark; // remark
@end

@implementation CChat
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = MYColor(234, 234, 234);
    _mChats = [[NSMutableArray alloc]init];
    _heights = [[NSMutableArray alloc]init];
    [self registerNotification];
    [self createTableAndSearch];
    [self layoutTableView];
    [self layoutRecordVoiceAlertView];
//    [self layoutInputBar];
//    [self addBackItem];
}

#pragma mark - layout
- (void)layoutRecordVoiceAlertView
{
    _recordVoice = [[RecordVoice alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 4, self.view.frame.size.height / 2 - self.view.frame.size.width / 4, self.view.frame.size.width / 2, self.view.frame.size.width / 2)];
    [self.view addSubview:_recordVoice];
    [_recordVoice setHidden:YES];
}

- (void)layoutTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setBackgroundColor:MYColor(234, 234, 234)];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.cancelsTouchesInView = NO;
    [_tableView addGestureRecognizer:tapGesture];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 49, 0);
    _tableView.contentInset = insets;
    [self.view addSubview:_tableView];
//    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_mChats.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

#pragma mark - hide keyboard
// 点击空白隐藏键盘
//- (void)hideKeyboard
//{
//    [self.inputBar.input resignFirstResponder];
//}
//
//- (void)layoutInputBar
//{
//    self.inputBar = [[InputBar alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - 49, SCREENWIDTH, 49)];
//    self.inputBar.backgroundColor = MYColor(245, 245, 247);
//    self.inputBar.input.delegate = self;
//    self.inputBar.delegate = self;
//    [self.view addSubview:self.inputBar];
//}
#warning back issue
//- (void)addBackItem
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"微信" forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
//    [button setFrame:CGRectMake(0, 0, 80, 30)];
//    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
//    self.navigationItem.leftBarButtonItem = item;
//}
//
//- (void)back
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

#pragma mark - ID
- (void)chatViewWithuid:(NSInteger)uid remark:(NSString *)remark
{
    _usd = uid;
    _remark = remark;
}

#pragma mark - sqlite3 exec
- (void)execSql:(NSString *)sql
{
    char *error;
    if (sqlite3_exec(_database, [sql UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        sqlite3_close(_database);
        NSLog(@"error:%s",error);
    }
}

#pragma mark 加载数据
- (void)createTableAndSearch
{
    NSString *database_path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:DATABASENAME];
    if (sqlite3_open([database_path UTF8String], &_database) != SQLITE_OK) {
        sqlite3_close(_database);
        NSLog(@"database open failed");
    }

    [self searchData];
}

- (void)searchData
{
    [self updateRecentContacts];
}

#pragma mark - 根据最后一条消息更新最近联系人列表
- (void)updateRecentContacts
{
  
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mChats count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    VChat *cell = _heights[indexPath.row];
//    cell.mChat = _mChats[indexPath.row];
    return   5;
}

#warning 点击text体播放语音而不是cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    VChat *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (![cell.time.text isEqualToString:@"no"]) {
//        _urlString = cell.audiourl;
//        [self playAudio];
//    }
}

- (void)longTouch
{
    NSLog(@"long touch.....");
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 20;
//}
//- (void)updateRecentChatList:(NSString *)text uid:(NSInteger)uid time:(NSString *)time
//{
//    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS recentContacts (t TEXT,content TEXT,fromid INTEGER,toid INTEGER)";
//    [self execSql:sqlCreateTable];
//}

#pragma mark -  CWeChat delegate
- (void)passIDAndUserImage:(NSInteger)ID userImage:(NSString *)image
{
    _usd = ID;
    _userImage = image;
}

#pragma mark - calculate height of TextView
- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat width = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, width), newSize.height + 3.5);
    float height = newFrame.size.height - textView.frame.size.height;
    if (height) {
        textView.contentInset = UIEdgeInsetsMake(0, 0, -3, 0);
        newFrame.size = CGSizeMake(fmaxf(newSize.width, width), newSize.height);
        height -= 3.5;
    }
    if (newFrame.size.height > 120) {
//        self.inputBar.input.scrollEnabled = YES;
    }else {
//        self.inputBar.input.scrollEnabled = NO;
        [UIView animateWithDuration:0.3 animations:^{
            textView.frame = newFrame;
//            [self.inputBar setFrame:CGRectMake(0, self.inputBar.frame.origin.y - height, self.inputBar.frame.size.width, self.inputBar.frame.size.height + height )];
//            self.inputBar.voice.origin = CGPointMake(self.inputBar.voice.origin.x, self.inputBar.voice.origin.y + height);
//            self.inputBar.face.origin = CGPointMake(SCREENWIDTH - 66 - 5, self.inputBar.face.origin.y + height);
//            self.inputBar.add.origin = CGPointMake(SCREENWIDTH - 2 - 33, self.inputBar.add.origin.y + height);
        }];
    }
//    self.inputBar.currentFrame = self.inputBar.frame;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
//    [_inputBar.voice setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
//    [_inputBar.voice setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateSelected];
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardRect.size.height;
//    if (height == 0){
//        height = 253;
//    }
//    [UIView animateWithDuration:0.3
//                          delay:0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         [_inputBar setFrame:CGRectMake(0, SCREENHEIGHT - height - _inputBar.originalFrame.size.height, _inputBar.originalFrame.size.width, _inputBar.originalFrame.size.height)];
//                     } completion:nil];
//
    [self autoMovekeyBoard:height];
//    // view up
//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(viewUp:) object:nil];
//    [thread start];
}

-(void)autoMovekeyBoard:(float)h
{
//    _inputBar.frame = CGRectMake(0.0f, (float)(SCREENHEIGHT- h - _inputBar.originalFrame.size.height), SCREENWIDTH, _inputBar.originalFrame.size.height);
//    _tableView.frame = CGRectMake(0.0f, 0, SCREENWIDTH,(float)(SCREENHEIGHT- h - _inputBar.originalFrame.size.height));
}

- (void)viewUp:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.y = -253;
    }];
    [sender invalidate];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
//    [UIView animateWithDuration:0.3
//                          delay:0
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         [_inputBar setFrame:CGRectMake(0, SCREENHEIGHT - _inputBar.currentFrame.size.height, SCREENWIDTH, _inputBar.currentFrame.size.height)];
//                     } completion:nil];
    [self autoMovekeyBoard:0];
    // view down
//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(viewDown:) object:nil];
//    [thread start];
}

- (void)viewDown:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.y = 0;
    }];
    [sender invalidate];
}

#pragma mark - 发送消息
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYYMMddHHmmss"];
        NSString *time = [formatter stringFromDate:date];
        NSString *add = [NSString stringWithFormat:@"INSERT INTO '%@' (time,content,fromid,toid,audiourl,audiointerval) VALUES('%@','%@',%d,%d,'%@','%@')",TABLENAME,time,textView.text,1,(int)_usd,@"no",@"no"];
        [self execSql:add];
//        MChat *tmp = [[MChat alloc]initWithTime:time content:textView.text from:1 to:_usd audiourl:@"no" audioInterval:@"no"];
//        // update datasource
//        [_mChats addObject:tmp];
//        VChat *cell = [[VChat alloc]init];
//        [_heights addObject:cell];
//       //////////////////////////////////
//        [_tableView beginUpdates];
//        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_mChats.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
//        [_tableView endUpdates];
//        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_mChats.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//        textView.text = @"";
//        [self updateInputbarFrame];
//        [self updateRecentContacts];
        return NO;
    }
    return YES;
}

#pragma mark - updateInputbarFrame
- (void)updateInputbarFrame
{
//    float height = _inputBar.frame.size.height - 49;
//    _inputBar.frame = CGRectMake(0, _inputBar.frame.origin.y + height,SCREENWIDTH, 49);
//    _inputBar.input.frame = CGRectMake(33 + 5, 5, SCREENWIDTH - 15 - 99, 39);
//    _inputBar.face.origin = CGPointMake(_inputBar.face.origin.x, 8);
//    _inputBar.add.origin = CGPointMake(_inputBar.add.origin.x, 8);
//    _inputBar.voice.origin = CGPointMake(_inputBar.voice.origin.x, 8);
//    self.inputBar.currentFrame = self.inputBar.frame;
}

#pragma mark - notification alloc and dealloc
- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



#pragma mark - 发送语音消息
- (void)sendAudioMessage:(double)timeInterval
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *time = [formatter stringFromDate:date];
    NSString *timeinterval = [NSString stringWithFormat:@"%lf",timeInterval];
    NSString *add = [NSString stringWithFormat:@"INSERT INTO '%@' (time,content,fromid,toid,audiourl,audiointerval) VALUES('%@','%@',%d,%d,'%@','%@')",TABLENAME,time,@"    ",1,(int)_usd,[self getSavePath],timeinterval];
    [self execSql:add];
//    MChat *tmp = [[MChat alloc]initWithTime:time content:@"    " from:1 to:_usd audiourl:[self getSavePath] audioInterval:timeinterval];
    // update datasource
//    [_mChats addObject:tmp];
//    VChat *cell = [[VChat alloc]init];
//    [_heights addObject:cell];
    //////////////////////////////////
    [_tableView beginUpdates];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_mChats.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [_tableView endUpdates];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_mChats.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}

- (void)playAudio
{
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
    }
}

- (void)cancel
{
//    _inputBar.voiceHoldOn.selected = NO;
    [_recordVoice setHidden:YES];
}

#pragma mark - InputBarDelegate
- (void)voiceHoldOnTouchDown
{
    _startDate = [NSDate date];   // record current date
//    _inputBar.voiceHoldOn.selected = YES;
    [_recordVoice setHidden:NO];
    [_recordVoice.centerImage setHidden:YES];
    [_recordVoice.leftImage setHidden:NO];
    [_recordVoice.rightImage setHidden:NO];
    [_recordVoice setLabelFrame:@"手指上滑，取消发送" font:14];
    [_recordVoice.label setBackgroundColor:[UIColor clearColor]];
    [self tape];   // record
    [self performSelector:@selector(sendAudioMessageAnimation) withObject:nil afterDelay:0.7];  // insert audio record to tableview
}

- (void)voiceTouchUpInside
{
//    if(!self.inputBar.keyboard){
//        self.inputBar.keyboard = YES;
//        [self.inputBar.voice setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateNormal];
//        [self.inputBar.voice setImage:[UIImage imageNamed:@"ToolViewKeyboardHL"] forState:UIControlStateSelected];
//        [self.inputBar setFrame:CGRectMake(0, SCREENHEIGHT - 49, SCREENWIDTH, 49)];
//        [self.inputBar.input resignFirstResponder];
//        [self.inputBar.voiceHoldOn setHidden:NO];
//        [self.inputBar.input setHidden:YES];
//    }else {
//        self.inputBar.keyboard = NO;
//        [self.inputBar.voice setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
//        [self.inputBar.voice setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateSelected];
//        [self.inputBar.input becomeFirstResponder];
//        [self.inputBar.voiceHoldOn setHidden:YES];
//        [self.inputBar.input setHidden:NO];
//    }
}

- (void)voiceHoldOnTouchUpInside
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(tape) object:nil];
    _voiceInterval = [[NSDate date] timeIntervalSinceDate:_startDate];
    [_audioRecorder stop];   // record stop
    [_timer invalidate];
    _timer.fireDate=[NSDate distantFuture];
    if (_voiceInterval < 1) {
        [_recordVoice.leftImage setHidden:YES];
        [_recordVoice.rightImage setHidden:YES];
        [_recordVoice.centerImage setImage:[UIImage imageNamed:@"MessageTooShort"]];
        [_recordVoice.centerImage setHidden:NO];
        [_recordVoice setLabelFrame:@"说话时间太短" font:14];
        [_recordVoice.label setBackgroundColor:[UIColor clearColor]];
        [self performSelector:@selector(cancel) withObject:nil afterDelay:0.5];
        _voiceInterval = 0;
    }else {
        [_recordVoice setHidden:YES];
//        _inputBar.voiceHoldOn.selected = NO;
        // send with voice interval
        [self sendAudioMessage:_voiceInterval];
        _voiceInterval = 0;   // clear
    }
    _audioRecorder = nil;
    _audioPlayer = nil;
}

- (void)voiceHoldOnTouchUpOutside
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(tape) object:nil];
    [self.audioRecorder stop];
    _timer.fireDate=[NSDate distantFuture];
    [_timer invalidate];
    [_recordVoice setHidden:YES];
//    _inputBar.voiceHoldOn.selected = NO;
    _voiceInterval = 0;
    _audioRecorder = nil;
}

- (void)voiceHoldOnTouchDragInside
{
    [self.recordVoice.leftImage setHidden:NO];
    [self.recordVoice.rightImage setHidden:NO];
    [self.recordVoice.centerImage setHidden:YES];
    [self.recordVoice.label setText:@"手指上滑，取消发送"];
    [self.recordVoice.label setBackgroundColor:[UIColor clearColor]];
}

- (void)voiceHoldOnTouchDragOutside
{
    [self.recordVoice.leftImage setHidden:YES];
    [self.recordVoice.rightImage setHidden:YES];
    [self.recordVoice.centerImage setHidden:NO];
    [self.recordVoice.label setText:@"松开手指，取消发送"];
    [self.recordVoice.label setBackgroundColor:MYColor(200, 0, 0)];
}
#warning sendAudioMessageAnimation
- (void)sendAudioMessageAnimation
{
    // insert audio record to tableview
}

// record
- (void)tape
{
    if (![self.audioRecorder isRecording])
    {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
        self.timer.fireDate=[NSDate distantPast];
    }
}

#pragma mark - audio
/**
 *  录音声波状态设置
 */
-(void)audioPowerChange
{
    [_audioRecorder updateMeters];//更新测量值
    float power= [_audioRecorder averagePowerForChannel:0] + 160;//取得第一个通道的音频，注意音频强度范围时-160到0
    NSLog(@"%f",power);
    if (power <= 95) {
        [_recordVoice.rightImage setImage:[UIImage imageNamed:@"RecordingSignal001"]];
    }else if (power <= 100) {
        [_recordVoice.rightImage setImage:[UIImage imageNamed:@"RecordingSignal002"]];
    }else if (power <= 105) {
        [_recordVoice.rightImage setImage:[UIImage imageNamed:@"RecordingSignal003"]];
    }else if (power <= 110) {
        [_recordVoice.rightImage setImage:[UIImage imageNamed:@"RecordingSignal004"]];
    }else if (power <= 115) {
        [_recordVoice.rightImage setImage:[UIImage imageNamed:@"RecordingSignal005"]];
    }else if (power <= 120) {
        [_recordVoice.rightImage setImage:[UIImage imageNamed:@"RecordingSignal006"]];
    }else if (power <= 125) {
        [_recordVoice.rightImage setImage:[UIImage imageNamed:@"RecordingSignal007"]];
    }else {
        [_recordVoice.rightImage setImage:[UIImage imageNamed:@"RecordingSignal008"]];
    }
}
/**
 *  设置音频会话
 */
- (void)setAudioSession
{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
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
 - (NSString *)getSavePath
{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
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
 - (NSDictionary *)getAudioSetting
{
     NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
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
 - (AVAudioRecorder *)audioRecorder
{
    if (!_audioRecorder) {
        [self setAudioSession];
        //创建录音文件保存路径
        NSURL *url = [NSURL URLWithString:[self getSavePath]];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error = nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
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
 - (AVAudioPlayer *)audioPlayer
{
    if (!_audioPlayer) {
        NSURL *url = [NSURL URLWithString:_urlString];
        NSError *error;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }else {
        NSError *error;
        _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:_urlString] error:&error];
    }
    return _audioPlayer;
}

@end
