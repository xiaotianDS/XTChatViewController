//
//  XTMessageFrame.m
//  聊天界面
//
//  Created by a on 17/2/13.
//  Copyright © 2017年 wen. All rights reserved.
//

#import "XTMessageFrame.h"
#import "XTMessage.h"

@implementation XTMessageFrame

- (void)setMessageModel:(XTMessage *)messageModel
{
    _messageModel = messageModel;

    //设置时间标题label的高度 如果相同 高度为0 即不显示
    CGFloat titleLabelHeight = messageModel.hiddenTime ? 0 : H(30);
    _titleLabelFrame = CGRectMake(0, 0, SCREEN_WIDTH, titleLabelHeight);

#define kContentBtnWidth (contentBtnSize.width + W(40))
#define kContentBtnHeight (contentBtnSize.height + H(35))

    //间距
    CGFloat margin = W(10);
    //头像大小
    CGFloat iconWH = W(50);

    CGSize contentBtnSize;
    if (_messageModel.messageType == 0) {

        //文字大小
        contentBtnSize = [self sizeWithText:_messageModel.message];

    } else if (_messageModel.messageType == 1) {

        CGSize size = _messageModel.messageImage.size;
        contentBtnSize = CGSizeMake(W(150), size.height /size.width * W(150));

    } else {

        contentBtnSize = CGSizeMake(W(150), H(150));

    }

    //头像大小 50 * 50
    if ([_messageModel.type isEqualToNumber:@0]) {//如果是自己发送的消息

        _iconImageViewFrame = CGRectMake(SCREEN_WIDTH - iconWH - margin, CGRectGetMaxY(_titleLabelFrame), iconWH, iconWH);

        _contentBtnFrame = CGRectMake(SCREEN_WIDTH - kContentBtnWidth - iconWH - margin - margin,
                                      CGRectGetMaxY(_titleLabelFrame),
                                      kContentBtnWidth,
                                      kContentBtnHeight);
    }else {//如果是对方发送的消息

        _iconImageViewFrame = CGRectMake(margin, CGRectGetMaxY(_titleLabelFrame), iconWH, iconWH);

        _contentBtnFrame = CGRectMake(margin + iconWH + margin,
                                      CGRectGetMaxY(_titleLabelFrame),
                                      kContentBtnWidth,
                                      kContentBtnHeight);
    }
    _cellHeight = MAX(CGRectGetMaxY(_contentBtnFrame), CGRectGetMaxY(_titleLabelFrame)) + margin;

}

- (CGSize)sizeWithText:(NSString *)text {
    return [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - W(150), MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName : FONTONE}
                              context:nil].size;
}

@end
