//
//  weChatView.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/26.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "weChatView.h"
#import "detailView.h"

@interface weChatView () <UINavigationControllerDelegate>
{
    UITableView *tableView;
    NSMutableArray *status;
    NSMutableArray *statusCell;
    UIImageView *image;
}
@end

@implementation weChatView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
   
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    self.navigationItem.rightBarButtonItem = addButton;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gjqt.jpg"]];
    image.frame = CGRectMake(20, 100, 280, 160);
    image.contentMode = UIViewContentModeScaleToFill;  //设置内容模式为缩放填充
    image.userInteractionEnabled = YES;  //这里必须设置为YES，否则无法接收手势操作
    [self.view addSubview:image];
    
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    search.placeholder = @"搜索";
    
    [self addGesture];
    
    
    
    
    
    
}

#pragma mark - add gesture
- (void)addGesture
{
    /*添加点按手势*/
    //创建手势对象
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    //设置手势属性
    tapGesture.numberOfTapsRequired = 1;  //设置点按次数，默认为1，注意在iOS中很少用双击操作
    tapGesture.numberOfTouchesRequired = 1;  //点按的手指数
    //添加手势到对象(注意，这里添加到了控制器视图中，而不是图片上，否则点击空白无法隐藏导航栏)
    [self.view addGestureRecognizer:tapGesture];
    
    /*添加长按手势*/
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressImage:)];
    longPressGesture.minimumPressDuration = 0.5;  //设置长按时间，默认0.5秒，一般这个值不要修改
    //注意由于我们要做长按提示删除操作，因此这个手势不再添加到控制器视图上而是添加到了图片上
    [image addGestureRecognizer:longPressGesture];
    
    /*添加捏合手势*/
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchImage:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    /*添加旋转手势*/
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateImage:)];
    [self.view addGestureRecognizer:rotationGesture];
    
    /*添加拖动手势*/
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panImage:)];
    [self.view addGestureRecognizer:panGesture];
    
    /*添加轻扫手势*/
    //注意一个轻扫手势只能控制一个方向，默认向右，通过direction进行方向控制
    UISwipeGestureRecognizer *swipeGestureToRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
//    swipeGestureToRight.direction = UISwipeGestureRecognizerDirectionRight;  // default to right
    [self.view addGestureRecognizer:swipeGestureToRight];
    
    UISwipeGestureRecognizer *swipeGestureToLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
    swipeGestureToLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGestureToLeft];
    
}
#pragma mark 显示图片名称
- (void)showPhotoName{
    NSString *title = [NSString stringWithFormat:@"gjqt.jpg"];
    [self setTitle:title];
}
#pragma mark 下一张图片
- (void)nextImage
{
//    int index =
}
#pragma mark 上一张图片
- (void)lastImage
{
    
}
#pragma mark - 手势操作
#pragma mark 点按隐藏或显示导航栏
- (void)tapImage:(UITapGestureRecognizer *)gesture
{
    BOOL hidden = !self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
}

#pragma mark 长按提示是否删除
- (void)longPressImage:(UILongPressGestureRecognizer *)gesture
{
    //注意其实在手势里面有一个view属性可以获取点按的视图
    //UIImageView *imageView=(UIImageView *)gesture.view;
    //由于连续手势此方法会调用多次，所以需要判断其手势状态
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"System Info" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete the photo" otherButtonTitles: nil];
//        [actionSheet showInView:self.view];
//    }
}

#pragma mark 捏合时缩放图片
- (void)pinchImage:(UIPinchGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateCancelled) {
        //捏合手势中scale属性记录的缩放比例
        image.transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
    }else if (gesture.state == UIGestureRecognizerStateEnded){  //结束后恢复
        [UIView animateWithDuration:0.5 animations:^{
            image.transform = CGAffineTransformIdentity;  //取消一切形变
        }];
    }
}
#pragma mark 旋转图片
- (void)rotateImage:(UIRotationGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged) {
        image.transform = CGAffineTransformMakeRotation(gesture.rotation);
    }else if (gesture.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.8 animations:^{
            image.transform = CGAffineTransformIdentity;
        }];
    }
}
#pragma mark 拖动图片
- (void)panImage:(UIPanGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateChanged){
        CGPoint translation = [gesture translationInView:self.view]; //利用拖动手势的translationInView:方法取得在相对指定视图（这里是控制器根视图）的移动
        image.transform = CGAffineTransformMakeTranslation(translation.x,translation.y);
    }else if (gesture.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.5 animations:^{
            image.transform = CGAffineTransformIdentity;
        }];
    }
}
#pragma mark 轻扫则查看下一张或上一张
//注意虽然轻扫手势是连续手势，但是只有在识别结束才会触发，不用判断状态
- (void)swipeImage:(UISwipeGestureRecognizer *)gesture
{
    //    NSLog(@"swip:%i",gesture.state);
    //    if (gesture.state==UIGestureRecognizerStateEnded) {
    
    //direction记录的轻扫的方向
    if (gesture.direction==UISwipeGestureRecognizerDirectionRight) {//向右
        [self nextImage];
        //            NSLog(@"right");
    }else if(gesture.direction==UISwipeGestureRecognizerDirectionLeft){//向左
        //            NSLog(@"left");
        [self lastImage];
    }
    //    }
}
#pragma mark - 视图控制器的触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)push{

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end