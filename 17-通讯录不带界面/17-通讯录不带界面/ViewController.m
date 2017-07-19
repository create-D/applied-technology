//
//  ViewController.m
//  17-通讯录不带界面
//
//  Created by 董立权 on 2017/7/19.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //判断是否授权
    if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //创建通讯录
        ABAddressBookRef addressBook = ABAddressBookCreate();
        //获取所有通讯录数据
        CFArrayRef peoples = ABAddressBookCopyArrayOfAllPeople(addressBook);
        //2.选择某一个联系人的数据
        //2.1获取数组的长度
        CFIndex peopleCount = CFArrayGetCount(peoples);
        //遍历数组
        for (NSInteger i = 0; i < peopleCount; i++) {
            //获取某一个联系人
            ABRecordRef person = CFArrayGetValueAtIndex(peoples, i);
            //3.获取联系人的姓名和电话
            //姓名
            NSString *firstname = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            NSString *lastname = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
            NSLog(@"%@,%@",firstname,lastname);
            //电话
            ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
            //获取长度
            CFIndex phoneCount = ABMultiValueGetCount(phones);
            //遍历
            for (NSInteger i = 0; i < phoneCount; i++) {
                NSString *label = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, i));
                NSString *value = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, i));
                NSLog(@"%@,%@",label,value);
                
            }
            CFRelease(phones);
        }
        CFRelease(peoples);
        CFRelease(addressBook);
    }
    
}


@end
