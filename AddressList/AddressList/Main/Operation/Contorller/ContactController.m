//
//  ContactController.m
//  AddressList
//
//  Created by JeLon_Cai on 2016/10/3.
//  Copyright © 2016年 JeLon_Cai. All rights reserved.
//

#import "ContactController.h"
#import "AddController.h"
#import "EditViewController.h"
#import "ContactItem.h"

@interface ContactController () <AddContactVCDelegate>

/** 存放的都是模型数据 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ContactController

- (NSArray *)dataArrayAtIndexes:(NSIndexSet *)indexes
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@--通讯录",self.name];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:0 target:self action:@selector(loginOut)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:0 target:self action:@selector(addContact)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTalble) name:@"roloadData" object:nil];
}

- (void)loginOut
{
    // 第一步: 创建控制器
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定要退出嘛?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 第二步: 创建按钮
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    // 第三步:添加按钮
    [alertVC addAction:actionCancel];
    [alertVC addAction:actionSure];
    
    // 第四步:显示弹框.(相当于show操作)
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)reloadTalble{
    //刷新表格
    [self.tableView reloadData];
}

- (void)addContact
{
    AddController *addVC = [[AddController alloc] init];
    addVC.delegate = self;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)addContactVC:(AddController *)addVC withContactItem:(ContactItem *)contactItem
{
    // 保存存放的数据
    [self.dataArray addObject:contactItem];
    // 刷新表格
    [self.tableView reloadData];
}

- (void)dealloc{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITabelViewDelegate DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"CELLID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    //取出当前行模型
    ContactItem *item =  self.dataArray[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.phone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactItem *item = self.dataArray[indexPath.row];
    
    EditViewController *eidtVC = [[EditViewController alloc] init];
    eidtVC.contactItem = item;
    
    [self.navigationController pushViewController:eidtVC animated:YES];
}
@end
