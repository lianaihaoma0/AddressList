//
//  ContactItem.m
//  AddressList
//
//  Created by JeLon_Cai on 2016/10/3.
//  Copyright © 2016年 JeLon_Cai. All rights reserved.
//

#import "ContactItem.h"

@implementation ContactItem

+ (instancetype)itemWithName:(NSString *)name phone:(NSString *)phone
{
    ContactItem *item = [[ContactItem alloc] init];
    item.name = name;
    item.phone = phone;
    return item;
}

@end
