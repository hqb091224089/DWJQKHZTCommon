//
//  DWJQJSONResponseSerializer.m
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQJSONResponseSerializer.h"
#import "DWJQEncryptHelper.h"


@implementation DWJQJSONResponseSerializer

static NSError * AFErrorWithUnderlyingError(NSError *error, NSError *underlyingError) {
    if (!error) {
        return underlyingError;
    }
    
    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }
    
    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    
    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}

static BOOL AFErrorOrUnderlyingErrorHasCodeInDomain(NSError *error, NSInteger code, NSString *domain) {
    if ([error.domain isEqualToString:domain] && error.code == code) {
        return YES;
    } else if (error.userInfo[NSUnderlyingErrorKey]) {
        return AFErrorOrUnderlyingErrorHasCodeInDomain(error.userInfo[NSUnderlyingErrorKey], code, domain);
    }
    
    return NO;
}

static id AFJSONObjectDWJQRemovingKeysWithNullValues(id JSONObject, NSJSONReadingOptions readingOptions) {
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)JSONObject count]];
        for (id value in (NSArray *)JSONObject) {
            [mutableArray addObject:AFJSONObjectDWJQRemovingKeysWithNullValues(value, readingOptions)];
        }
        
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableArray : [NSArray arrayWithArray:mutableArray];
    } else if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:JSONObject];
        for (id <NSCopying> key in [(NSDictionary *)JSONObject allKeys]) {
            id value = [(NSDictionary *)JSONObject objectForKey:key];
            if (!value || [value isEqual:[NSNull null]]) {
                [mutableDictionary removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                [mutableDictionary setObject:AFJSONObjectDWJQRemovingKeysWithNullValues(value, readingOptions) forKey:key];
            }
        }
        
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableDictionary : [NSDictionary dictionaryWithDictionary:mutableDictionary];
    }
    
    return JSONObject;
}

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    return self;
    
}

//- (id)responseObjectForResponse:(NSURLResponse *)response
//                           data:(NSData *)data
//                          error:(NSError *__autoreleasing *)error
//{
//    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
//        if (!error || AFErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, AFURLResponseSerializationErrorDomain)) {
//            return nil;
//        }
//    }
//    
//    // Workaround for behavior of Rails to return a single space for `head :ok` (a workaround for a bug in Safari), which is not interpreted as valid input DWJQ NSJSONSerialization.
//    // See https://github.com/rails/rails/issues/1742
//    NSStringEncoding stringEncoding = self.stringEncoding;
//    if (response.textEncodingName) {
//        CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)response.textEncodingName);
//        if (encoding != kCFStringEncodingInvalidId) {
//            stringEncoding = CFStringConvertEncodingToNSStringEncoding(encoding);
//        }
//    }
//    
//    id responseObject = nil;
//    NSError *serializationError = nil;
//    @autoreleasepool {
//        NSString *responseString = [[NSString alloc] initWithData:data encoding:stringEncoding];
//        
//        // DWJQ decrypt
//        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response ;
//            NSString *token = [[res allHeaderFields] objectForKey:kDWJQEncryptHeaderKey];
//            if (token && token.length > 0) {
//                responseString = [DWJQEncryptHelper decrypt:responseString key:token];
//            }
//        }
//        
//        if (responseString && ![responseString isEqualToString:@" "]) {
//            // Workaround for a bug in NSJSONSerialization when Unicode character escape codes are used instead of the actual character
//            // See http://stackoverflow.com/a/12843465/157142
//            data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
//            
//            if (data) {
//                if ([data length] > 0) {
//                    responseObject = [NSJSONSerialization JSONObjectWithData:data options:self.readingOptions error:&serializationError];
//                } else {
//                    return nil;
//                }
//            } else {
//                NSDictionary *userInfo = @{
//                                           NSLocalizedDescriptionKey: NSLocalizedStringFromTable(@"Data failed decoding as a UTF-8 string", @"AFNetworking", nil),
//                                           NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:NSLocalizedStringFromTable(@"Could not decode string: %@", @"AFNetworking", nil), responseString]
//                                           };
//                
//                serializationError = [NSError errorWithDomain:AFURLResponseSerializationErrorDomain code:NSURLErrorCannotDecodeContentData userInfo:userInfo];
//            }
//        }
//    }
//    
//    if (self.removesKeysWithNullValues && responseObject) {
//        responseObject = AFJSONObjectDWJQRemovingKeysWithNullValues(responseObject, self.readingOptions);
//    }
//    
//    if (error) {
//        *error = AFErrorWithUnderlyingError(serializationError, *error);
//    }
//    
//    return responseObject;
//}

@end
