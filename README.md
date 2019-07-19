# LYSVersionUpdateManager
实现版本更新逻辑,用户只需要关注获取新版本信息和弹窗样式即可

![iOS技术群群二维码](https://github.com/LIYANGSHUAI/LYSRepository/blob/master/iOS技术群群二维码.JPG)

```objc
// 使用方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Override point for customization after application launch.

[LYSVersionUpdateManager regiserWithTarget:self];

return YES;
}

- (void)lys_willUpdateVersionWithManager:(LYSVersionUpdateManager *)manager
{
LYSIF_NETWORK_WIFI_BEGIN
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
[manager updateVersionNum:@"2.0.0" dataParms:@{@"newVersion":@"2.0.0"}];
});
LYSIF_NETWORK_END
}

- (void)lys_startUpdateVersionWithManager:(LYSVersionUpdateManager *)manager
{
NSString *message = [NSString stringWithFormat:@"检测到新版本%@,是否更新?",manager.dataParms[@"newVersion"]];
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"放弃" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
[manager complateHandle];
}];
UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"更新" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
[manager complateHandle];
}];
[alert addAction:cancelAction];
[alert addAction:commitAction];
UIViewController *vc = self.window.rootViewController;
[vc presentViewController:alert animated:YES completion:nil];
}
```

```objc
@interface LYSVersionUpdateManager : NSObject

/**
版本信息
*/
@property (nonatomic, strong, readonly) NSDictionary *dataParms;

/**
注册版本管理类

@param target 代理对象
*/
+ (void)regiserWithTarget:(nonnull id<LYSVersionUpdateManagerDelegate>)target;

/**
传入版本信息,并进行比对,比对是使用的字符串比对,和- (void)lys_willUpdateVersionWithManager:(LYSVersionUpdateManager *)manager;l配合使用

@param versionNum 版本号(字符串)
@param dataParms 版本信息
*/
- (void)updateVersionNum:(nonnull NSString *)versionNum dataParms:(NSDictionary *)dataParms;

@end
```

```objc
@class LYSVersionUpdateManager;

@protocol LYSVersionUpdateManagerDelegate <NSObject>
@required

/**
准备比对版本时触发,可用于网络获取最新版版本信息,然后调用实例- (void)updateVersionNum:(nonnull NSString *)versionNum dataParms:(NSDictionary *)dataParms;方法将版本信息传入管理类

@param manager 管理类
*/
- (void)lys_willUpdateVersionWithManager:(LYSVersionUpdateManager *)manager;

/**
版本比对结束,如果发现新版本,就是触发,否则不触发

@param manager 管理类
*/
- (void)lys_startUpdateVersionWithManager:(LYSVersionUpdateManager *)manager;

@end
```
