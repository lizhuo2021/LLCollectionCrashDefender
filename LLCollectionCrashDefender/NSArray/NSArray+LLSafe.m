//
//  NSArray+LLSafe.m
//  LLOCKnowledge
//
//  Created by 李琢琢 on 2025/2/18.
//

#import "NSArray+LLSafe.h"
#import "NSObject+LLMethodSwizzling.h"
#import "LLCollectionExceptionHandler.h"

@implementation NSArray (LLSafe)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // alloc之后，生成__NSPlaceholderArray，在通过工厂模式生成具体类。
        NSString * NSPlaceholderArray = @"__NSPlaceholderArray";
        
        NSString * NSArray = @"NSArray";
        // NSArray类簇下的真实类名字符串
        NSString * NSArray0 = @"__NSArray0";
        NSString * NSSingleObjectArrayI = @"__NSSingleObjectArrayI";
        NSString * NSArrayI = @"__NSArrayI";
//        iOS13新增
        NSString * NSConstantArray = @"NSConstantArray";
        
//        对于NSArray 需要处理的方法
        
//        objectAtIndex方法分别对应3个子类，有三个实现
        NSString * safeObjectAtIndex4NSArray0 = @"ll_NSArray0_objectAtIndex:";
        NSString * safeObjectAtIndex4NSSingleObjectArrayI = @"ll_NSSingleObjectArrayI_objectAtIndex:";
        NSString * safeObjectAtIndex4NSArrayI = @"ll_NSArrayI_objectAtIndex:";
        NSString * safeObjectAtIndex4NSConstantArray = @"ll_NSConstantArray_objectAtIndex:";
        
        
//        objectsAtIndexes 处理
        NSString * safeObjectsAtIndexes4NSArray = @"ll_NSArray_objectsAtIndexes:";
        
//        objectAtIndexedSubscript 的处理
//        对于objectAtIndexedSubscript，只有__NSArrayI一个实现。
        NSString * safeObjectAtIndexedSubscript4NSArrayI = @"ll_NSArrayI_objectAtIndexedSubscript:";
        
        
//        开始交换
        
//        通过 NSArray * array = @[item1, item2, item3]; 创建的。会执行到
//        +[NSArray arrayWithObjects:count:]
//        -[__NSPlaceholderArray initWithObjects:count:]
//        如果存在nil，会触发crash
    
//        initWithObjects:count:
        [self ll_defenderSwizzlingInstanceMethod:@selector(initWithObjects:count:)
                                      withMethod:@selector(ll_NSPlaceholderArray_initWithObjects:count:)
                                          withClass:NSClassFromString(NSPlaceholderArray)];
        
//        objectAtIndex:
        [self ll_defenderSwizzlingInstanceMethod:@selector(objectAtIndex:)
                                         withMethod:NSSelectorFromString(safeObjectAtIndex4NSConstantArray)
                                          withClass:NSClassFromString(NSConstantArray)];
        
        [self ll_defenderSwizzlingInstanceMethod:@selector(objectAtIndex:)
                                         withMethod:NSSelectorFromString(safeObjectAtIndex4NSArray0)
                                          withClass:NSClassFromString(NSArray0)];
        
        [self ll_defenderSwizzlingInstanceMethod:@selector(objectAtIndex:)
                                         withMethod:NSSelectorFromString(safeObjectAtIndex4NSSingleObjectArrayI)
                                          withClass:NSClassFromString(NSSingleObjectArrayI)];
        
        [self ll_defenderSwizzlingInstanceMethod:@selector(objectAtIndex:)
                                         withMethod:NSSelectorFromString(safeObjectAtIndex4NSArrayI)
                                          withClass:NSClassFromString(NSArrayI)];
        
//        objectAtIndexedSubscript
        [self ll_defenderSwizzlingInstanceMethod:@selector(objectAtIndexedSubscript:)
                                         withMethod:NSSelectorFromString(safeObjectAtIndexedSubscript4NSArrayI)
                                          withClass:NSClassFromString(NSArrayI)];

