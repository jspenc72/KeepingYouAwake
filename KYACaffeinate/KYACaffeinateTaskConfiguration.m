//
//  KYACaffeinateTaskConfiguration.m
//  KeepingYouAwake
//
//  Created by Marcel Dierkes on 15.10.16.
//  Copyright © 2016 Marcel Dierkes. All rights reserved.
//

#import "KYACaffeinateTaskConfiguration.h"

NSTimeInterval const KYACaffeinateTaskConfigurationTimeoutIndefinite = 0.0;
NSTimeInterval const KYACaffeinateTaskConfigurationTimeoutDefault = 5.0;

@implementation KYACaffeinateTaskConfiguration

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.timeout = KYACaffeinateTaskConfigurationTimeoutDefault;
        self.pinnedProcessID = nil;
    }
    return self;
}

+ (instancetype)defaultConfiguration
{
    return [self defaultConfigurationWithTimeout:KYACaffeinateTaskConfigurationTimeoutIndefinite pinnedProcessID:nil];
}

+ (instancetype)defaultConfigurationWithTimeout:(NSTimeInterval)timeout
{
    int pid = NSProcessInfo.processInfo.processIdentifier;
    return [self defaultConfigurationWithTimeout:timeout pinnedProcessID:@(pid)];
}

+ (instancetype)defaultConfigurationWithTimeout:(NSTimeInterval)timeout pinnedProcessID:(nullable NSNumber *)pinnedProcessID
{
    KYACaffeinateTaskConfiguration *config = [KYACaffeinateTaskConfiguration new];
    config.preventDisplaySleep = YES;
    config.preventSystemIdleSleep = YES;
    config.timeout = timeout;
    config.pinnedProcessID = pinnedProcessID;
    return config;
}

#pragma mark - Private Extension

- (NSArray<NSString *> *)arguments
{
    NSMutableArray *arguments = [NSMutableArray new];
    NSMutableString *flags = [[NSMutableString alloc] initWithString:@"-"];
    [arguments addObject:flags];
    
    if([self isPreventingDisplaySleep])
    {
        [flags appendString:@"d"];
    }
    if([self isPreventingSystemIdleSleep])
    {
        [flags appendString:@"i"];
    }
    if([self isPreventingDisplayIdleSleep])
    {
        [flags appendString:@"m"];
    }
    if([self isPreventingSystemSleepOnACPower])
    {
        [flags appendString:@"s"];
    }
    if([self isUserActive])
    {
        [flags appendString:@"u"];
    }
    if(self.timeout != KYACaffeinateTaskConfigurationTimeoutIndefinite)
    {
        [arguments addObject:[NSString stringWithFormat:@"-t %.f", self.timeout]];
    }
    if(self.pinnedProcessID != nil)
    {
        [arguments addObject:[NSString stringWithFormat:@"-w %@", self.pinnedProcessID]];
    }
    
    return [arguments copy];
}

@end
