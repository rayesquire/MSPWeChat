//
//  Vmoments.m
//  weChat
//
//  Created by 尾巴超大号 on 15/8/6.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "Vmoments.h"
#import "Mmoments.h"

#define THETEXTSIZE 12
#define THENAMESIZE 14
#define THEWHERESIZE 12
#define THETIMESIZE 12
#define THESPACE 10
#define THEUSERIMAGESIZE 40
#define THESTDWIDTH (textWidth - 2 * THESPACE) / 3  // 1/3 image width
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define DAY 24*60*60
#define MINUTE 60
#define HOUR 3600
#define WEEK 7*24*60*60
@interface Vmoments ()
{
    NSMutableArray *_images;
    UIImageView *_imageView;
}
@end
@implementation Vmoments

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"moments";
    Vmoments *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[Vmoments alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.userImage = [[UIImageView alloc]init];
        [self addSubview:self.userImage];
        
        self.remark = [[UILabel alloc]init];
        [self addSubview:self.remark];
        
        self.text = [[UILabel alloc]init];
        [self addSubview:self.text];
        
        self.time = [[UILabel alloc]init];
        [self addSubview:self.time];
        
        self.where = [[UILabel alloc]init];
        [self addSubview:self.where];
        
        _images = [[NSMutableArray alloc]init];
        
    }
    return self;
}

- (void)setMoments:(Mmoments *)moments
{
    CGFloat userImageX = THESPACE;
    CGFloat userImageY = THESPACE * 1.5;
    CGRect userImageRect = CGRectMake(userImageX, userImageY, THEUSERIMAGESIZE, THEUSERIMAGESIZE);
    self.userImage.frame = userImageRect;
    self.userImage.image = [UIImage imageNamed:moments.userImage];
    
    CGFloat remarkX = CGRectGetMaxX(userImageRect) + THESPACE;
    CGFloat remarkY = userImageY;
    CGSize remarkSize = [moments.remark sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:THENAMESIZE]}];
    CGRect remarkRect = CGRectMake(remarkX, remarkY, remarkSize.width, remarkSize.height);
    self.remark.font = [UIFont systemFontOfSize:THENAMESIZE];
    self.remark.textColor = [UIColor colorWithRed:74/255.0 green:112/255.0 blue:139/255.0 alpha:1];
    self.remark.frame = remarkRect;
    self.remark.text = moments.remark;
    
    CGFloat textX = remarkX;
    CGFloat textWidth = SCREENWIDTH - THEUSERIMAGESIZE - 3 * THESPACE;
    CGSize textSize = [moments.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:THETEXTSIZE]}];
    CGFloat textY = CGRectGetMaxY(userImageRect) - textSize.height - 4;
    CGRect textRect = CGRectMake(textX, textY, textWidth, textSize.height * ((textSize.width / textWidth)+1));
    self.text.numberOfLines = 0;
    self.text.lineBreakMode = NSLineBreakByWordWrapping;
    self.text.frame = textRect;
    self.text.font = [UIFont systemFontOfSize:THETEXTSIZE];
    self.text.textColor = [UIColor blackColor];
    self.text.text = moments.text;
    
 
    /////////////////////////////////////  image   ////////////////////////////////////////////
    _images = moments.images;
    int num = (int)_images.count;
    CGFloat imageX = remarkX;
    CGFloat imageY = CGRectGetMaxY(textRect) + THESPACE;
    CGRect imageRect = textRect;
    CGFloat footHeight = CGRectGetMaxY(imageRect);     // the last image's height
    if (num == 0){
        ;
    }else if (num == 1){
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:_images[0]];
        CGSize imageSize = _imageView.image.size;
        CGFloat imageProportion = (double)imageSize.width/(double)imageSize.height;
        if (imageProportion>1) {
            imageSize.height = imageSize.height / (imageSize.width / (textWidth * 3 / 5));
            imageSize.width = textWidth * 3 / 5;
        }else{
            imageSize.width = imageSize.width / (imageSize.height / (textWidth * 3 / 5));
            imageSize.height = textWidth * 3 / 5;
        }
            imageRect = CGRectMake(imageX, imageY, imageSize.width, imageSize.height);
            _imageView.frame = imageRect;
            _imageView.tag = 1;
            //  add tapgesture
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageZoom:)];
            [_imageView addGestureRecognizer:tapGesture];
            _imageView.userInteractionEnabled = YES;
            [self.contentView addSubview:_imageView];
            footHeight = CGRectGetMaxY(imageRect);
        }else if (num == 4){
            int n = 0;
            for (int y = 0; y<2; y++) {
                for (int x = 0; x<2; x++) {
                    imageRect = CGRectMake(textX + x * (THESTDWIDTH + THESPACE), imageY + y * (THESTDWIDTH + THESPACE), THESTDWIDTH, THESTDWIDTH);
                    _imageView = [[UIImageView alloc]init];
                    _imageView.image = [UIImage imageNamed:_images[n]];
                    _imageView.frame = imageRect;
                    _imageView.tag = n+1;
                    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageZoom:)];
                    [_imageView addGestureRecognizer:tapGesture];
                    _imageView.userInteractionEnabled = YES;
                    [self.contentView addSubview:_imageView];
                    n++;
                    footHeight = CGRectGetMaxY(imageRect);
                }
            }
        }else {
            int n = 0;
            for (int y = 0; y<3; y++) {
                for (int x = 0; x<3; x++) {
                    if (x + 3 * y + 1 > num) {
                        break;
                    }
                    imageRect = CGRectMake(textX + x * (THESTDWIDTH + THESPACE), imageY + y * (THESTDWIDTH + THESPACE), THESTDWIDTH, THESTDWIDTH);
                    _imageView = [[UIImageView alloc]init];
                    _imageView.image = [UIImage imageNamed:_images[n]];
                    _imageView.frame = imageRect;
                    _imageView.tag = n+1;
                    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageZoom:)];
                    [_imageView addGestureRecognizer:tapGesture];
                    _imageView.userInteractionEnabled = YES;
                    [self.contentView addSubview:_imageView];
                    n++;
                    footHeight = CGRectGetMaxY(imageRect);
                }
            }
        }
    ///////////////////////////////////////  image   ////////////////////////////////////////////
    
    footHeight = CGRectGetMaxY(imageRect);
    
    CGFloat timeX = remarkX;
    CGFloat timeY = footHeight + THESPACE;

    self.time.font = [UIFont systemFontOfSize:THETIMESIZE];
    self.time.textColor = [UIColor grayColor];
    self.time.text = [self timeToTime:moments.time];
    CGSize timeSize = [self.time.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:THETIMESIZE]}];
    CGRect timeRect = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.time.frame = timeRect;
    
    CGFloat whereX = CGRectGetMaxX(timeRect) + THESPACE;
    CGFloat whereY = timeY;
    CGSize whereSize = [moments.where sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:THEWHERESIZE]}];
    CGRect whereRect = CGRectMake(whereX, whereY, whereSize.width, whereSize.height);
    self.where.frame = whereRect;
    self.where.font = [UIFont systemFontOfSize:THEWHERESIZE];
    self.where.textColor = [UIColor grayColor];
    self.where.text = moments.where;
    
    _height = CGRectGetMaxY(whereRect) + THESPACE;
}

