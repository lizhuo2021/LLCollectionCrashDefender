//
//  NSDictionary+LLSafe.m
//  LLCollectionCrashDefender
//
//  Created by 李琢琢 on 2025/2/18.
//

#import "NSDictionary+LLSafe.h"
#import "NSObject+LLMethodSwizzling.h"
#import "LLCollectionExceptionHandler.h"

@implementation NSDictionary (LLSafe)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString * NSPlaceholderDictionary = @"__NSPlaceholderDictionary";
        
        [self ll_defenderSwizzlingInstanceMethod:@selector(initWithObjects:forKeys:count:)
                                      withMethod:@selector(ll_NSPlaceholderDictionary_initWithObjects:forKeys:count:)
                                       withClass:NSClassFromString(NSPlaceholderDictionary)];
        
    });
    
}

- (instancetype)ll_NSPlaceholderDictionary_initWithObjects:(id  _Nonnull const[])objects forKeys:(id<NSCopying>  _Nonnull const[])keys count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self ll_NSPlaceholderDictionary_initWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        [LLCollectionExceptionHandler exceptionHandlerWithException:exception];
                
        //手动将nil去除。
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self ll_NSPlaceholderDictionary_initWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}


@end
