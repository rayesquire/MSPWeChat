//
//  MSPAvatorVC.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/5.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPAvatorVC.h"
#import "AVFoundation/AVFoundation.h"
#import "MSPPersonalInformationModel.h"
#import "UIImage+getImage.h"

@interface MSPAvatorVC () <UIImagePickerControllerDelegate,
                           UINavigationControllerDelegate>

@property (nonatomic, readwrite, strong) UIImageView *imageView;
@property (nonatomic, readwrite, strong) MSPPersonalInformationModel *model;

@end

@implementation MSPAvatorVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人头像";
    self.view.backgroundColor = [UIColor blackColor];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64 * 2, SCREEN_WIDTH, SCREEN_HEIGHT - 64 * 4)];
    [self.view addSubview:_imageView];
    
    RLMResults *result = [MSPPersonalInformationModel objectsWhere:@"ID = 1"];
    _model = result.lastObject;
    _imageView.image = [UIImage msp_image:_model.userImage];
        
    UILongPressGestureRecognizer *pan = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(open:)];
    pan.minimumPressDuration = 1.0;
    [_imageView addGestureRecognizer:pan];
    [self.view addGestureRecognizer:pan];
}

- (void)open:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *photograph = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (status == AVAuthorizationStatusAuthorized) {
                    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                    picker.delegate = self;
                    picker.allowsEditing = YES;
                    picker.sourceType = sourceType;
                    [self presentViewController:picker animated:YES completion:nil];
                }
                else if (status == AVAuthorizationStatusDenied) return ;
                else if (status == AVAuthorizationStatusRestricted) return ;
                else if (status == AVAuthorizationStatusNotDetermined) {
                    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted){
                        if (granted) {
                            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                            picker.delegate = self;
                            picker.allowsEditing = YES;
                            picker.sourceType = sourceType;
                            [self presentViewController:picker animated:YES completion:nil];
                        }
                        else return ;
                    }];
                }
            }
        }];
        
        UIAlertAction *albums = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
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
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    dispatch_async(dispatch_get_main_queue(), ^{
        _imageView.image = image;
    });
    // do sth...
    
    // store
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *imagePath = [NSString stringWithFormat:@"%@/userImage.jpeg",path];
        NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(image, 1)];
        [data writeToFile:imagePath atomically:YES];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [MSPPersonalInformationModel createOrUpdateInRealm:realm withValue:@{@"ID": @1, @"userImage":imagePath}];
        [realm commitWriteTransaction];
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - image zoom
- (void)userImageZoom:(UITapGestureRecognizer *)recognizer {
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
- (void)hideImage:(UITapGestureRecognizer *)tap {
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
