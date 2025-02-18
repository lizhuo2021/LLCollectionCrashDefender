//
//  LLCrashArrayViewController.m
//  LLOCKnowledge
//
//  Created by 李琢琢 on 2025/2/18.
//

#import "LLCrashArrayViewController.h"
#import "LLCollectionExceptionHandler.h"
#import "LLUserModel.h"


@interface LLCrashArrayViewController ()<UITextViewDelegate>

@property(nonatomic, strong) UITextView *loggerView;

@end

@implementation LLCrashArrayViewController

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
    
    self.title = @"NSArray Crash";
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
    
//    MARK: objectAtIndex:
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSArray0 objectAtIndex" target:self action:@selector(testObjectAtIndex4Array0)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, statusBarHeight + navigationBarHeight + 10, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSSingleObjectArrayI objectAtIndex" target:self action:@selector(testObjectAtIndex4SingleObjectArrayI)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSArrayI objectAtIndex" target:self action:@selector(testObjectAtIndex4ArrayI)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    {
        UIButton * button = [self createBlackButtonWithTitle:@"NSConstantArray objectAtIndex" target:self action:@selector(testObjectAtIndex4NSConstantArray)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    
    // MARK: objectsAtIndexes:
    {
        UIButton * button = [self createBlackButtonWithTitle:@"NSArray objectsAtIndexes:" target:self action:@selector(testObjectsAtIndexes4NSArray)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    // MARK: getObjects:range:
    
    {
        UIButton * button = [self createBlackButtonWithTitle:@"NSArray getObjects:range:" target:self action:@selector(testGetObjectsRange4NSArray)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSSingleObjectArrayI getObjects:range:" target:self action:@selector(testGetObjectsRange4NSSingleObjectArrayI)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    
    {
        UIButton * button = [self createBlackButtonWithTitle:@"__NSArrayI getObjects:range:" target:self action:@selector(testGetObjectsRange4NSArrayI)];
        [self.view addSubview:button];
        
        button.frame = CGRectMake(15, CGRectGetMaxY(lastButton.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 30);
        lastButton = button;
    }
    
    
    {
        UIButton * button = [self createBlackButtonWithTitle:@"NSConstantArray getObjects:range:" target:self action:@selector(testGetObjectsRange4NSConstantArray)];
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


// MARK: objectAtIndex:
- (void)testObjectAtIndex4Array0 {
    
    NSArray * array = [NSArray array];
    
    [array objectAtIndex:10];
    
    
}


- (void)testObjectAtIndex4SingleObjectArrayI {
    
    LLUserModel * item = [LLUserModel new];
    item.name = @"123123123123131";
    item.age = 99;
    NSArray * array = @[item];
    
    [array objectAtIndex:10];
}


- (void)testObjectAtIndex4ArrayI {
    
    LLUserModel * item1 = [LLUserModel new];
    item1.name = @"123123123123131";
    item1.age = 99;
    
//    LLUserModel * item2 = [LLUserModel new];
//    item2.name = @"123123123123131";
//    item2.age = 99;
    
    LLUserModel * item2;
    
    LLUserModel * item3 = [LLUserModel new];
    item3.name = @"123123123123131";
    item3.age = 99;
    
    NSArray * array = @[item1, item2, item3];

    
    
//    NSArray * newArray = []
    
    [array objectAtIndex:10];
    
}

- (void)testObjectAtIndex4NSConstantArray {
    
    NSArray * array = @[@"12阿斯蒂芬阿斯蒂芬阿是3", @"阿斯顿发山东发斯蒂芬阿斯蒂芬阿是", @"阿斯蒂芬阿斯顿发山东发生的"];
    
    [array objectAtIndex:10];
    
}

// MARK: objectsAtIndexes:
- (void)testObjectsAtIndexes4NSArray {
    
    LLUserModel * item1 = [LLUserModel new];
    item1.name = @"123123123123131";
    item1.age = 99;
    
    LLUserModel * item2 = [LLUserModel new];
    item2.name = @"123123123123131";
    item2.age = 99;
    
    LLUserModel * item3 = [LLUserModel new];
    item3.name = @"123123123123131";
    item3.age = 99;
    
    NSArray * array = @[item1, item2, item3];
    
    NSIndexSet * set = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(10, 10)];
    [array objectsAtIndexes:set];
    
    
}

// MARK: getObjects:range:

/// NSArray
- (void)testGetObjectsRange4NSArray {
    
    NSArray * array = [NSArray array];
    
    NSRange range = NSMakeRange(4, 3);
    
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

/// __NSSingleObjectArrayI
- (void)testGetObjectsRange4NSSingleObjectArrayI {
    
    LLUserModel * item1 = [LLUserModel new];
    item1.name = @"123123123123131";
    item1.age = 99;
    
    NSArray * array = @[item1];
    
    NSRange range = NSMakeRange(4, 3);
    
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

/// __NSArrayI
- (void)testGetObjectsRange4NSArrayI {
    
    LLUserModel * item1 = [LLUserModel new];
    item1.name = @"123123123123131";
    item1.age = 99;
    
    LLUserModel * item2 = [LLUserModel new];
    item2.name = @"123123123123131";
    item2.age = 99;

    LLUserModel * item3 = [LLUserModel new];
    item3.name = @"123123123123131";
    item3.age = 99;
    
    NSArray * array = @[item1, item2, item3];
    
    NSRange range = NSMakeRange(4, 3);
    
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

- (void)testGetObjectsRange4NSConstantArray{
    
    NSArray *array = @[@"A", @"B", @"C", @"D", @"E"];
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
