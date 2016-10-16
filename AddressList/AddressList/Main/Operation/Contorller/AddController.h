//
//  AddController.h
//  AddressList
//
//  Created by JeLon_Cai on 2016/10/3.
//  Copyright © 2016年 JeLon_Cai. All rights reserved.
//

#import "JLBaseViewController.h"

@class  AddController, ContactItem;

// 1.定义协议
@protocol AddContactVCDelegate <NSObject>

// 2.定义协议方法
- (void)addContactVC:(AddController *)addVC withContactItem:(ContactItem *)contactItem;

@end

@interface AddController : JLBaseViewController

@property (nonatomic, weak) id<AddContactVCDelegate>delegate;

@end
