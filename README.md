## CREasyStyleTextStorage

`CREasyStyleTextStorage` is a `NSTextStorage` subclass that provides a convinent way to apply distinct styles to substrings. There is a demo project showing a general use case for it. PR's and Issues welcome. Lots more functionality to come.

### Basic Usage

`CREasyStyleTextStorage` allows for specific strings to have unique styling. Configuring and using in a `UITextView` would look something like this.

```objective-c
CREasyStyleTextStorage *textStorage = [[CREasyStyleTextStorage alloc] init];

// Set default attributes

[textStorage setDefaultAttributes:@{NSFontAttributeName 			: [UIFont systemFontOfSize:14],
                                    NSForegroundColorAttributeName 	: [UIColor blackColor]}];

// Make '@' symbols red

[textStorage setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} 
				 forString:@"@"];

// Make '#' symbols green

[textStorage setAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]} 
				 forString:@"#"];

NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
[textStorage addLayoutManager:layoutManager];
NSTextContainer *container = [[NSTextContainer alloc] initWithSize:self.view.bounds.size];
[layoutManager addTextContainer:container];

UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:container];
[self.view addSubview:textView];
```