#import "TasklistCell.h"
#import "TaskList.h"
#import "NSArray+Utils.h"

@implementation TasklistCell
@synthesize tasklist;

#pragma mark private

-(void)awakeFromNib{
	[super awakeFromNib];
	
	normalFont = [tasklistTextLabel.font retain];
	NSArray* familyFonts = [UIFont fontNamesForFamilyName: tasklistTextLabel.font.familyName];
	NSString* obliqueFontName = [familyFonts detect: [NSPredicate predicateWithFormat:@"self endswith '-Oblique'"]];
	if(!obliqueFontName)obliqueFontName = normalFont.fontName;
	completedFont = [[UIFont fontWithName: obliqueFontName size:normalFont.pointSize] retain];	
}


-(void)hideEditField{
	[editField resignFirstResponder];
}

-(void)showEditField{
	editField.hidden = NO;
	editField.text = tasklist.name;
	[editField becomeFirstResponder];	
	NSNotificationCenter *notifications = [NSNotificationCenter defaultCenter];
	[notifications addObserver:self selector:@selector(kbdWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)kbdWillHide: (NSNotification*)notify{
	editField.hidden = YES;
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void) showCompleted {
	if(tasklist.isCompleted){		
		tasklistTextLabel.font = completedFont;
		tasklistTextLabel.textColor = [UIColor grayColor];
	}else {
		tasklistTextLabel.font = normalFont;
		tasklistTextLabel.textColor = [UIColor blackColor];
	}
}

-(void)showTasklist{
	tasklistTextLabel.text = tasklist.name;
	[self showCompleted];
}

-(void)updateText{
	tasklist.name = editField.text;
	[self hideEditField];
	[self showTasklist];	
}

#pragma mark properties
- (void) setTasklist:(TaskList*)_tasklist{
	[_tasklist retain];
	[tasklist release];
	tasklist = _tasklist;
	[self showTasklist];
}

#pragma mark public

-(void)toggle{
	tasklist.isCompleted =  !tasklist.isCompleted;
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
	[normalFont release];
	[completedFont release];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	[editField release];
	[tasklistTextLabel release];
	[tasklist release];
	[super dealloc];
}


- (void)willTransitionToState:(UITableViewCellStateMask)state{
	[super willTransitionToState: state];
	if(state == UITableViewCellStateDefaultMask || (state && UITableViewCellStateShowingDeleteConfirmationMask)){
		if(!editField.hidden) [self updateText];
	}
	
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[self updateText];
	return YES;
}


@end