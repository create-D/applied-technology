//
//  ViewController.m
//  18-通讯录ContactsUI
//
//  Created by 董立权 on 2017/7/19.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import <ContactsUI/ContactsUI.h>
#import <AddressBookUI/AddressBookUI.h>
@interface ViewController ()<CNContactPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //iOS 9之后,不需要授权即可拿到通讯录数据,一定要记得授权
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if(status == CNAuthorizationStatusAuthorized){
        //创建通讯录控制器
        CNContactPickerViewController *contactPickerVC = [[CNContactPickerViewController alloc] init];
        //设置代理
        contactPickerVC.delegate = self;
        //弹出控制器
        [self presentViewController:contactPickerVC animated:YES completion:nil];
    }
    
    
}

#pragma mark - CNContactPickerDelegate
//点击取消按钮时调用
-(void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    
}
//选中某一个联系人时调用
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    //姓名
    NSLog(@"%@ %@",contact.givenName,contact.familyName);
    //电话
    for (CNLabeledValue *labelValue in contact.phoneNumbers) {
        CNPhoneNumber *phoneNumber = labelValue.value;
        NSLog(@"%@ %@",labelValue.label,phoneNumber.stringValue);
    }
}
//选中某一个练习人的某个具体属性时调用
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
}

@end
