#import "TasklistsManager.h"
#import "ListsCollection.h"
#import "TaskList.h"
#import "TasklistCell.h"
#import "UITableViewCell+NIB.h"
#import "NSObject+Utils.h"

@implementation TasklistsManager

#pragma mark UITableViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	return YES;
}

-(void) viewDidLoad{
	[super viewDidLoad];

	self.navigationItem.title = @"ToDo lists";
	self.navigationItem.rightBarButtonItem = [self editButtonItem];
	
	lists = [[ListsCollection sharedCollection] retain];

	strokedView.color = [UIColor colorWithWhite:0.5 alpha:0.5];
	strokedView.width = 4;
	strokedView.pattern = [NSArray arrayWithObjects: 
						   [NSNumber numberWithFloat: 7],
						   [NSNumber numberWithFloat: 4],nil];	
	
}

- (void) dealloc{
	[lists release];
	[strokedView release];
	[super dealloc];
}

#pragma mark UITableViewDelegate/dataSource

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	TasklistCell* cell = [TasklistCell dequeOrCreateInTable: tableView];
	cell.tasklist = [lists objectAtIndex: indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	if(editingStyle == UITableViewCellEditingStyleDelete){
		TaskList* t = [lists objectAtIndex: indexPath.row];				   
		[t delete];
		[lists removeObject: t];
		[tableView deleteRowsAtIndexPaths: [indexPath arrayed] withRowAnimation:UITableViewRowAnimationLeft];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	TasklistCell* cell = (TasklistCell*)[tableView cellForRowAtIndexPath: indexPath];
	
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
	[lists exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	
	TaskList* newList = [TaskList tasklistNamed: textField.text];
	textField.text = nil;
	[lists insertObject:newList atIndex:0];	
	NSIndexPath* path = [NSIndexPath indexPathForRow: 0 inSection:0];
	[self.tableView insertRowsAtIndexPaths: [path arrayed] withRowAnimation:UITableViewRowAnimationTop];	
	return YES;
}

@end