- (void)imageZoom:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(imageTapGesture:)]) {
        [self.delegate imageTapGesture:((UIImageView *) sender.view).tag];
    }
}

#pragma mark - calculate time
- (NSString *)timeToTime:(NSString *)aString
{
    NSDateFormatter *trans = [[NSDateFormatter alloc]init];
    [trans setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *dateNow = [NSDate date];
    NSString *stringNow = [trans stringFromDate:dateNow];
    NSString *big = [stringNow substringWithRange:NSMakeRange(2, 10)];
    NSString *small = [aString substringWithRange:NSMakeRange(2, 10)];
    int x = [big intValue] - [small intValue];
    if (!x){
        return @"刚刚";
    }else if (x < 100){
        return [NSString stringWithFormat:@"%i分钟前",x-40];
    }else if (x < 10000){
        return [NSString stringWithFormat:@"%i小时前",(x/100)<24?(x/100):(x/100-76)];
    }else if (x < 20000){
        return @"昨天";
    }else if (x < 1000000){
        return [NSString stringWithFormat:@"%i天前",(x/10000)<30?(x/10000):(x/10000-70)];
    }else {
        return [NSString stringWithFormat:@"%d个月前",(x/1000000)<12?(x/1000000):(x/1000000-88)];
    }
}

//#pragma mark 重写选择事件，取消选中
//-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
//    
//}

@end