//
//  LYSReachabilityManager.h
//  LYSReachabilityManagerDemo
//
//  Created by HENAN on 2019/7/19.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYSNetworkReachabilityManager.h"

NS_ASSUME_NONNULL_BEGIN

#define LYSIF_NETWORK_BEGIN [[LYSReachabilityManager manager] lys_monitorNetwork:^{
#define LYSIF_NETWORK_END }];

#define LYSIF_NETWORK_WIFI_BEGIN [[LYSReachabilityManager manager] lys_monitorNetwork_wifi:^{
#define LYSIF_NETWORK_WIFI_END }];

#define LYSISNETWORK [[LYSReachabilityManager manager] lys_network]
#define LYSISNETWORK_WIFI [[LYSReachabilityManager manager] lys_network_wifi]

@interface LYSReachabilityManager : NSObject

@property (nonatomic,strong, readonly) LYSNetworkReachabilityManager *manager;

+ (instancetype)manager;

- (void)lys_monitorNetwork:(void(^)(void))callback;
- (void)lys_monitorNetwork_wifi:(void(^)(void))callback;

- (BOOL)lys_network;
- (BOOL)lys_network_wifi;

@end

NS_ASSUME_NONNULL_END
