//
//  KYACaffeinateTaskConfiguration.h
//  KeepingYouAwake
//
//  Created by Marcel Dierkes on 15.10.16.
//  Copyright © 2016 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSTimeInterval const KYACaffeinateTaskConfigurationTimeoutIndefinite;
extern NSTimeInterval const KYACaffeinateTaskConfigurationTimeoutDefault;

@interface KYACaffeinateTaskConfiguration : NSObject
@property (nonatomic, getter=isPreventingDisplaySleep) BOOL preventDisplaySleep;  // -d
@property (nonatomic, getter=isPreventingSystemIdleSleep) BOOL preventSystemIdleSleep;  // -i
@property (nonatomic, getter=isPreventingDisplayIdleSleep) BOOL preventDisplayIdleSleep;  // -m
@property (nonatomic, getter=isPreventingSystemSleepOnACPower) BOOL preventSystemSleepOnACPower;  // -s
@property (nonatomic, getter=isUserActive) BOOL userActive;  // -u

@property (nonatomic) NSTimeInterval timeout; // defaults to 5secs  // -t
@property (nonatomic, nullable) NSNumber *pinnedProcessID;  // defaults to nil  // -w

+ (instancetype)defaultConfiguration;  // indefinite timeout
+ (instancetype)defaultConfigurationWithTimeout:(NSTimeInterval)timeout;
+ (instancetype)defaultConfigurationWithTimeout:(NSTimeInterval)timeout pinnedProcessID:(nullable NSNumber *)pinnedProcessID;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
