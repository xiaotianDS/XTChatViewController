//
//  XTMessageCell.m
//  聊天界面
//
//  Created by a on 17/2/13.
//  Copyright © 2017年 wen. All rights reserved.
//

#import "XTMessageCell.h"
#import "XTMessageFrame.h"
#import "XTMessage.h"

@interface XTMessageCell ()

@property(nonatomic,weak)UILabel *timeTitleLab;
@property(nonatomic,weak)UIImageView *headImageView;
@property(nonatomic,weak)UIButton *contentBtn;

@end
@implementation XTMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UILabel *timeLab = [[UILabel alloc] init];
        self.timeTitleLab = timeLab;
        [self addSubview:timeLab];
        timeLab.font = FONTTWO;
        timeLab.textAlignment = NSTextAlignmentCenter;

        UIImageView *headImgView = [[UIImageView alloc] init];
        [self addSubview:headImgView];
        self.headImageView = headImgView;
        headImgView.layer.cornerRadius = W(25);
        headImgView.layer.masksToBounds = YES;
//        iconImageView.layer.borderWidth = 1.0f;

        UIButton *contentBtn = [[UIButton alloc] init];
        [self addSubview:contentBtn];
        self.contentBtn = contentBtn;
        UIImage *backImg = [UIImage imageNamed:@"chat_send_nor"];
        [contentBtn setBackgroundImage:[backImg stretchableImageWithLeftCapWidth:backImg.size.width / 2.0 topCapHeight:backImg.size.height / 2.0] forState:UIControlStateNormal];
        [contentBtn setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
        contentBtn.titleLabel.numberOfLines = 0;
        contentBtn.titleLabel.font = FONTONE;
        [contentBtn setTitleEdgeInsets:UIEdgeInsetsMake(H(20), W(20), H(20), W(20))];

    }
    return self;
}

- (void)setMessageFrame:(XTMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;

    [self setSubViewData];

    [self setSubViewFrame];
}

- (void)setSubViewData
{
    self.timeTitleLab.text = self.messageFrame.messageModel.time;

    if ([self.messageFrame.messageModel.type isEqualToNumber:@0]) {//自己发送的消息

        self.headImageView.image = [UIImage imageNamed:@"me"];

        UIImage *btnBackImage = [UIImage imageNamed:@"chat_send_nor"];
        [self.contentBtn setBackgroundImage:[btnBackImage stretchableImageWithLeftCapWidth:btnBackImage.size.width / 2
                                                                              topCapHeight:btnBackImage.size.height / 2]
                                   forState:UIControlStateNormal];
        UIImage *btnBackImageHelight = [UIImage imageNamed:@"chat_send_press_pic"];
        [self.contentBtn setBackgroundImage:[btnBackImageHelight stretchableImageWithLeftCapWidth:btnBackImageHelight.size.width / 2
                                                                                     topCapHeight:btnBackImageHelight.size.height / 2]
                                   forState:UIControlStateHighlighted];

        if (self.messageFrame.messageModel.messageType == 0) {//如果是文本信息

            [self.contentBtn setTitle:self.messageFrame.messageModel.message forState:UIControlStateNormal];

        } else if (self.messageFrame.messageModel.messageType == 1) {

            [self.contentBtn setImage:self.messageFrame.messageModel.messageImage forState:UIControlStateNormal];
            [self.contentBtn setImageEdgeInsets:UIEdgeInsetsMake(H(20), W(20), H(20), W(20))];

        } else {

            [self.contentBtn setImage:[UIImage imageNamed:@"wenj"] forState:UIControlStateNormal];

        }


    } else {//对方发送的消息

        self.headImageView.image = [UIImage imageNamed:@"other"];

        UIImage *btnBackImage = [UIImage imageNamed:@"chat_recive_nor"];
        [self.contentBtn setBackgroundImage:[btnBackImage stretchableImageWithLeftCapWidth:btnBackImage.size.width / 2
                                                                              topCapHeight:btnBackImage.size.height / 2]
                                   forState:UIControlStateNormal];
        UIImage *btnBackImageHelight = [UIImage imageNamed:@"chat_recive_press_pic"];
        [self.contentBtn setBackgroundImage:[btnBackImageHelight stretchableImageWithLeftCapWidth:btnBackImageHelight.size.width / 2
                                                                                     topCapHeight:btnBackImageHelight.size.height / 2]
                                   forState:UIControlStateHighlighted];

        if (self.messageFrame.messageModel.messageType == 0) {//如果是文本信息

            [self.contentBtn setTitle:self.messageFrame.messageModel.message forState:UIControlStateNormal];

        } else if (self.messageFrame.messageModel.messageType == 1) {

            [self.contentBtn setImage:self.messageFrame.messageModel.messageImage forState:UIControlStateNormal];
            [self.contentBtn setImageEdgeInsets:UIEdgeInsetsMake(H(20), W(20), H(20), W(20))];

        } else {

            [self.contentBtn setImage:[UIImage imageNamed:@"wenj"] forState:UIControlStateNormal];
            
        }

    }

}

- (void)setSubViewFrame
{
    self.timeTitleLab.frame = self.messageFrame.titleLabelFrame;
    self.headImageView.frame = self.messageFrame.iconImageViewFrame;
    self.contentBtn.frame = self.messageFrame.contentBtnFrame;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
