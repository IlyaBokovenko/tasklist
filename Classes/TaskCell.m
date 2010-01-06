#import "TaskCell.h"
#import "Task+Utils.h"

@implementation TaskCell
@synthesize task;

#pragma mark private


-(void)hideEditField{
	[editField resignFirstResponder];
}

-(void)showEditField{
	editField.hidden = NO;
	editField.text = task.memo;
	[editField becomeFirstResponder];	
	NSNotificationCenter *notifications = [NSNotificationCenter defaultCenter];
	[notifications addObserver:self selector:@selector(kbdWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)kbdWillHide: (NSNotification*)notify{
	editField.hidden = YES;
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void) showCompleted {
	if([task.isCompleted boolValue]){		
		memo.font = [UIFont italicSystemFontOfSize: 14]; 
		memo.textColor = [UIColor grayColor];
	}else {
		memo.font = [UIFont systemFontOfSize: 14];
		memo.textColor = [UIColor blackColor];
	}
}

-(void)showTask{
	memo.text = task.memo;
	[self showCompleted];
}

-(void)updateMemo{
	task.memo = editField.text;
	[self hideEditField];
	[self showTask];	
}

#pragma mark properties
- (void) setTask:(Task*)_task{
	[_task retain];
	[task release];
	task = _task;
	[self showTask];
}

#pragma mark public

-(void)toggle{
	task.isCompleted = [NSNumber numberWithBool: ![task.isCompleted boolValue]];
	[self showCompleted];
}

-(void)editInTable: (UITableView*)table{	
	NSIndexPath* path = [table indexPathForCell: self];
	[table scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
	[self showEditField];
}

#pragma mark UITableViewCell

-(void)prepareForReuse{
	[super prepareForReuse];
	[self hideEditField];
}

- (void) dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	[editField release];
	[memo release];
	[task release];
	[super dealloc];
}


- (void)willTransitionToState:(UITableViewCellStateMask)state{
	[super willTransitionToState: state];
	if(state == UITableViewCellStateDefaultMask || (state && UITableViewCellStateShowingDeleteConfirmationMask)){
		if(!editField.hidden) [self updateMemo];
	}
	
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[self updateMemo];
	return YES;
}


@end