@class Task;

@interface TaskCell : UITableViewCell<UITextFieldDelegate> {
	Task* task;
	IBOutlet UITextField* editField;
	IBOutlet UILabel* memo;
}

@property(retain) Task* task;

-(void)toggle;
-(void)editInTable: (UITableView*)table;

@end
