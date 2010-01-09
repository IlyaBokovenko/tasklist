#import "TasklistViewController.h"
#import "Task+Utils.h"
#import "Async.h"
#import "NSObject+Utils.h"
#import "TaskCell.h"
#import "UITableViewCell+NIB.h"
#import "StrokedView.h"

@interface TasklistViewController ()

@property(retain) NSArray* tasks;

@end


@implementation TasklistViewController
@synthesize tasks;

- (void) setTasks:(NSArray*)_tasks{
	id copy = [_tasks mutableCopy];
	[tasks release];
	tasks = copy;
	[self.tableView reloadData];
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
	
	AsyncObject* ao = [AsyncObject asyncObjectForTarget: [Task class]];
	BlockingAsyncCallback* cb = [BlockingAsyncCallback callbackWithDelegate:self 
																  onSuccess:@selector(onTasksFetched:) 
																	onError: [BlockingAsyncCallback defaultErrorHandler]
																	blocker: [UIBlocker blockerForView: self.view]];
	[[ao proxyWithCallback:cb] fetchTasks];
}

- (void) dealloc{
	[strokedView release];
	[tasks release];
	[super dealloc];
}

-(void)onTasksFetched: (NSArray*)newTasks{
	self.tasks = newTasks;
}

#pragma mark UITableViewDelegate/dataSource

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	TaskCell* cell = [TaskCell dequeOrCreateInTable: tableView];
	cell.task = [tasks objectAtIndex: indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	if(editingStyle == UITableViewCellEditingStyleDelete){
		Task* t = [tasks objectAtIndex: indexPath.row];				   
		[t delete];
		[tasks removeObject: t];
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
	[tasks exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	
	Task* newTask = [Task taskWithMemo: textField.text];
	textField.text = nil;
	[tasks insertObject:newTask atIndex:0];	
	NSIndexPath* path = [NSIndexPath indexPathForRow: 0 inSection:0];
	[self.tableView insertRowsAtIndexPaths: [path arrayed] withRowAnimation:UITableViewRowAnimationTop];	
	return YES;
}

@end