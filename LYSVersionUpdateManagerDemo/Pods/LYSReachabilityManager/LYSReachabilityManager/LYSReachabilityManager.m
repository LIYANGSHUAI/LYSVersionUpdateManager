//
//  LYSReachabilityManager.m
//  LYSReachabilityManagerDemo
//
//  Created by HENAN on 2019/7/19.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSReachabilityManager.h"

@interface LYSReachabilityManager ()
@property (nonatomic, copy) void(^callback)(void);
@property (nonatomic, strong) NSMutableArray *managerArr;
@property (nonatomic,strong, readwrite) LYSNetworkReachabilityManager *manager;
@end

@implementation LYSReachabilityManager

+ (instancetype)manager
{
    static LYSReachabilityManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYSReachabilityManager alloc] init];
        manager.manager = [LYSNetworkReachabilityManager sharedManager];
        [manager.manager startMonitoring];
    });
    return manager;
}

- (NSMutableArray *)managerArr
{
    if (!_managerArr) {
        _managerArr = [NSMutableArray array];
    }
    return _managerArr;
}

- (void)lys_monitorNetwork:(void(^)(void))callback
{
    if (self.manager.networkReachabilityStatus == LYSNetworkReachabilityStatusReachableViaWiFi ||
        self.manager.networkReachabilityStatus == LYSNetworkReachabilityStatusReachableViaWWAN) {
        callback();
    } else {
        LYSReachabilityManager *manager = [[LYSReachabilityManager alloc] init];
        manager.callback = callback;
        [self.managerArr addObject:manager];
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(didChangeNotification:) name:LYSNetworkingReachabilityDidChangeNotification object:nil];
    }
}

- (void)didChangeNotification:(NSNotification *)notifition
{
    LYSNetworkReachabilityStatus status = [notifition.userInfo[LYSNetworkingReachabilityNotificationStatusItem] integerValue];
    if (status == LYSNetworkReachabilityStatusReachableViaWiFi || status == LYSNetworkReachabilityStatusReachableViaWWAN)
    {
        self.callback();
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[LYSReachabilityManager manager].managerArr removeObject:self];
    }
}

- (void)lys_monitorNetwork_wifi:(void(^)(void))callback
{
    if (self.manager.networkReachabilityStatus == LYSNetworkReachabilityStatusReachableViaWiFi) {
        callback();
    } else {
        LYSReachabilityManager *manager = [[LYSReachabilityManager alloc] init];
        manager.callback = callback;
        [self.managerArr addObject:manager];
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(didChangeNotification_wifi:) name:LYSNetworkingReachabilityDidChangeNotification object:nil];
    }
}

- (void)didChangeNotification_wifi:(NSNotification *)notifition
{
    LYSNetworkReachabilityStatus status = [notifition.userInfo[LYSNetworkingReachabilityNotificationStatusItem] integerValue];
    if (status == LYSNetworkReachabilityStatusReachableViaWiFi)
    {
        self.callback();
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[LYSReachabilityManager manager].managerArr removeObject:self];
    }
}

- (BOOL)lys_network
{
    return (self.manager.networkReachabilityStatus == LYSNetworkReachabilityStatusReachableViaWiFi ||
            self.manager.networkReachabilityStatus == LYSNetworkReachabilityStatusReachableViaWWAN);
}

- (BOOL)lys_network_wifi
{
    return (self.manager.networkReachabilityStatus == LYSNetworkReachabilityStatusReachableViaWiFi);
}

@end
