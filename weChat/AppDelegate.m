//
//  AppDelegate.m
//  weChat
//
//  Created by 尾巴超大号 on 15/7/26.
//  Copyright (c) 2015年 尾巴超大号. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MSPPersonalInformationModel.h"
#import "MSPContactModel.h"
#import "MSPContactChatModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = BACKGROUND_COLOR;
    [self.window makeKeyAndVisible];
    
    MainViewController *mainViewController = [[MainViewController alloc]init];
    self.window.rootViewController = mainViewController;
    
    [self writePeople];
    [self writeChatData];
    
    return YES;
}

- (void)writePeople {
    
    MSPPersonalInformationModel *model = [[MSPPersonalInformationModel alloc] init];
    model.ID = 1;
    model.name = @"尾巴超大号";
    model.account = @"msp656692784";
    model.userImage = @"dog.jpg";
    model.sex = @"男";
    model.region = @"江苏 南京";
    model.autograph = @"In me the tiger sniffs the rose";
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:model.ID] forKey:@"uid"];
    
    MSPContactModel *B = [[MSPContactModel alloc] init];
    B.uid = 1;
    B.name = @"张";
    B.remark = @"张";
    B.account = @"dsadafdf";
    B.userImage = @"dog.jpg";
    B.sex = @"1";
    B.region = @"eg";
    
    MSPContactModel *bobo = [[MSPContactModel alloc] init];
    bobo.uid = 2;
    bobo.name = @"波波";
    bobo.remark = @"啵啵啵";
    bobo.account = @"ewq1231";
    bobo.userImage = @"dog.jpg";
    bobo.sex = @"1";
    bobo.region = @"eg";
    
    MSPContactModel *aaa = [[MSPContactModel alloc] init];
    aaa.uid = 3;
    aaa.name = @"大大";
    aaa.remark = @"大大";
    aaa.account = @"312ada";
    aaa.userImage = @"dog.jpg";
    aaa.sex = @"1";
    aaa.region = @"eg";
    
    MSPContactModel *ccc = [[MSPContactModel alloc] init];
    ccc.uid = 4;
    ccc.name = @"江";
    ccc.remark = @"江";
    ccc.account = @"gfdf";
    ccc.userImage = @"dog.jpg";
    ccc.sex = @"0";
    ccc.region = @"eg";
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [MSPPersonalInformationModel createOrUpdateInRealm:realm withValue:model];
    [MSPContactModel createOrUpdateInRealm:realm withValue:B];
    [MSPContactModel createOrUpdateInRealm:realm withValue:bobo];
    [MSPContactModel createOrUpdateInRealm:realm withValue:aaa];
    [MSPContactModel createOrUpdateInRealm:realm withValue:ccc];
    [realm commitWriteTransaction];

}

- (void)writeChatData {
    
    MSPContactChatModel *aaa = [[MSPContactChatModel alloc] init];
    aaa.content = @"sdjkajdlaksjdas";
    aaa.time = 20160807212635;
    aaa.userImage = @"dog.jpg";
    aaa.remark = @"B";
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [MSPContactChatModel createOrUpdateInRealm:realm withValue:aaa];
    [realm commitWriteTransaction];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
