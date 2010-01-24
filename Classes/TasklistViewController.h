@class StrokedView;
@class TaskList;

@interface TasklistViewController : UITableViewController<UITextFieldDelegate> {
	TaskList* tasklist;
	IBOutlet StrokedView* strokedView;
}
@property(retain) TaskList* tasklist;

@end

