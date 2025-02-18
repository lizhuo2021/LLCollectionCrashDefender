//
//  NSMutableDictionary+LLSafe.m
//  LLCollectionCrashDefender
//
//  Created by 李琢琢 on 2025/2/18.
//

#import "NSMutableDictionary+LLSafe.h"
#import "NSObject+LLMethodSwizzling.h"
#import "LLCollectionExceptionHandler.h"

@implementation NSMutableDictionary (LLSafe)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString * NSDictionaryM = @"__NSDictionaryM";
        
        //setObject:forKey:
        [self ll_defenderSwizzlingInstanceMethod:@selector(setObject:forKey:)
                                      withMethod:@selector(ll_NSDictionaryM_setObject:forKey:)
                                       withClass:NSClassFromString(NSDictionaryM)];
        
        //setObject:forKeyedSubscript:
        [self ll_defenderSwizzlingInstanceMethod:@selector(setObject:forKeyedSubscript:)
                                      withMethod:@selector(ll_NSDictionaryM_setObject:forKeyedSubscript:)
                                       withClass:NSClassFromString(NSDictionaryM)];
        
        //removeObjectForKey:
        [self ll_defenderSwizzlingInstanceMethod:@selector(removeObjectForKey:)
                                      withMethod:@selector(ll_NSDictionaryM_removeObjectForKey:)
                                       withClass:NSClassFromString(NSDictionaryM)];
        
    });
}


- (void)ll_NSDictionaryM_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    @try {
        
        [self ll_NSDictionaryM_setObject:anObject forKey:aKey];
        
    }
    @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    }
    @finally {
        
    }
    
}

- (void)ll_NSDictionaryM_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    
    @try {
        
        [self ll_NSDictionaryM_setObject:obj forKeyedSubscript:key];
        
    }
    @catch (NSException *exception) {
     
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    }
    @finally {
        
    }
}

- (void)ll_NSDictionaryM_removeObjectForKey:(id)aKey {
    @try {
        [self ll_NSDictionaryM_removeObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
        
    }
    @finally {
        
    }
}


@end
