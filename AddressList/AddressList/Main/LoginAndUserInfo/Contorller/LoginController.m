//
//  LoginController.m
//  AddressList
//
//  Created by JeLon_Cai on 2016/10/3.
//  Copyright © 2016年 JeLon_Cai. All rights reserved.
//

#import "LoginController.h"
#import "ContactController.h"

@interface LoginController ()
/** 账号 */
@property (nonatomic, strong) UITextField *accountTextField;
/** 密码 */
@property (nonatomic, strong) UITextField *passwordTextField;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"欢迎进入通讯录";
    [self setUpView];
    
    [_accountTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    // 手动判断账号跟密码是否有值
    [self textChange];
}

#pragma mark - 初始化控件
- (void)setUpView
{
    UILabel *accoutLabel = [[UILabel alloc] init];
    accoutLabel.textAlignment = NSTextAlignmentCenter;
    accoutLabel.font = [UIFont systemFontOfSize:13];
    accoutLabel.text = @"账号:";
    [self.view addSubview:accoutLabel];
    
    [accoutLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(Margin);
        layout.widthValue(Margin * 2);
        layout.heightValue(Margin);
        layout.topSpace(SHeight * 0.25);
    }];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    passwordLabel.font = [UIFont systemFontOfSize:13];
    passwordLabel.text = @"密码:";
    [self.view addSubview:passwordLabel];
    
    [passwordLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(Margin);
        layout.widthValue(Margin * 2);
        layout.heightValue(Margin);
        layout.topSpaceByView(accoutLabel,5);
    }];
    
    _accountTextField = [[UITextField alloc] init];
    _accountTextField.placeholder = @"请您输入账号";
    _accountTextField.textAlignment = NSTextAlignmentLeft;
    _accountTextField.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_accountTextField];
    
    [_accountTextField zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(accoutLabel,Margin);
        layout.widthValue(10 * Margin);
        layout.heightValue(Margin);
        layout.topSpace(SHeight * 0.25);
    }];
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.placeholder = @"请您输入密码";
    _passwordTextField.textAlignment = NSTextAlignmentLeft;
    _passwordTextField.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_passwordTextField];
    
    [_passwordTextField zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(passwordLabel,Margin);
        layout.widthValue(10 * Margin);
        layout.heightValue(Margin);
        layout.topSpaceByView(_accountTextField,5);
    }];
    
    
    UILabel *remeberLabel = [[UILabel alloc] init];
    remeberLabel.textAlignment = NSTextAlignmentCenter;
    remeberLabel.font = [UIFont systemFontOfSize:13];
    remeberLabel.text = @"记住密码";
    [self.view addSubview:remeberLabel];
    
    [remeberLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(Margin);
        layout.widthValue(Margin * 3);
        layout.topSpaceByView(passwordLabel, Margin);
        layout.heightValue(Margin);
    }];
    
    UISwitch *pwdSwitch = [[UISwitch alloc] init];
    [self.view addSubview:pwdSwitch];
    
    [pwdSwitch zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(remeberLabel,10);
        layout.topSpaceByView(passwordLabel,15);
    }];
    
    UILabel *auLoginLabel = [[UILabel alloc] init];
    auLoginLabel.textAlignment = NSTextAlignmentCenter;
    auLoginLabel.font = [UIFont systemFontOfSize:13];
    auLoginLabel.text = @"自动登录";
    [self.view addSubview:auLoginLabel];
    
    [auLoginLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(pwdSwitch,10);
        layout.widthValue(Margin * 3);
        layout.topSpaceByView(passwordLabel,Margin);
        layout.heightValue(Margin);
    }];
    
    UISwitch *auloginSwith = [[UISwitch alloc] init];
    [self.view addSubview:auloginSwith];
    
    [auloginSwith zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(auLoginLabel,10);
        layout.topSpaceByView(passwordLabel,15);
    }];
    
    _loginButton = [[UIButton alloc] init];
    _loginButton.enabled = NO;
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    [_loginButton zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpaceByView(auLoginLabel, Margin);
        layout.xCenterByView(self.view,0);
        layout.widthValue(Margin * 3);
    }];
}

#pragma mark - 当文本框内容发生改变时调用
- (void)textChange
{
    _loginButton.enabled = _accountTextField.text.length && _passwordTextField.text.length;
}

#pragma mark - 登录跳转
- (void)loginBtn:(UIButton *)sender
{
    // 如果用户名跟密码正确, 跳转到下一个界面
    // 提醒用户正在登录
    [MBProgressHUD showMessage:@"正在登录..." toView:self.view];
    
    // 延时执行任务
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([_accountTextField.text isEqualToString:@"JeLon"] && [_passwordTextField.text isEqualToString:@"123"]) {
            // 隐藏HUD
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            ContactController *contactVC = [[ContactController alloc] init];
            contactVC.name = _accountTextField.text;
            [self.navigationController pushViewController:contactVC animated:YES];
        }
        else{
            //提醒用户
            NSLog(@"用户名或密码");
            //隐藏HUD
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"用户名或密码"];
        }
        
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
