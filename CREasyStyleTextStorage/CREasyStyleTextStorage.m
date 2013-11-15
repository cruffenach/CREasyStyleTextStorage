//
//  CREasyStyleTextStorage.m
//  
//
//  Created by Collin Ruffenach on 11/15/13.
//
//

#import "CREasyStyleTextStorage.h"

@interface CREasyStyleTextStorage ()
@property (nonatomic, strong) NSMutableAttributedString *backingStore;
@property (nonatomic, strong) NSMutableDictionary *attributes;
@end

#define kCRESTSDefaultAttributeKey @"kSFCRESTSDefaultAttributeKey"

@implementation CREasyStyleTextStorage

- (id)init {
    if (self = [super init]) {
        self.backingStore = [NSMutableAttributedString new];
        self.attributes = [@{} mutableCopy];
    }
    return self;
}

- (void)setDefaultAttributes:(NSDictionary*)attributes {
    self.attributes[kCRESTSDefaultAttributeKey] = attributes;
}

- (void)setAttributes:(NSDictionary*)attributes forString:(NSString*)string {
    self.attributes[string] = attributes;
}

#pragma mark - Overrides

- (NSString *)string {
    return [self.backingStore string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location
                     effectiveRange:(NSRangePointer)range {
    return [self.backingStore attributesAtIndex:location
                                 effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [self.backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters
           range:range
  changeInLength:(NSInteger)str.length - (NSInteger)range.length];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range {
    [self.backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}

- (void)processEditing {
    
    NSAssert(self.attributes[kCRESTSDefaultAttributeKey] != nil, @"ERROR: CREasyStyleTextStorage default attributes not set");
    
    [super processEditing];
    [self addAttributes:self.attributes[kCRESTSDefaultAttributeKey]
                  range:NSMakeRange(0, self.string.length)];
    
    for (NSString *key in self.attributes.allKeys) {
        if (![key isEqualToString:kCRESTSDefaultAttributeKey]) {
            NSString *pattern = key;
            NSRegularExpression *iExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:NULL];
            NSRange paragaphRange = [self.string paragraphRangeForRange:self.editedRange];
            __weak typeof(self) blockSelf = self;
            [iExpression enumerateMatchesInString:self.string options:0 range:paragaphRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                [self addAttributes:blockSelf.attributes[key] range:result.range];
            }];

        }
    }
}


@end