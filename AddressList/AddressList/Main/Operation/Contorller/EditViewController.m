//
//  EditViewController.m
//  AddressList
//
//  Created by JeLon_Cai on 2016/10/3.
//  Copyright © 2016年 JeLon_Cai. All rights reserved.
//

#import "EditViewController.h"
#import "ContactItem.h"

@interface EditViewController ()
{
    UITextField         *_nameTextField;
    UITextField         *_phoneTextField;
    UIButton            *_saveButton;
}

@end

@implementation EditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
      
    [self setUpView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:0 target:self action:@selector(editClick)];
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
    
    
    _saveButton = [[UIButton alloc] init];
    _saveButton.enabled = NO;
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_saveButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_saveButton setTitle:@"添加" forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveButton];
    
    [_saveButton zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpaceByView(_phoneTextField, Margin);
        layout.xCenterByView(self.view,0);
        layout.widthValue(Margin * 3);
    }];
}

- (void)editClick
{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"编辑"])
    {
        _phoneTextField.enabled = YES;
        _nameTextField.enabled = YES;
        // 文本框成为第一响应者
        [_phoneTextField becomeFirstResponder];
        // 保存按钮显示
        _saveButton.hidden = NO;
        // 把编辑按钮的文字改为取消
        self.navigationItem.rightBarButtonItem.title = @"取消";
    }
    else{
        _phoneTextField.enabled = NO;
        _nameTextField.enabled = NO;
        [self.view endEditing:YES];
        _saveButton.hidden = YES;
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        // 恢复之前的数据
        _nameTextField.text = self.contactItem.name;
        _phoneTextField.text = self.contactItem.phone;
    }
}

- (void)saveBtn:(id)sender
{
    // 修改模型
    self.contactItem.name = _nameTextField.text;
    self.contactItem.phone = _phoneTextField.text;
    
    // 通知上一个控制器刷新列表
    [[NSNotificationCenter defaultCenter] postNotificationName:@"roloadData" object:nil userInfo:nil];
    
    // 返回上一级
    [self.navigationController popViewControllerAnimated:YES];
}
@end
