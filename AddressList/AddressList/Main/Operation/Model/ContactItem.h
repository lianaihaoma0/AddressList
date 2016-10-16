//
//  ContactItem.h
//  AddressList
//
//  Created by JeLon_Cai on 2016/10/3.
//  Copyright © 2016年 JeLon_Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactItem : NSObject

/** 姓名 */
@property (nonatomic, strong) NSString *name;

/** 电话 */
@property (nonatomic, strong) NSString *phone;

+ (instancetype)itemWithName:(NSString *)name phone:(NSString *)phone;

@end
