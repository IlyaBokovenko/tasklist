@class TaskList;

@interface TasklistCell : UITableViewCell<UITextFieldDelegate> {
	TaskList* tasklist;
	IBOutlet UITextField* editField;
	IBOutlet UILabel* tasklistTextLabel;
	
	UIFont* normalFont;
	UIFont* completedFont;
}

@property(retain) TaskList* tasklist;

-(void)toggle;
-(void)editInTable: (UITableView*)table;

@end
