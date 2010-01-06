#import "Task+Utils.h"
#import "TasklistAppDelegate.h"

@implementation Task(Utils)

+(id) fetchTasks{
	NSFetchRequest *request = [[NSFetchRequest new] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext: managedObjectContext()];
	[request setEntity:entity];
	
	NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"memo" ascending:YES] autorelease];
	NSArray *sortDescriptors = [NSArray arrayWithObject: sortDescriptor];
	[request setSortDescriptors:sortDescriptors];
	
	NSError *error = nil;
	NSArray *result = [managedObjectContext() executeFetchRequest:request error:&error];
	if(error) return error;	
	return result;
}

+(id) taskWithMemo: (NSString*)memo{
	Task* task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" 
								  inManagedObjectContext: managedObjectContext()];
	task.memo = memo;
	return task;
}

-(void)delete{
	[self.managedObjectContext deleteObject: self];
}

@end
