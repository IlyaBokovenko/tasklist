#import "TasklistViewController.h"
#import "Async.h"
#import "NSObject+Utils.h"
#import "TaskCell.h"
#import "UITableViewCell+NIB.h"
#import "StrokedView.h"
#import "Task.h"

@interface TasklistViewController ()

@property(readonly) NSMutableArray* tasks;

@end


@implementation TasklistViewController
@synthesize tasklist;

#pragma mark properties

- (NSMutableArray*) tasks{
	return [tasklist mutableOrderedValueForKey: @"tasks"];
}

- (void) setTasklist:(TaskList*)_tasklist{
	[_tasklist retain];
	[tasklist release];
	tasklist = _tasklist;
	[self.tableView reloadData];
}

#pragma mark UIViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	return YES;
}

-(void) viewDidLoad{
	[super viewDidLoad];
	
	strokedView.color = [UIColor colorWithWhite:0.5 alpha:0.5];
	strokedView.width = 4;
	strokedView.pattern = [NSArray arrayWithObjects: 
						   [NSNumber numberWithFloat: 7],
						   [NSNumber numberWithFloat: 4],nil];
	
	self.navigationItem.title = @"Tasks";
	self.navigationItem.rightBarButtonItem = [self editButtonItem];
	
}

- (void) dealloc{
	[strokedView release];
	[tasklist release];
	[super dealloc];
}

#pragma mark UITableViewDelegate/dataSource

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	TaskCell* cell = [TaskCell dequeOrCreateInTable: tableView];
	cell.task = [self.tasks objectAtIndex: indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	if(editingStyle == UITableViewCellEditingStyleDelete){
		Task* t = [self.tasks objectAtIndex: indexPath.row];				   
		[t delete];
		[self.tasks removeObject: t];
		[tableView deleteRowsAtIndexPaths: [indexPath arrayed] withRowAnimation:UITableViewRowAnimationLeft];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	TaskCell* cell = (TaskCell*)[tableView cellForRowAtIndexPath: indexPath];
	
	if(self.editing){
		[cell editInTable: tableView];
	}else {
		[cell toggle];	
	}	
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
	
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
	return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
	[self.tasks exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	
	Task* newTask = [Task taskWithText: textField.text];
	textField.text = nil;
	[self.tasks insertObject:newTask atIndex:0];	
	NSIndexPath* path = [NSIndexPath indexPathForRow: 0 inSection:0];
	[self.tableView insertRowsAtIndexPaths: [path arrayed] withRowAnimation:UITableViewRowAnimationTop];	
	return YES;
}

@end