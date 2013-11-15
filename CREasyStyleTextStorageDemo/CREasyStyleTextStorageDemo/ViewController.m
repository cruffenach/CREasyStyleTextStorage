//
//  ViewController.m
//  CREasyStyleTextStorageDemo
//
//  Created by Collin Ruffenach on 11/15/13.
//  Copyright (c) 2013 Notion. All rights reserved.
//

#import "ViewController.h"
#import "CREasyStyleTextStorage.h"

@interface ViewController ()
@property (nonatomic, retain) UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CREasyStyleTextStorage *textStorage = [[CREasyStyleTextStorage alloc] init];
    [textStorage setDefaultAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                        NSForegroundColorAttributeName : [UIColor blackColor]}];
    [textStorage setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forString:@"@"];
    [textStorage setAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]} forString:@"#"];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:self.view.bounds.size];
    [layoutManager addTextContainer:container];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:container];
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.textView.frame = self.view.bounds;
    self.textView.contentInset = UIEdgeInsetsMake([self.topLayoutGuide length], 0, [self.bottomLayoutGuide length], 0);
}

@end
