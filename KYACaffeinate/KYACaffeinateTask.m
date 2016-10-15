//
//  KYACaffeinateTask.m
//  KeepingYouAwake
//
//  Created by Marcel Dierkes on 15.10.16.
//  Copyright © 2016 Marcel Dierkes. All rights reserved.
//

#import "KYACaffeinateTask.h"
#import "KYACaffeinateTaskConfiguration.h"
#import "KYACaffeinateTaskConfiguration+Private.h"

NSString * const KYACaffeinateTaskCaffeinatePath = @"/usr/bin/caffeinate";
NSExceptionName const KYACaffeinateUnavailableException = @"KYACaffeinateUnavailableException";

@interface KYACaffeinateTask ()
@property (copy, nonatomic, readwrite) KYACaffeinateTaskConfiguration *configuration;
@property (copy, nonatomic, readwrite) NSDate *fireDate;
@property (copy, nonatomic, readwrite) KYACaffeinateTaskCompletionHandler completionHandler;
@property (strong, nonatomic) NSTask *caffeinateTask;
@property (nonatomic, readwrite, getter=isRunning) BOOL running;
@end

@implementation KYACaffeinateTask

#pragma mark - Life Cycle

- (instancetype)initWithConfiguration:(KYACaffeinateTaskConfiguration *)configuration
{
    NSParameterAssert(configuration);
    
    self = [super init];
    if(self)
    {
        self.configuration = configuration;
        
        // Check if caffeinate is available
        if(![[NSFileManager defaultManager] fileExistsAtPath:KYACaffeinateTaskCaffeinatePath])
        {
            @throw [NSException exceptionWithName:KYACaffeinateUnavailableException reason:nil userInfo:nil];
        }
    }
    return self;
}

- (void)dealloc
{
    [self cancel];
}

#pragma mark - Spawning

- (BOOL)spawnWithCompletionHandler:(KYACaffeinateTaskCompletionHandler)completionHandler
{
    if([self isRunning])
    {
        NSLog(@"Caffeinate Task is already spawned.");
        return NO;
    }
    
    self.completionHandler = completionHandler;
    
    [self spawnCaffeinateTask];
    
    // Set the fire date
    NSTimeInterval timeout = self.configuration.timeout;
    if(timeout != KYACaffeinateTaskConfigurationTimeoutIndefinite)
    {
        self.fireDate = [NSDate dateWithTimeIntervalSinceNow:timeout];
    }
    
    // Notify the delegate
    __weak typeof(self) weakSelf = self;
    id<KYACaffeinateTaskDelegate> delegate = self.delegate;
    if([delegate respondsToSelector:@selector(caffeinateTaskDidSpawn:)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate caffeinateTaskDidSpawn:weakSelf];
        });
    }
    
    return [self isRunning];
}

- (void)spawnCaffeinateTask
{
    NSArray *arguments = self.configuration.arguments;
    self.caffeinateTask = [NSTask launchedTaskWithLaunchPath:KYACaffeinateTaskCaffeinatePath arguments:arguments];
    self.running = YES;
    
    // Configure a termination handler
    __weak typeof(self) weakSelf = self;
    self.caffeinateTask.terminationHandler = ^(NSTask *task) {
        [weakSelf terminateWithForce:NO];
    };
}

#pragma mark - Cancellation

- (void)terminateCaffeinateTask
{
    self.caffeinateTask.terminationHandler = nil;
    [self.caffeinateTask terminate];
    
    [self terminateWithForce:YES];
}

- (void)terminateWithForce:(BOOL)forceTerminated
{
    self.caffeinateTask = nil;
    self.fireDate = nil;
    self.running = NO;
    
    __weak typeof(self) weakSelf = self;
    if(self.completionHandler)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.completionHandler(forceTerminated);
        });
    }
    
    id<KYACaffeinateTaskDelegate> delegate = self.delegate;
    if([delegate respondsToSelector:@selector(caffeinateTask:didFinish:)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate caffeinateTask:weakSelf didFinish:forceTerminated];
        });
    }
}

- (void)cancel
{
    self.caffeinateTask.terminationHandler = nil;
    [self.caffeinateTask terminate];
    
    [self terminateWithForce:YES];
}

@end
