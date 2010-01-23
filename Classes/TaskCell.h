@class Task;

@interface TaskCell : UITableViewCell<UITextFieldDelegate> {
	Task* task;
	IBOutlet UITextField* editField;
	IBOutlet UILabel* taskTextLabel;
	
	UIFont* normalFont;
	UIFont* completedFont;
}

@property(retain) Task* task;

-(void)toggle;
-(void)editInTable: (UITableView*)table;

@end
