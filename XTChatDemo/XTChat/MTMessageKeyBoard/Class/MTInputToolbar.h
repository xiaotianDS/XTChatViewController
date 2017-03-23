//
//  MTInputToolbar.h
//  MTMessageKeyBoardDemo
//
//  Created by 董徐维 on 2016/12/21.
//  Copyright © 2016年 Mr.Tung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTInputToolbar;

@protocol MTInputToolbarDelegate <NSObject>

//发送消息
- (void)inputToolbar:(MTInputToolbar *)inputToolbar sendContent:(NSAttributedString *)sendContent;

//发送语音
- (void)inputToolbar:(MTInputToolbar *)inputToolbar sendRecordData:(NSData *)Data;

//点击更多发送图片／文件
- (void)inputToolbar:(MTInputToolbar *)inputToolbar indexPath:(NSIndexPath *)indexPath;


/**
 *  即将显示键盘时调用
 *
 *  @param inputView 当前输入框view
 *  @param height    键盘高度
 *  @param time      弹出时间
 */
- (void)inputView:(MTInputToolbar *)inputView willShowKeyboardHeight:(CGFloat)height time:(NSNumber *)time;
/**
 *  即将隐藏键盘时调用
 *
 *  @param inputView 当前输入框view
 *  @param time      弹出时间
 */
- (void)willHideKeyboardWithInputView:(MTInputToolbar *)inputView time:(NSNumber *)time;


@end

@interface MTInputToolbar : UIView

/**
 *  初始化chat bar
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  设置输入框最大行数
 */
@property (nonatomic,assign)NSInteger textViewMaxLine;

/**
 *  设置更多界面的数据源(格式为:字典数组。包含2个字段：@image , @label)
 */
@property (strong, nonatomic)NSArray <NSDictionary<NSString *,NSString*> *> *typeDatas;

@property (nonatomic,weak) id<MTInputToolbarDelegate>delegate;

@end
