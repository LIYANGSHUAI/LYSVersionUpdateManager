# LYSReachabilityManager
网络监听管理

![iOS技术群群二维码](https://github.com/LIYANGSHUAI/LYSRepository/blob/master/iOS技术群群二维码.JPG)

```objc
// 在有网络的环境下执行
#define LYSIF_NETWORK_BEGIN [[LYSReachabilityManager manager] lys_monitorNetwork:^{
#define LYSIF_NETWORK_END }];

// 在WIFI的环境下执行
#define LYSIF_NETWORK_WIFI_BEGIN [[LYSReachabilityManager manager] lys_monitorNetwork_wifi:^{
#define LYSIF_NETWORK_WIFI_END }];

// 判断当前网络是否可用
#define LYSISNETWORK [[LYSReachabilityManager manager] lys_network]
// 判断当前WIFI网络是否可用
#define LYSISNETWORK_WIFI [[LYSReachabilityManager manager] lys_network_wifi]
```

```objc
@interface LYSReachabilityManager : NSObject

@property (nonatomic,strong, readonly) AFNetworkReachabilityManager *manager;

+ (instancetype)manager;

- (void)lys_monitorNetwork:(void(^)(void))callback;
- (void)lys_monitorNetwork_wifi:(void(^)(void))callback;

- (BOOL)lys_network;
- (BOOL)lys_network_wifi;

@end
```
