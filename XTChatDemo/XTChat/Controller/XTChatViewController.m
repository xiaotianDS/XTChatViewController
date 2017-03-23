//
//  XTChatViewController.m
//  聊天界面
//
//  Created by apple on 17/2/9.
//  Copyright © 2017年 wen. All rights reserved.
//

#import "XTChatViewController.h"

#import "MTInputToolbar.h"

//#import "XTInputView.h"
//
#import "XTMessage.h"
#import "XTMessageCell.h"
#import "XTMessageFrame.h"

@interface XTChatViewController ()<UITableViewDelegate,UITableViewDataSource,MTInputToolbarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)MTInputToolbar *messageView;

@property(nonatomic,strong)NSMutableArray *datasource;

@end

@implementation XTChatViewController

//- (NSMutableArray *)datasource
//{
//    if (!_datasource) {
//        NSMutableArray *arrM = [NSMutableArray array];
//
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
//
//        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
//
//        XTMessage *lastModel;
//        for (NSDictionary *dict in arr) {
//
//            XTMessageFrame *frameModel = [[XTMessageFrame alloc] init];
//
//            XTMessage *messageModel = [XTMessage messageModelWithDictionary:dict];
//
//            //先赋值chatModel用于判断上一个model与这个model的时间是否一样 直接调用frame模型的set方法就晚了 没法hiddenTime设置成NO
//            if ([messageModel.time isEqualToString:lastModel.time]) {
//                messageModel.hiddenTime = YES;
//            } else {
//                messageModel.hiddenTime = NO;
//            }
//
//            frameModel.messageModel = messageModel;
//            
//            [arrM addObject:frameModel];
//
//            lastModel = messageModel;
//            
//        }
//
//        _datasource = arrM;
//
//    }
//    return _datasource;
//}

- (NSMutableArray *)datasource
{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BACKGROUNDCOLOR;//[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    self.navigationItem.title = @"Chat";
    [self requestDataSource];
    [self createUI];

}


- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-50)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.datasource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];


    MTInputToolbar *inputToolbar = [[MTInputToolbar alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 50 , SCREEN_WIDTH, 50)];
    inputToolbar.delegate = self;
    self.messageView = inputToolbar;

    NSArray *arr0 = @[@"照片",@"拍照",@"文件"];
    NSArray *imgArr = @[@"pc",@"camera",@"wenj"];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i<arr0.count; i ++ ) {
        NSDictionary *dict = @{@"image":imgArr[i],
                               @"label":arr0[i],
                               };//[NSString stringWithFormat:@"%d",i]
        [arr addObject:dict];
    }
    inputToolbar.typeDatas = [arr copy];

    //文本输入框最大行数
    inputToolbar.textViewMaxLine = 4;
    [self.view addSubview:inputToolbar];
}

#pragma tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_ID = @"cell";
    XTMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_ID];
    if (!cell) {
        cell = [[XTMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_ID];
    } else {

        while ([cell.contentView.subviews lastObject] != nil) {

            [[cell.contentView.subviews lastObject] removeFromSuperview];

        }

    }

    XTMessageFrame *frameModel = self.datasource[indexPath.row];
    cell.messageFrame = frameModel;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.datasource[indexPath.row] cellHeight];
}

#pragma mark MTInputToolbarDelegate
- (void)inputView:(MTInputToolbar *)inputView willShowKeyboardHeight:(CGFloat)height time:(NSNumber *)time
{
    if (height == 0) {
        return;
    }
    [UIView animateWithDuration:[time integerValue] animations:^{

        self.tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-50 - height);

        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.datasource.count - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:YES];


    } completion:nil];
}

- (void)willHideKeyboardWithInputView:(MTInputToolbar *)inputView time:(NSNumber *)time
{
    [UIView animateWithDuration:[time integerValue] animations:^{

        self.tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-50);

    } completion:nil];

}


//发送消息
- (void)inputToolbar:(MTInputToolbar *)inputToolbar sendContent:(NSAttributedString *)sendContent
{
    NSLog(@"%@",sendContent);

    if (sendContent.string.length > 0) {

        [self sendMessage:sendContent.string andType:@0];

    }

}

//发送语音
- (void)inputToolbar:(MTInputToolbar *)inputToolbar sendRecordData:(NSData *)Data
{
    NSLog(@"%@",Data);
}

//更多
- (void)inputToolbar:(MTInputToolbar *)inputToolbar indexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    if (indexPath.row == 0) {
        NSLog(@"添加图片");

        [self addImage];

    } else if (indexPath.row == 1) {
        NSLog(@"拍照");

        [self readImageFromCamera];

    } else {
        NSLog(@"添加文件");



    }

}


/**
 发送消息

 @param message 消息
 @param type 0：当前用户；1：对话对象
 */
- (void)sendMessage:(NSString *)message andType:(NSNumber *)type
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";

    //模拟聊天
    XTMessage *chatModel = [[XTMessage alloc] init];
    chatModel.message = message;
    chatModel.time = [formatter stringFromDate:date];;
    chatModel.type = type;

    XTMessage *lastModel = [[self.datasource lastObject] messageModel];
    if ([chatModel.time isEqualToString:lastModel.time]) {
        chatModel.hiddenTime = YES;
    }else {
        chatModel.hiddenTime = NO;
    }

    XTMessageFrame *frameModel = [[XTMessageFrame alloc] init];
    frameModel.messageModel = chatModel;

    [self.datasource addObject:frameModel];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.datasource.count - 1 inSection:0];

    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationBottom];

    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}

//滚动tableView取消编辑
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

//请求聊天记录
- (void)requestDataSource
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];

    NSArray *arr = [NSArray arrayWithContentsOfFile:path];

    for (NSDictionary *dict in arr) {

        XTMessageFrame *frameModel = [[XTMessageFrame alloc] init];

        XTMessage *messageModel = [XTMessage messageModelWithDictionary:dict];
        messageModel.messageType = 0;

        frameModel.messageModel = messageModel;

        [self.datasource addObject:frameModel];

    }


}


#pragma mark 添加图片

/**
 从相册中选取
 */
- (void)addImage
{
    //创建对象
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    //（选择类型）表示仅仅从相册中选取照片
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPicker.delegate = self;
    //设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
//    imgPicker.allowsEditing = YES;

    [self presentViewController:imgPicker animated:YES completion:nil];

}

/**
 拍照
 */
- (void)readImageFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES; //允许用户编辑
        [self presentViewController:imagePicker animated:YES completion:nil];

    } else {
        //弹出窗口响应点击事件
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"未检测到摄像头" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

    }
}

#pragma mark imagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];

    [self sendImageMessage:img andType:@0];

    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)sendImageMessage:(UIImage *)imageMessage andType:(NSNumber *)type
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";

    //模拟聊天
    XTMessage *chatModel = [[XTMessage alloc] init];
    chatModel.messageType = 1;
    chatModel.messageImage = imageMessage;
    chatModel.time = [formatter stringFromDate:date];;
    chatModel.type = type;

    XTMessage *lastModel = [[self.datasource lastObject] messageModel];
    if ([chatModel.time isEqualToString:lastModel.time]) {
        chatModel.hiddenTime = YES;
    }else {
        chatModel.hiddenTime = NO;
    }

    XTMessageFrame *frameModel = [[XTMessageFrame alloc] init];
    frameModel.messageModel = chatModel;

    [self.datasource addObject:frameModel];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.datasource.count - 1 inSection:0];

    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationBottom];

    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
