# LBTagView

![gif][image-1]

### What

LBTagView is useful to add tag to image or other views. It is intelligent, you can drag where you want.It’s easy to use wit h simple API.You can set its colors and font what you like.

### Requirements

iOS 7 and later ARC

### Usage

It is easy to use. You just need to creat a tagView ,set its text and add view you want,that’s all.

	LBTagView *tag = [[LBTagView alloc] initWithFrame:CGRectMake(50, 300, 100, 100)];
	tag.text = @"hello world";
	[self.view addSubview:tag];

#### Customization

	//is can be moved
	@property (nonatomic, assign) BOOL canMove;
	
	//text
	@property (nonatomic, copy) NSString *text;
	
	//default [UIColor whiteColor]
	@property (nonatomic, strong) UIColor *textColor;
	
	//default [UIFont systemFontOfSize:12]
	@property (nonatomic, strong) UIFont *font;
	
	//default [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
	@property (nonatomic, strong) UIColor *backgroundColor;
	
	//default [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]
	@property (nonatomic, strong) UIColor *circlrColor;
	
	//default [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]
	@property (nonatomic, strong) UIColor *circlrShadowColor;
	
	//tap action
	@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

### Example

For more information, you can download the zip and run the example.

### License

LBTagView is available under the MIT license. See the LICENSE file for more info.

[image-1]:	http://ww2.sinaimg.cn/large/9f1201f5jw1ezy0tidf6ng20ag0ij4qp.gif