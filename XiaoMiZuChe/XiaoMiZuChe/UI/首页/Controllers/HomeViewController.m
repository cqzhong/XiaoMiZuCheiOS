//
//  HomeViewController.m
//  XiaoMiZuChe
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 QZ. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "GcNoticeUtil.h"

@interface HomeViewController ()
@property (nonatomic, assign) UIImageView *bgview;

@end

@implementation HomeViewController

#pragma mark - life cycle
-(void)dealloc
{
    [GcNoticeUtil removeNotification:DECIDEISLOGIN
                            Observer:self
                              Object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}
#pragma mark - private methods
- (void)initUI{
    [self setupNaviBarWithTitle:@"小米租车"];
    
    [GcNoticeUtil handleNotification:DECIDEISLOGIN
                                Selector:@selector(autoLoginSuccessMethods)
                                Observer:self];
    
//    NSString *userType = @"2";
//    NSString *schoolId = @"5";
//    NSString *address = @"上海市杨浦区扬州路588弄";
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"888903",@"userId",@"曹庆中",@"userName",@"2",@"sex",@"412721199999999999",@"idNum",userType,@"userType",@"河南省",@"province",@"郑州市",@"city",@"",@"area",address,@"address",schoolId,@"schoolId", nil];
//    [APIRequest perfectUserDataWithPostDict:dict RequestSuccess:^{
//        
//    } fail:^{
//    }];

}
#pragma mark - 通知
- (void)autoLoginSuccessMethods
{
    if ([PublicFunction shareInstance].m_bLogin == NO) {
        [self setupNaviBarWithBtn:NaviRightBtn title:@"登录" img:nil];
        [self.rightBtn setTitleColor:hexColor(F08200) forState:0];
        self.rightBtn.titleLabel.font = Font_15;
    }else {
        [self.rightBtn setTitle:@"" forState:0];
    }
}
#pragma mark - getters and setters
#pragma mark - event respose
- (void)rightBtnAction
{
    if ([PublicFunction shareInstance].m_bLogin == YES) {
        [self.rightBtn setTitle:@"" forState:0];
        self.rightBtn = nil;
        return;
    }
    LoginViewController *loginVC = [LoginViewController new];
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:loginVC] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
