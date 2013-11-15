//
//  CREasyStyleTextStorage.h
//  
//
//  Created by Collin Ruffenach on 11/15/13.
//
//

#import <UIKit/UIKit.h>

@interface CREasyStyleTextStorage : NSTextStorage

- (void)setDefaultAttributes:(NSDictionary*)attributes;
- (void)setAttributes:(NSDictionary*)attributes forString:(NSString*)string;

@end