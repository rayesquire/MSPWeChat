//
//  CWallet.m
//  weChat
//
//  Created by 尾巴超大号 on 15/10/11.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "CWallet.h"

@interface CWallet ()
{
    UICollectionView *_collectionView;
}
@end

@implementation CWallet

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"钱包";

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    
}



@end
