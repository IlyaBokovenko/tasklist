#import "ListsCollection.h"
#import "TaskList.h"
#import "TasklistAppDelegate.h"
#import "CoreData_common.h"

@implementation ListsCollection 

@dynamic listsOrdering;
@dynamic lists;

@end


@implementation ListsCollection (BWOrdered)

-(NSMutableArray*)orderedLists{
	return [self mutableOrderedValueForKey: @"lists"];
}

@end


@implementation ListsCollection (Utils)

#pragma mark private

+(ListsCollection*)getSharedCollection{
	NSFetchRequest *request = [[NSFetchRequest new] autorelease];
	request.fetchLimit = 1;
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"ListsCollection" 
											  inManagedObjectContext: managedObjectContext()];
	request.entity = entity;	
	NSError *error = nil;
	NSArray *results = [managedObjectContext() executeFetchRequest:request error:&error];
	if(error){
		[error raiseCoreDataException];
	}
	
	ListsCollection* result = nil;
	if(results.count){
		result = [results lastObject];
	}else {
		result = [NSEntityDescription insertNewObjectForEntityForName:@"ListsCollection" 
											   inManagedObjectContext: managedObjectContext()];
	}
	
	return result;	
}

#pragma mark public

+(NSMutableArray*) sharedCollection{
	static ListsCollection* sharedCollection;
	
	if(!sharedCollection){
		sharedCollection = [[self getSharedCollection] retain];		
	}
	
	return [sharedCollection mutableOrderedValueForKey: @"lists"];
}

@end