//        objectsAtIndexes
        [self ll_defenderSwizzlingInstanceMethod:@selector(objectsAtIndexes:)
                                         withMethod:NSSelectorFromString(safeObjectsAtIndexes4NSArray)
                                          withClass:NSClassFromString(NSArray)];

        
        //        getObjects:range:
        [self ll_defenderSwizzlingInstanceMethod:@selector(getObjects:range:)
                                         withMethod:@selector(ll_NSArray_getObjects:range:)
                                       withClass:NSClassFromString(NSArray)];
        
        [self ll_defenderSwizzlingInstanceMethod:@selector(getObjects:range:)
                                         withMethod:@selector(ll_NSConstantArray_getObjects:range:)
                                          withClass:NSClassFromString(NSConstantArray)];
        
        [self ll_defenderSwizzlingInstanceMethod:@selector(getObjects:range:)
                                         withMethod:@selector(ll_NSSingleObjectArrayI_getObjects:range:)
                                       withClass:NSClassFromString(NSSingleObjectArrayI)];
        
        [self ll_defenderSwizzlingInstanceMethod:@selector(getObjects:range:)
                                         withMethod:@selector(ll_NSArrayI_getObjects:range:)
                                       withClass:NSClassFromString(NSArrayI)];
        
    });
    
}

//MARK: - initWithObjects:count:

- (instancetype)ll_NSPlaceholderArray_initWithObjects:(id  _Nonnull const[])objects count:(NSUInteger)cnt {
 
    id instance = nil;
    
    @try {
        instance = [self ll_NSPlaceholderArray_initWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
          
        //手动将nil去除。
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex ++;
            }
        }
        instance = [self ll_NSPlaceholderArray_initWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
    
}

//MARK: - objectAtIndex:

- (id)ll_NSArray0_objectAtIndex:(NSUInteger)index {
//    方式一：增加判断
    //    if (index >= self.count) {
    //        return nil;
    //    }
    //    return [self ll_arr0_objectAtIndex:index];
    
//    方式二：使用try catch
    id result = nil;
    
    @try {
        
        result = [self ll_NSArray0_objectAtIndex:index];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
        return result;
        
    }
}

- (id)ll_NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index {
    
    id result = nil;
    
    @try {
        
        result = [self ll_NSSingleObjectArrayI_objectAtIndex:index];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
        return result;
        
    }
    
}

- (id)ll_NSArrayI_objectAtIndex:(NSUInteger)index {
    
    id result = nil;
    
    @try {
        
        result = [self ll_NSArrayI_objectAtIndex:index];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
        return result;
        
    }
}

- (id)ll_NSConstantArray_objectAtIndex:(NSUInteger)index {
    
    id result = nil;
    
    @try {
        
        result = [self ll_NSConstantArray_objectAtIndex:index];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
        return result;
        
    }
}



//MARK: - objectAtIndexedSubscript:
- (id)ll_NSArrayI_objectAtIndexedSubscript:(NSUInteger)index {
    id result = nil;
    @try {
        result = [self ll_NSArrayI_objectAtIndexedSubscript:index];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
        return result;
        
    }
}

//MARK: - objectsAtIndexes:
- (NSArray *)ll_NSArray_objectsAtIndexes:(NSIndexSet *)indexes {
    
    NSArray *returnArray = nil;
    
    @try {
        
        returnArray = [self ll_NSArray_objectsAtIndexes:indexes];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
        return returnArray;
        
    }
}

//MARK: - getObjects:range:
//NSArray getObjects:range:
- (void)ll_NSArray_getObjects:(id  _Nonnull __unsafe_unretained[])objects range:(NSRange)range {
    
    @try {
        
        [self ll_NSArray_getObjects:objects range:range];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
    }
}


//__NSSingleObjectArrayI  getObjects:range:
- (void)ll_NSSingleObjectArrayI_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        
        [self ll_NSSingleObjectArrayI_getObjects:objects range:range];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
    }
}


//__NSArrayI  getObjects:range:
- (void)ll_NSArrayI_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        
        [self ll_NSArrayI_getObjects:objects range:range];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
    }
}

//NSConstantArray  getObjects:range:
- (void)ll_NSConstantArray_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self ll_NSConstantArray_getObjects:objects range:range];
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
    }
}


@end
