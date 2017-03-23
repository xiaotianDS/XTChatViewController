//
//  XTMessageFrame.h
//  聊天界面
//
//  Created by a on 17/2/13.
//  Copyright © 2017年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XTMessage;
@interface XTMessageFrame : NSObject

//时间标题的高度
@property (nonatomic, assign, readonly) CGRect titleLabelFrame;
@property (nonatomic, assign, readonly) CGRect contentBtnFrame;
@property (nonatomic, assign, readonly) CGRect iconImageViewFrame;
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellHeight;

@property(nonatomic,strong)XTMessage *messageModel;

@end
