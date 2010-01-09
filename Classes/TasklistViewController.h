#import <UIKit/UIKit.h>

@class StrokedView;

@interface TasklistViewController : UITableViewController<UITextFieldDelegate> {
	NSMutableArray* tasks;
	IBOutlet StrokedView* strokedView;
}

@end

