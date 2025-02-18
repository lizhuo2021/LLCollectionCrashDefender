//
//  LLCrashMutableDictionaryViewController.m
//  LLCollectionCrashDefender
//
//  Created by 李琢琢 on 2025/2/18.
//

#import "LLCrashMutableDictionaryViewController.h"

#import "LLCollectionExceptionHandler.h"
#import "LLUserModel.h"

@interface LLCrashMutableDictionaryViewController ()<UITextViewDelegate>

@property(nonatomic, strong) UITextView *loggerView;

@end

@implementation LLCrashMutableDictionaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self configData];
    
    [self setupSubviews];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//MARK: - Private

- (void)configData {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exceptionErrorNoti:) name:kLLCollectionExceptionHandlerNotificationName object:nil];
    
}

- (void)setupSubviews {
    
    self.title = @"NSMutableDictionary Crash";
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    UIButton * lastButton;
    
    CGFloat statusBarHeight = 0;
    
//    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
//    }else {
//        statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
//    }
    
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    

    //setObject:forKey:
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSDictionaryM setObject:forKey:" target:self action:@selector(testSetObjectForKey)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, statusBarHeight + navigationBarHeight + 10, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    //removeObjectForKey:
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSDictionaryM removeObjectForKey:" target:self action:@selector(testRemoveObjectForKey)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    //setObject:forKeyedSubscript:
    if (@available(iOS 11.0, *)) {
        {
            UIButton * button = [self createBlackButtonWithTitle:@"__NSDictionaryM setObject:forKeyedSubscript:" target:self action:@selector(testSetObjectForKeyedSubscript)];
            [self.view addSubview:button];
            
            button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
            lastButton = button;
        }
    }
    
    
    
//    loggerView
    CGFloat loggerViewHeight = CGRectGetHeight(self.view.frame) - CGRectGetMaxY(lastButton.frame) - 50;
    self.loggerView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lastButton.frame) + 50, CGRectGetWidth(self.view.frame), loggerViewHeight)];
    self.loggerView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.loggerView.delegate = self;
    self.loggerView.backgroundColor = UIColor.blackColor;
    self.loggerView.textColor = UIColor.whiteColor;
    [self.view addSubview:self.loggerView];
       
}


- (UIButton *)createBlackButtonWithTitle:(NSString *)title
                                target:(id)target
                                action:(SEL)action {
    
    UIButton * button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.blackColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

//MARK: - Events

- (void)exceptionErrorNoti:(NSNotification *)noti {
    
    NSDictionary * info = noti.userInfo;
   
    if (info == nil) {
        return;
    }
    self.loggerView.text = [NSString stringWithFormat:@"\n----\n%@", info];
}



- (void)testSetObjectForKey {
    
    LLUserModel * model;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
//    -[__NSDictionaryM setObject:forKey:]: object cannot be nil (key: userModel)'
    [dict setObject:model forKey:@"userModel"];
    
}

- (void)testRemoveObjectForKey {

    NSString * key;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
//    -[__NSDictionaryM removeObjectForKey:]: key cannot be nil'
    [dict removeObjectForKey:key];
    
}

- (void)testSetObjectForKeyedSubscript {
    //    setObject: forKeyedSubscript:
    //    允许通过下标语法（dict[key] = value）为 NSMutableDictionary 设置键值对。
    //    等价于 [dict setObject:@"Value" forKey:@"Key"];
    //    dict[@"Key"] = @"Value";
    //    设置 nil 会移除键值对（iOS 6.0+ 行为）
    //    dict[@"Key"] = nil;
    
    
    LLUserModel * model;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    NSString * key;
    [dict setObject:model forKeyedSubscript:key];
    
}

//MARK: - Delgate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO;
}

@end
