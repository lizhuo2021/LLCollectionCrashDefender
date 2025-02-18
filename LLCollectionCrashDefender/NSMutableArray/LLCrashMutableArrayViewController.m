//
//  LLCrashMutableArrayViewController.m
//  LLOCKnowledge
//
//  Created by 李琢琢 on 2025/2/18.
//

#import "LLCrashMutableArrayViewController.h"
#import "LLCollectionExceptionHandler.h"
#import "LLUserModel.h"

@interface LLCrashMutableArrayViewController ()<UITextViewDelegate>

@property(nonatomic, strong) UITextView *loggerView;

@end

@implementation LLCrashMutableArrayViewController

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
    
    self.title = @"NSMutableArray Crash";
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
        UIButton * button = [self createBlackButtonWithTitle:@"__NSArrayM objectAtIndex:" target:self action:@selector(testObjectAtIndex)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, statusBarHeight + navigationBarHeight + 10, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    //objectAtIndexedSubscript
    if (@available(iOS 11.0, *)) {
        {
            UIButton * button = [self createBlackButtonWithTitle:@"__NSArrayM objectAtIndexedSubscript:" target:self action:@selector(testObjectAtIndexedSubscript)];
            [self.view addSubview:button];
            
            button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
            lastButton = button;
        }
    }
    
    //setObject:atIndexedSubscript:
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSArrayM setObject:atIndexedSubscript:" target:self action:@selector(testSetObjectAtIndexedSubscript)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    //removeObjectAtIndex:
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSArrayM removeObjectAtIndex:" target:self action:@selector(testRemoveObjectAtIndex)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    //insertObject:atIndex:
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSArrayM insertObject:atIndex:" target:self action:@selector(testInsertObjectAtIndex)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    //insertObjects:atIndexes:
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSArrayM insertObjects:atIndexes:" target:self action:@selector(testInsertObjectsAtIndexes)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    //getObjects:range:
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSArrayM getObjects:range:" target:self action:@selector(testGetObjectsRange)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
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


//objectAtIndex:
- (void)testObjectAtIndex {
    
    NSMutableArray * array = [NSMutableArray array];
    
    LLUserModel * item = [LLUserModel new];
    item.name = @"张三";
    item.age = 25;
    
    [array addObject:item];
    
    [array objectAtIndex:3];
    
}

- (void)testObjectAtIndexedSubscript {
    
    NSMutableArray * array = [NSMutableArray array];
    
    LLUserModel * item = [LLUserModel new];
    item.name = @"张三";
    item.age = 25;
    
    [array addObject:item];
    
    [array objectAtIndexedSubscript:3];
    
}

//setObject:atIndexedSubscript:
- (void)testSetObjectAtIndexedSubscript {
    
    NSMutableArray * array = [NSMutableArray array];
    
    LLUserModel * item = [LLUserModel new];
    item.name = @"张三";
    item.age = 25;
    
    [array addObject:item];
    
    LLUserModel * item1 = [LLUserModel new];
    item1.name = @"李四";
    item1.age = 25;
    
    [array setObject:item1 atIndexedSubscript:10];
    
}


//removeObjectAtIndex:
- (void)testRemoveObjectAtIndex {
    
    NSMutableArray * array = [NSMutableArray array];
    
    LLUserModel * item = [LLUserModel new];
    item.name = @"张三";
    item.age = 25;
    
    [array addObject:item];
    
    [array removeObjectAtIndex:5];
       
}


//insertObject:atIndex:
- (void)testInsertObjectAtIndex{
    
    NSMutableArray * array = [NSMutableArray array];
    
    LLUserModel * item = [LLUserModel new];
    item.name = @"张三";
    item.age = 25;
    
    [array addObject:item];
    
    LLUserModel * item1 = [LLUserModel new];
    item1.name = @"李四";
    item1.age = 25;
    
    [array insertObject:item1 atIndex:3];
    
    
}


//insertObjects:atIndexes:

- (void)testInsertObjectsAtIndexes{
    
    NSMutableArray * array = [NSMutableArray array];
    
    LLUserModel * item = [LLUserModel new];
    item.name = @"张三";
    item.age = 25;
    
    [array addObject:item];
    
    LLUserModel * item1 = [LLUserModel new];
    item1.name = @"李四";
    item1.age = 25;
    
    LLUserModel * item2 = [LLUserModel new];
    item1.name = @"李五";
    item1.age = 25;
    
    NSIndexSet * set = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(5, 3)];
    [array insertObjects:@[item1, item2] atIndexes:set];
    
    
}

//getObjects:range:
- (void)testGetObjectsRange{
    
    NSMutableArray *array = @[@"A", @"B", @"C", @"D", @"E"].mutableCopy;
    NSRange range = NSMakeRange(9, 3); // 获取索引 1~3 的对象（B, C, D）
    
    // 1. 分配内存
    id __unsafe_unretained *objects = (id __unsafe_unretained *)malloc(sizeof(id) * range.length);
    
    // 2. 批量获取对象
    [array getObjects:objects range:range];
    
    // 3. 使用对象
    for (NSUInteger i = 0; i < range.length; i++) {
        NSLog(@"Object at index %lu: %@", i, objects[i]);
    }
    
    // 4. 释放内存
    free(objects);
}

//MARK: - Delgate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO;
}

@end
