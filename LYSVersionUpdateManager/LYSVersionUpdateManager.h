//
//  LYSVersionUpdateManager.h
//  LYSVersionUpdateManagerDemo
//
//  Created by HENAN on 2019/7/18.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LYSVersionUpdateManager;

@protocol LYSVersionUpdateManagerDelegate <NSObject>
@required

/**
 准备比对版本时触发,可用于网络获取最新版版本信息,然后调用实例- (void)updateVersionNum:(nonnull NSString *)versionNum dataParms:(NSDictionary *)dataParms;方法将版本信息传入管理类

 @param manager 管理类
 */
- (void)lys_willUpdateVersionWithManager:(LYSVersionUpdateManager *)manager;

/**
 版本比对结束,如果发现新版本,就是触发,否则不触发,当用户操作完成之后必须要调用- (void)complateHandle;方法,否则下次不触发更新

 @param manager 管理类
 */
- (void)lys_startUpdateVersionWithManager:(LYSVersionUpdateManager *)manager;

@end

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

/**
 更新完成之后,或者用户对提示已经做出来响应之后,要调用这个方法,否则下次就不会触发代理方法
 */
- (void)complateHandle;

@end

NS_ASSUME_NONNULL_END
