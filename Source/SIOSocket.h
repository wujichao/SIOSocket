//
//  Socket.h
//  SocketIO
//
//  Created by Patrick Perini on 6/13/14.
//
//

#import <Foundation/Foundation.h>

@interface SIOSocket : NSObject

// Generators
+ (void)socketWithHost:(NSString *)hostURL response:(void(^)(SIOSocket *socket))response;
+ (void)socketWithHost:(NSString *)hostURL reconnectAutomatically:(BOOL)reconnectAutomatically attemptLimit:(NSInteger)attempts withDelay:(NSTimeInterval)reconnectionDelay maximumDelay:(NSTimeInterval)maximumDelay timeout:(NSTimeInterval)timeout response:(void(^)(SIOSocket *socket))response;

// State
@property (nonatomic, readonly) BOOL isConnected;

// Event responders
@property (nonatomic, copy) void (^onConnect)();
@property (nonatomic, copy) void (^onDisconnect)();
@property (nonatomic, copy) void (^onError)(NSDictionary *errorInfo);

@property (nonatomic, copy) void (^onReconnect)(NSInteger numberOfAttempts);
@property (nonatomic, copy) void (^onReconnectionAttempt)(NSInteger numberOfAttempts);
@property (nonatomic, copy) void (^onReconnectionError)(NSDictionary *errorInfo);

- (void)on:(NSString *)event do:(void (^)(id data))function DEPRECATED_MSG_ATTRIBUTE("do is a reserved keyword in Swift. Use -on:perform: instead.");
- (void)on:(NSString *)event perform:(void (^)(id data))function;

// Emitters
- (void)emit:(NSString *)event, ... NS_REQUIRES_NIL_TERMINATION;
- (void)emit:(NSString *)event arguments:(NSArray *)arguments;

@end
