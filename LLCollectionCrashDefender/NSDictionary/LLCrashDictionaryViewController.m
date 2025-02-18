//
//  LLCrashDictionaryViewController.m
//  LLCollectionCrashDefender
//
//  Created by 李琢琢 on 2025/2/18.
//

#import "LLCrashDictionaryViewController.h"

#import "LLCollectionExceptionHandler.h"
#import "LLUserModel.h"

@interface LLCrashDictionaryViewController ()<UITextViewDelegate>

@property(nonatomic, strong) UITextView *loggerView;

@end

@implementation LLCrashDictionaryViewController

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
    
    self.title = @"NSDictionary Crash";
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
    

    //objectAtIndex:
    {
        UIButton * button = [self createBlackButtonWithTitle:@"NSDictionary use nil init" target:self action:@selector(testDictionaryAddNilObject)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, statusBarHeight + navigationBarHeight + 10, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
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

- (void)testDictionaryAddNilObject {

    LLUserModel * item1 = [LLUserModel new];
    item1.name = @"123123123123131";
    item1.age = 99;

    LLUserModel * item2;

    LLUserModel * item3 = [LLUserModel new];
    item3.name = @"123123123123131";
    item3.age = 99;

//    +[NSDictionary dictionaryWithObjects:forKeys:count:]
//    -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]
    NSDictionary * dict = @{@"model1":item1, @"model2":item2};

}

//MARK: - Delgate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO;
}

@end
