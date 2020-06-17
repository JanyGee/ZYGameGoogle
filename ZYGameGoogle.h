//
//  ZYGameGoogle.h
//  ZYWebGameKitSample
//
//  Created by admin on 2020/5/12.
//  Copyright © 2020 Octopus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYGameGoogle : NSObject
+ (instancetype)shareGoogle;
- (void)initWithClientID:(NSString *)clientID;
@end

NS_ASSUME_NONNULL_END
