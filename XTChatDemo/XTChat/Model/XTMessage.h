//
//  XTMessage.h
//  聊天界面
//
//  Created by a on 17/2/13.
//  Copyright © 2017年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTMessage : NSObject

@property (nonatomic, copy) NSString *time;
//对话类型：0：自己的消息；1：对方的消息
@property (nonatomic, strong) NSNumber *type;
//消息类型：0：文字消息；1：图片；2：文件
@property(nonatomic,assign)int messageType;
@property(nonatomic,copy)NSString *message;//文本消息
@property(nonatomic,strong)UIImage *messageImage;//图片消息
@property(nonatomic,strong)NSData *messageData;//文件消息

@property (nonatomic, assign, getter = isHiddenTime) BOOL hiddenTime;

+ (instancetype)messageModelWithDictionary:(NSDictionary *)dict;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
