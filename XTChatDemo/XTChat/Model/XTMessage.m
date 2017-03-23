//
//  XTMessage.m
//  聊天界面
//
//  Created by a on 17/2/13.
//  Copyright © 2017年 wen. All rights reserved.
//

#import "XTMessage.h"

@implementation XTMessage

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {

        _type = dict[@"type"];
        _time = dict[@"time"];
        if (_messageType == 0) {//文本消息

            _message = dict[@"text"];

        } else if (_messageType == 1) {

            _messageImage = [UIImage imageNamed:dict[@"text"]];

        } else {

            _messageData = dict[@"text"];

        }

    }
    return self;
}

+ (instancetype)messageModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end
