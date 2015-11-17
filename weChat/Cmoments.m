//
//  Cmoments.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/6.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "Cmoments.h"
#import "AVFoundation/AVFoundation.h"
#define kURL @"http://192.168.1.208/ViewStatus.aspx"

@interface Cmoments () <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VmomentsDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSMutableArray *moments;
@property (nonatomic,copy) NSMutableArray *momentsCells;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,assign) NSIndexPath *idx;
@property (nonatomic,strong) UITapGestureRecognizer *tapGesture;

@end

@implementation Cmoments

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    UIBarButtonItem *camera = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_Camera"] style:UIBarButtonItemStyleDone target:self action:@selector(camera)];
    self.navigationItem.rightBarButtonItem = camera;
    

    [self initData];
}

- (void)layoutTableView
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor grayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIImageView *cover = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gjqt.jpg"]];
    [cover setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2 - 64)];
    [_tableView setTableHeaderView:cover];
}

#pragma mark 加载数据
- (void)loadData:(NSData *)data
{
    _moments = [[NSMutableArray alloc]init];
    _momentsCells = [[NSMutableArray alloc]init];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSArray *array = (NSArray *)dic[@"statuses"];
    [array enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop){
        Mmoments *moment = [[Mmoments alloc]init];
        [moment setValuesForKeysWithDictionary:obj];
        
        Vmoments *cell = [[Vmoments alloc]init];
        [_momentsCells addObject:cell];
    }];
}

#pragma mark - 本地plist加载数据
- (void)initData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"moments" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    _moments = [[NSMutableArray alloc]init];
    _momentsCells = [[NSMutableArray alloc]init];
    [array enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop){
        [_moments addObject:[Mmoments momentsWithDictionary:obj]];
        Vmoments *cell = [[Vmoments alloc]init];
        [_momentsCells addObject:cell];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _moments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Vmoments *cell = [Vmoments cellWithTableView:_tableView];
    for (UIView *subView in [cell.contentView subviews]) {
        [subView removeFromSuperview];
    }
    Mmoments *moments = _moments[indexPath.row];
    cell.moments = moments;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Vmoments *moments = _momentsCells[indexPath.row];
    moments.moments = _moments[indexPath.row];
    return moments.height;
}

#pragma mark 重写状态样式方法
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)camera
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photograph = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusAuthorized) {
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = sourceType;
                [self presentViewController:picker animated:YES completion:nil];
            }else if (status == AVAuthorizationStatusDenied){
                return ;
            }else if (status == AVAuthorizationStatusRestricted){
                return;
            }else if (status == AVAuthorizationStatusNotDetermined){
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted){
                    if (granted) {
                        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                        picker.delegate = self;
                        picker.allowsEditing = YES;
                        picker.sourceType = sourceType;
                        [self presentViewController:picker animated:YES completion:nil];
                    }else {
                        return ;
                    }
                }];
            }
        }
    }];
    
    UIAlertAction *albums = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        }
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:photograph];
    [alertController addAction:albums];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - VMoments delegate
- (void)imageTapGesture:(NSInteger)tag
{
    NSLog(@"%i",(int)tag);
}

@end