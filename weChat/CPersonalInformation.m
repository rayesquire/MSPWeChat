//
//  CPersonalInformation.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/10.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "CPersonalInformation.h"
#import "VMine.h"
#import "AVFoundation/AVFoundation.h"
#define TITLESIZE 15
#define DETAILSIZE 12

@interface CPersonalInformation () <UITableViewDataSource,
                                    UITableViewDelegate,
                                    UIImagePickerControllerDelegate,
                                    UINavigationControllerDelegate>

@property (nonatomic, readwrite, strong) NSArray *listArray;
@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) UIImageView *userImage;

@end

@implementation CPersonalInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.title = @"个人信息";
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _listArray = @[@"头像",@"名字",@"微信号",@"我的二维码",@"我的地址",@"性别",@"地区",@"个性签名"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 5;
    else return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) return 70;
    else return 44;
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellIdentifier = @"cellIdentifier";
//    VMine *cell = [[VMine alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    if (indexPath.section == 0) {
//        cell.textLabel.font = [UIFont systemFontOfSize:TITLESIZE];
//        cell.textLabel.text = _listArray[indexPath.row];
//        if (indexPath.row == 0) {
//            UIImage *image = [UIImage imageNamed:self.personalInfo.userImage];
//            [cell setRightIcon:image size:CGSizeMake(55, 55)];
//        }
//        else if (indexPath.row == 3) {
//            UIImage *image = [UIImage imageNamed:@"qrcode"];
//            [cell setRightIcon:image size:CGSizeMake(20, 20)];
//        }
//        else if (indexPath.row == 1) {
//            cell.detailTextLabel.text = self.personalInfo.name;
//            cell.detailTextLabel.font = [UIFont systemFontOfSize:DETAILSIZE];
//        }
//        else if (indexPath.row == 2) {
//            cell.detailTextLabel.text = self.personalInfo.account;
//            cell.detailTextLabel.font = [UIFont systemFontOfSize:DETAILSIZE];
//            cell.accessoryType = NO;
//        }
//    }
//    else {
//        cell.textLabel.font = [UIFont systemFontOfSize:TITLESIZE];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:DETAILSIZE];
//        cell.textLabel.text = _listArray[indexPath.row + 5];
//        if (indexPath.row == 0) {
//            cell.detailTextLabel.text = _personalInfo.sex;
//        }
//        else if (indexPath.row == 1){
//            cell.detailTextLabel.text = _personalInfo.region;
//        }
//        else {
//            cell.detailTextLabel.text = _personalInfo.autograph;
//        }
//    }
//    return cell;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0 && indexPath.row == 0) {
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
    }else if (indexPath.section == 1 &&indexPath.row == 1){
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
        backItem.title = @"返回";
        self.navigationItem.backBarButtonItem = backItem;
//        CAddress *address = [[CAddress alloc]init];
//        [self.navigationController pushViewController:address animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 2){

    }
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - image zoom
- (void)userImageZoom:(UITapGestureRecognizer *)recognizer
{
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 1;
    CGRect oldFrame = [imageView convertRect:imageView.bounds toView:window];
    
    UIImageView *current = [[UIImageView alloc]initWithFrame:oldFrame];
    current.image = imageView.image;
    current.tag = 123;
    [backgroundView addSubview:current];
    [window addSubview:backgroundView];
    // small
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.3 animations:^{
        current.center = window.center;
        [current setFrame:CGRectMake(0, 142, 320, 284)];
    }];
}

#pragma mark - image hide
- (void)hideImage:(UITapGestureRecognizer *)tap
{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:123];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.alpha = 0;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished){
        [backgroundView removeFromSuperview];
    }];
}
@end
