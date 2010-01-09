@interface StrokedView : UIView {
	float roundness;
	float width;
	UIColor* color;	
	NSArray* pattern;
	float* rawPattern;
}

@property(assign) float roundness;
@property(assign) float width;
@property(retain) UIColor* color;	
@property(retain) NSArray* pattern;	


@end
