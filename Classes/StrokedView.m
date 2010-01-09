#import "StrokedView.h"


@implementation StrokedView
@synthesize roundness;
@synthesize width;
@synthesize color;
@synthesize pattern;

#pragma mark private

-(void)privateInit{
	self.roundness = 0.5;
	self.width = 5;
	self.color = [UIColor grayColor];
	self.pattern = [NSArray arrayWithObjects:[NSNumber numberWithFloat: 10], [NSNumber numberWithFloat: 10], nil];	
}

-(void)calcRawPattern{
	if(rawPattern) free(rawPattern);
	rawPattern = malloc(sizeof(float) * pattern.count);
	for(int i = 0; i < pattern.count; i++){
		rawPattern[i] = [[pattern objectAtIndex:i] floatValue];
	}
}

-(float)radiusFor: (CGRect)rect{
	float w = CGRectGetWidth(rect);
	float h = CGRectGetHeight(rect);
	float base = fmin(w, h);
	return base/2*roundness;
}

#pragma mark properties

- (void) setPattern:(NSArray*)_pattern{
    [_pattern retain];
    [pattern release];
    pattern = _pattern;
	
	[self calcRawPattern];
}
            

#pragma mark UIView

- (void) dealloc{
	if(rawPattern){
		free(rawPattern);
		rawPattern = NULL;
	}
	[pattern release];
	[color release];
	[super dealloc];
}


- (void) awakeFromNib{
	[super awakeFromNib];
	[self privateInit];
}


- (id) initWithFrame: (CGRect)frame{
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self privateInit];
	}
	return self;
}

- (void)drawRect:(CGRect)rect{
	[super drawRect:rect];
	
	rect = CGRectInset(rect, width/2, width/2);
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();	
	
	CGContextSetStrokeColorWithColor(ctx, color.CGColor);
	CGContextSetLineWidth(ctx, width);
	CGContextSetLineDash(ctx, 0, rawPattern, pattern.count);	
	
	const float R = [self radiusFor: rect];

	const float l = CGRectGetMinX(rect);
	const float r = CGRectGetMaxX(rect);
	const float t = CGRectGetMinY(rect);
	const float b = CGRectGetMaxY(rect);			
	
	CGContextMoveToPoint(ctx, l, t+R);
	CGContextAddArcToPoint(ctx, l, t, l+R, t, R);	
	CGContextAddLineToPoint(ctx, r-R, t);
	CGContextAddArcToPoint(ctx, r, t, r, t+R, R);	
	CGContextAddLineToPoint(ctx, r, b-R);
	CGContextAddArcToPoint(ctx, r, b, r-R, b, R);
	CGContextAddLineToPoint(ctx, l+R, b);
	CGContextAddArcToPoint(ctx, l, b, l, b-R, R);
	CGContextAddLineToPoint(ctx, l, t+R);
	
	CGContextStrokePath(ctx);	
}

@end
