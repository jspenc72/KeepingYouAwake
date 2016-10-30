//
//  KYACaffeinateTask.h
//  KeepingYouAwake
//
//  Created by Marcel Dierkes on 15.10.16.
//  Copyright © 2016 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 An exception that will be thrown when the `caffeinate` utility is not available.
 */
extern NSExceptionName const KYACaffeinateUnavailableException;

typedef void(^KYACaffeinateTaskCompletionHandler)(BOOL cancelled);

@class KYACaffeinateTaskConfiguration;
@protocol KYACaffeinateTaskDelegate;

/**
 A task-based interface around the `caffeinate` utility.
 */
@interface KYACaffeinateTask : NSObject

/**
 The configuration object for this task.
 */
@property (copy, nonatomic, readonly) KYACaffeinateTaskConfiguration *configuration;

/**
 The task delegate to receive state changes.
 */
@property (weak, nonatomic) id<KYACaffeinateTaskDelegate> delegate;

/**
 A completion handler.
 */
@property (copy, nonatomic, readonly) KYACaffeinateTaskCompletionHandler completionHandler;

/**
 Returns the completion date for the currently scheduled timer.
 
 If the timer was scheduled for 0 seconds (Infinity), the fireDate is nil.
 */
@property (copy, nonatomic, readonly, nullable) NSDate *fireDate;


/**
 Return YES if the task is spawned and running.
 */
@property (nonatomic, readonly, getter=isRunning) BOOL running;

- (instancetype)init NS_UNAVAILABLE;

/**
 The designated initializer for the caffeinate task.

 @param configuration A configuration object.
 @return A new instance.
 */
- (instancetype)initWithConfiguration:(KYACaffeinateTaskConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

/**
 Spawns the configured task, calls the completion handler and notifies its delegate.

 @param completionHandler A completion handler.
 @return YES if the task was spawned successfully. If this returns NO, completionHandler won't be called.
 */
- (BOOL)spawnWithCompletionHandler:(KYACaffeinateTaskCompletionHandler)completionHandler;

/**
 Cancels the spawned task.
 */
- (void)cancel;

@end


@protocol KYACaffeinateTaskDelegate <NSObject>
@optional
- (void)caffeinateTaskDidSpawn:(KYACaffeinateTask *)task;
- (void)caffeinateTask:(KYACaffeinateTask *)task didFinish:(BOOL)cancelled;
@end

NS_ASSUME_NONNULL_END
