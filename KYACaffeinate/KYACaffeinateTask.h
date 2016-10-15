//
//  KYACaffeinateTask.h
//  KeepingYouAwake
//
//  Created by Marcel Dierkes on 15.10.16.
//  Copyright © 2016 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSExceptionName const KYACaffeinateUnavailableException;

typedef void(^KYACaffeinateTaskCompletionHandler)(BOOL cancelled);

@class KYACaffeinateTaskConfiguration;
@protocol KYACaffeinateTaskDelegate;

@interface KYACaffeinateTask : NSObject
@property (copy, nonatomic, readonly) KYACaffeinateTaskConfiguration *configuration;
@property (weak, nonatomic) id<KYACaffeinateTaskDelegate> delegate;

@property (copy, nonatomic, readonly) KYACaffeinateTaskCompletionHandler completionHandler;
@property (copy, nonatomic, readonly, nullable) NSDate *fireDate;
@property (nonatomic, readonly, getter=isRunning) BOOL running;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithConfiguration:(KYACaffeinateTaskConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

- (BOOL)spawnWithCompletionHandler:(KYACaffeinateTaskCompletionHandler)completionHandler;

- (void)cancel;

@end


@protocol KYACaffeinateTaskDelegate <NSObject>
@optional
- (void)caffeinateTaskDidSpawn:(KYACaffeinateTask *)task;
- (void)caffeinateTask:(KYACaffeinateTask *)task didFinish:(BOOL)cancelled;
@end

NS_ASSUME_NONNULL_END
