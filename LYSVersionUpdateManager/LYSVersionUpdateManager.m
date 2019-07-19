//
//  LYSVersionUpdateManager.m
//  LYSVersionUpdateManagerDemo
//
//  Created by HENAN on 2019/7/18.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSVersionUpdateManager.h"

@interface LYSVersionUpdateManager ()
@property (nonatomic, assign) id<LYSVersionUpdateManagerDelegate>target;
@property (nonatomic, assign) BOOL alertUpdate;
@property (nonatomic, strong, readwrite) NSDictionary *dataParms;
@end

@implementation LYSVersionUpdateManager

+ (instancetype)manager
{
    static LYSVersionUpdateManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYSVersionUpdateManager alloc] init];
    });
    return manager;
}

+ (void)regiserWithTarget:(id<LYSVersionUpdateManagerDelegate>)target
{
    [[LYSVersionUpdateManager manager] setTarget:target];
    [[NSNotificationCenter defaultCenter] addObserver:[LYSVersionUpdateManager manager] selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:[LYSVersionUpdateManager manager] selector:@selector(didBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)didEnterBackground:(NSNotification *)notifition
{
    self.alertUpdate = NO;
    NSLog(@"didEnterBackground");
}

- (void)didBecomeActive:(NSNotification *)notifition
{
    if (self.alertUpdate == NO && self.target && [self.target respondsToSelector:@selector(lys_willUpdateVersionWithManager:)]) {
        [self.target lys_willUpdateVersionWithManager:self];
    }
    self.alertUpdate = YES;
    NSLog(@"didBecomeActive");
}

- (void)updateVersionNum:(nonnull NSString *)versionNum dataParms:(NSDictionary *)dataParms
{
    self.dataParms = dataParms;
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (![currentVersion isEqualToString:versionNum]) {
        if (self.target && [self.target respondsToSelector:@selector(lys_startUpdateVersionWithManager:)]) {
            [self.target lys_startUpdateVersionWithManager:self];
        }
    }
}

@end
