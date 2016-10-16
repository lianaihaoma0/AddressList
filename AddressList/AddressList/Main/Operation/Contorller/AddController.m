//
//  AddController.m
//  AddressList
//
//  Created by JeLon_Cai on 2016/10/3.
//  Copyright © 2016年 JeLon_Cai. All rights reserved.
//

#import "AddController.h"
#import "ContactItem.h"

@interface AddController ()
{
    UITextField         *_nameTextField;
    UITextField         *_phoneTextField;
    UIButton            *_addButton;
}

@end

@implementation AddController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    self.slidingBack = YES;
    [_nameTextField addTarget:self
                       action:@selector(textChange)
             forControlEvents:UIControlEventEditingChanged];
    
    [_phoneTextField addTarget:self
                        action:@selector(textChange)
              forControlEvents:UIControlEventEditingChanged];
    
    [self textChange];
}

#pragma mark - 初始化控件
- (void)setUpView
{
    UILabel *accoutLabel = [[UILabel alloc] init];
    accoutLabel.textAlignment = NSTextAlignmentCenter;
    accoutLabel.font = [UIFont systemFontOfSize:13];
    accoutLabel.text = @"姓名:";
    [self.view addSubview:accoutLabel];
    
    [accoutLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(SWidth * 0.25);
        layout.widthValue(Margin * 2);
        layout.heightValue(Margin);
        layout.topSpace(SHeight * 0.25);
    }];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    passwordLabel.font = [UIFont systemFontOfSize:13];
    passwordLabel.text = @"电话:";
    [self.view addSubview:passwordLabel];
    
    [passwordLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(SWidth * 0.25);
        layout.widthValue(Margin * 2);
        layout.heightValue(Margin);
        layout.topSpaceByView(accoutLabel,5);
    }];
    
    _nameTextField = [[UITextField alloc] init];
    _nameTextField.placeholder = @"请您输入账号";
    _nameTextField.textAlignment = NSTextAlignmentLeft;
    _nameTextField.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_nameTextField];
    
    [_nameTextField zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(accoutLabel,Margin);
        layout.widthValue(10 * Margin);
        layout.heightValue(Margin);
        layout.topSpace(SHeight * 0.25);
    }];
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.placeholder = @"请您输入密码";
    _phoneTextField.textAlignment = NSTextAlignmentLeft;
    _phoneTextField.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_phoneTextField];
    
    [_phoneTextField zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(passwordLabel,Margin);
        layout.widthValue(10 * Margin);
        layout.heightValue(Margin);
        layout.topSpaceByView(_nameTextField,5);
    }];
    
    
    _addButton = [[UIButton alloc] init];
    _addButton.enabled = NO;
    _addButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_addButton setTitle:@"添加" forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButton];
    
    [_addButton zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpaceByView(_phoneTextField, Margin);
        layout.xCenterByView(self.view,0);
        layout.widthValue(Margin * 3);
    }];
}
// 当文本内容发生变化时调用
- (void)textChange
{
    _addButton.enabled = _nameTextField.text.length && _phoneTextField.text.length;
}

//
- (void)addBtn:(id)sender
{
    // 把输入的姓名和电话封装到一个模型
    ContactItem *contactItem = [ContactItem itemWithName:_nameTextField.text phone:_phoneTextField.text];
    
    // 判断代理有没有实现协议方法
    if ([self.delegate respondsToSelector:@selector(addContactVC:withContactItem:)])
    {
        [self.delegate addContactVC:self withContactItem:contactItem];
    }

    // 返回上一级
    [self.navigationController popViewControllerAnimated:YES];
}

@end
