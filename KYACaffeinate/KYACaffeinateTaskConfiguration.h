//
//  KYACaffeinateTaskConfiguration.h
//  KeepingYouAwake
//
//  Created by Marcel Dierkes on 15.10.16.
//  Copyright © 2016 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 An indefinte timeout (usually representing a value of 0 seconds).
 */
extern NSTimeInterval const KYACaffeinateTaskConfigurationTimeoutIndefinite;

/**
 A default timeout (usually 5 seconds).
 */
extern NSTimeInterval const KYACaffeinateTaskConfigurationTimeoutDefault;


/**
 A caffeinate task configuration describes the behaviors that a
 spawned caffeinate task should provide.
 */
@interface KYACaffeinateTaskConfiguration : NSObject

/**
 Create an assertion to prevent the display from sleeping.
 
 (The -d command line flag)
 */
@property (nonatomic, getter=isPreventingDisplaySleep) BOOL preventDisplaySleep;

/**
 Create an assertion to prevent the system from idle sleeping.
 
 (The -i command line flag)
 */
@property (nonatomic, getter=isPreventingSystemIdleSleep) BOOL preventSystemIdleSleep;

/**
 Create an assertion to prevent the disk from idle sleeping.
 
 (The -m command line flag)
 */
@property (nonatomic, getter=isPreventingDisplayIdleSleep) BOOL preventDisplayIdleSleep;

/**
 Create an assertion to prevent the system from sleeping. This assertion is valid only
 when system is running on AC power.
 
 (The -s command line flag)
 */
@property (nonatomic, getter=isPreventingSystemSleepOnACPower) BOOL preventSystemSleepOnACPower;

/**
 Create an assertion to declare that user is active. If the display is off, this option
 turns the display on and prevents the display from going into idle sleep.
 
 (The -u command line flag)
 */
@property (nonatomic, getter=isUserActive) BOOL userActive;

/**
 Specifies the timeout value in seconds for which this assertion has to be valid.
 
 Defaults to 5 seconds.
 
 (The -t command line flag)
 */
@property (nonatomic) NSTimeInterval timeout;


/**
 Waits for the process with the specified pid to exit. Once the the process exits, the
 assertion is also released.
 
 (The -w command line flag)
 */
@property (nonatomic, nullable) NSNumber *pinnedProcessID;

/**
 A default configuration with indefinte timeout.
 */
+ (instancetype)defaultConfiguration;

/**
 A default configuration with timeout.

 @param timeout A timeout.
 */
+ (instancetype)defaultConfigurationWithTimeout:(NSTimeInterval)timeout;

/**
 A default configuration with timeout and process ID to pin.

 @param timeout A timeout.
 @param pinnedProcessID A process ID to which the task is pinned.
 */
+ (instancetype)defaultConfigurationWithTimeout:(NSTimeInterval)timeout pinnedProcessID:(nullable NSNumber *)pinnedProcessID;

/**
 The designated initializer.
 */
- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
