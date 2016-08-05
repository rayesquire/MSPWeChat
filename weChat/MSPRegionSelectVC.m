//
//  MSPRegionSelectVC.m
//  weChat
//
//  Created by 马了个马里奥 on 16/8/5.
//  Copyright © 2016年 尾巴超大号. All rights reserved.
//

#import "MSPRegionSelectVC.h"
#import "MSPRegionSelectCell.h"
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

@interface MSPRegionSelectVC ()<UITableViewDataSource,
                                UITableViewDelegate,
                                CLLocationManagerDelegate>

@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,copy) NSString *provinceName;
@property (nonatomic,copy) NSString *countryName;
@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) CLLocationManager *locationManager;

@end

@implementation MSPRegionSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地区";
    self.navigationItem.leftBarButtonItem.title = @"返回";
    _cityName = @"定位中...";
    
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    [_locationManager requestAlwaysAuthorization];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    [_locationManager startUpdatingLocation];
}

#pragma mark - locaiton delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [_locationManager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            NSString *city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
            }
            self.cityName = city;
            self.provinceName = placemark.administrativeArea;
            self.countryName = placemark.country;
        }else if (error == nil && [array count] == 0){
            NSLog(@"No results were returned.");
        }else if (error != nil){
            NSLog(@"An error occurred = %@",error);
        }
        [_tableView reloadData];
    }];
    //    CLLocationCoordinate2D coordinate = location.coordinate;
    //    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //    如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"failed");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    else return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00000001;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"定位到的位置";
    else return @"全部";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    if (indexPath.section == 0) {
        if (!_countryName && !_provinceName) {
            cell = [[MSPRegionSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        else {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", _countryName, _provinceName, _cityName];
            cell.imageView.image = [UIImage imageNamed:@"AlbumLocationIconHL"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
