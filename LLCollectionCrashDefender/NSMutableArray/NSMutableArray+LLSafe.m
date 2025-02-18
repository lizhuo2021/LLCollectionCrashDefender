//
//  NSMutableArray+LLSafe.m
//  LLOCKnowledge
//
//  Created by 李琢琢 on 2025/2/18.
//

#import "NSMutableArray+LLSafe.h"
#import "NSObject+LLMethodSwizzling.h"
#import "LLCollectionExceptionHandler.h"

@implementation NSMutableArray (LLSafe)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString * NSArrayM = @"__NSArrayM";
        
        
        //objectAtIndex:
        [self ll_defenderSwizzlingInstanceMethod:@selector(objectAtIndex:) withMethod:@selector(ll_NSArrayM_objectAtIndex:) withClass:NSClassFromString(NSArrayM)];
        
        //objectAtIndexedSubscript
        if (@available(iOS 11.0, *)) {
            [self ll_defenderSwizzlingInstanceMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(ll_NSArrayM_objectAtIndexedSubscript:) withClass:NSClassFromString(NSArrayM)];
        }
        
        //setObject:atIndexedSubscript:
        [self ll_defenderSwizzlingInstanceMethod:@selector(setObject:atIndexedSubscript:) withMethod:@selector(ll_NSArrayM_setObject:atIndexedSubscript:) withClass:NSClassFromString(NSArrayM)];
        
        //removeObjectAtIndex:
        [self ll_defenderSwizzlingInstanceMethod:@selector(removeObjectAtIndex:) withMethod:@selector(ll_NSArrayM_removeObjectAtIndex:) withClass:NSClassFromString(NSArrayM)];
        
        //insertObject:atIndex:
        [self ll_defenderSwizzlingInstanceMethod:@selector(insertObject:atIndex:) withMethod:@selector(ll_NSArrayM_insertObject:atIndex:) withClass:NSClassFromString(NSArrayM)];
        
        //insertObjects:atIndexes:
        [self ll_defenderSwizzlingInstanceMethod:@selector(insertObjects:atIndexes:) withMethod:@selector(ll_NSArrayM_insertObjects:atIndexes:) withClass:NSClassFromString(NSArrayM)];
        
        
        //getObjects:range:
        [self ll_defenderSwizzlingInstanceMethod:@selector(getObjects:range:) withMethod:@selector(ll_NSArrayM_getObjects:range:) withClass:NSClassFromString(NSArrayM)];
        
        
    });
    
}


- (id)ll_NSArrayM_objectAtIndex:(NSUInteger)index {
    id result = nil;
    
    @try {
        
        result = [self ll_NSArrayM_objectAtIndex:index];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
        return result;
        
    }
}

- (id)ll_NSArrayM_objectAtIndexedSubscript:(NSUInteger)idx {
    id result = nil;
    
    @try {
        
        result = [self ll_NSArrayM_objectAtIndexedSubscript:idx];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
        return result;
        
    }
}

- (void)ll_NSArrayM_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {

    @try {
        
        [self ll_NSArrayM_setObject:obj atIndexedSubscript:idx];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
    
        
    }
}

- (void)ll_NSArrayM_removeObjectAtIndex:(NSUInteger)index {
 
    @try {
        
        [self ll_NSArrayM_removeObjectAtIndex:index];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        

    }
}

- (void)ll_NSArrayM_insertObject:(id)anObject atIndex:(NSUInteger)index {

    @try {
        
        [self ll_NSArrayM_insertObject:anObject atIndex:index];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
    }
}

- (void)ll_NSArrayM_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {

    @try {
        
        [self ll_NSArrayM_insertObjects:objects atIndexes:indexes];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
    }
}

- (void)ll_NSArrayM_getObjects:(id  _Nonnull __unsafe_unretained[])objects range:(NSRange)range {
    
    @try {
        
        [self ll_NSArrayM_getObjects:objects range:range];
        
    } @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    } @finally {
        
    }
}

@end
