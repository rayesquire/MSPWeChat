//
//  CPersonalInformation.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/10.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "CPersonalInformation.h"
#import "VMine.h"
#import "MMine.h"
#import "AVFoundation/AVFoundation.h"
#import "CAddress.h"
#define TITLESIZE 15
#define DETAILSIZE 12
#define QRCODEX 270
#define QRCODEY 12

@interface CPersonalInformation () <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView *_tableView;
    UIImageView *_userImage;
}
@end

@implementation CPersonalInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    self.title = @"个人信息";
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 70;
    }else if (indexPath.section == 1 && indexPath.row == 2){
        return 50;
    }else return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        VMine *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[VMine alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier qrcodex:QRCODEX qrcodey:QRCODEY];
        cell.textLabel.text = @"我的二维码";
        cell.textLabel.font = [UIFont systemFontOfSize:TITLESIZE];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.font = [UIFont systemFontOfSize:TITLESIZE];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:DETAILSIZE];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"头像";
            _userImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55, 55)];
            [_userImage setImage:[UIImage imageNamed:@"dog.jpg"]];
            _userImage.layer.masksToBounds = YES;
            _userImage.layer.cornerRadius = 3;
            _userImage.tag = 100;
            cell.accessoryView = _userImage;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userImageZoom:)];
            [_userImage addGestureRecognizer:tapGesture];
            _userImage.userInteractionEnabled = YES;
            
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"名字";
            cell.detailTextLabel.text = @"尾巴超大号";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:DETAILSIZE];
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"微信号";
            cell.detailTextLabel.text = @"msp656692784";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:DETAILSIZE];
            cell.accessoryType = NO;
            cell.userInteractionEnabled = NO;
        }else if (indexPath.row == 4){
            cell.textLabel.text = @"我的地址";
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = @"男";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"地区";
            cell.detailTextLabel.text = @"江苏 南京";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"个性签名";
            cell.detailTextLabel.text = @"In me the tiger sniffs the rose";
        }
    }
    return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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
        CAddress *address = [[CAddress alloc]init];
        [self.navigationController pushViewController:address animated:YES];
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
