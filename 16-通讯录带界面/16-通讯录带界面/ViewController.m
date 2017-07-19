//
//  ViewController.m
//  16-通讯录带界面
//
//  Created by 董立权 on 2017/7/19.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
//
#import <AddressBookUI/AddressBookUI.h>
@interface ViewController ()<ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //判断是否已授权
    if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        //创建通讯录控制器
        ABPeoplePickerNavigationController *pickerNC = [[ABPeoplePickerNavigationController alloc] init];
        //设置代理 注意不要写成delegate
        pickerNC.peoplePickerDelegate = self;
        //弹出控制器
        [self presentViewController:pickerNC animated:YES completion:nil];

    }
}
#pragma mark - ABPeoplePickerNavigationControllerDelegate
//取消
-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    NSLog(@"取消了选择");
}
//选择联系人
//peoplePicker:控制器
//person:用户选择的联系人
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
    NSLog(@"选择了联系人");
    //获取联系人的姓名和电话
    //1.获取姓名
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    //1.1桥接
    NSString *firstNameStr = (__bridge NSString *)(firstName);
    NSString *lastNameStr = (__bridge NSString *)(lastName);
    NSLog(@"firstNameStr:%@ lastNameStr:%@",firstNameStr,lastNameStr);
    
    //释放
    CFRelease(firstName);
    CFRelease(lastName);
    
    //2.获取电话
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    //2.1获取phones的长度
    CFIndex phonesCount = ABMultiValueGetCount(phones);
    //2.1遍历
    for (NSInteger i = 0; i < phonesCount; i++) {
        NSString *label = (__bridge NSString *)(ABMultiValueCopyLabelAtIndex(phones, i));
        NSString *value = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, i));
        NSLog(@"label:%@ value:%@",label,value);
    }
    CFRelease(phones);
}

//选择联系人的某一个具体属性 如果调用了 void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person这个方法,那么该方法不会执行
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    NSLog(@"选择了某个具体属性%zd",property);
}


@end
