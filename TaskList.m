#import "TaskList.h"
#import "Task.h"
#import "TasklistAppDelegate.h"
#import "CoreData_common.h"

@implementation TaskList 

@dynamic tasksOrdering;
@dynamic tasks;
@dynamic name;

- (void)awakeFromInsert{
	if (!self.name)
		self.name = @"Untitled";
}

@end

@implementation TaskList(Utils)

+(id) tasklistNamed: (NSString*)name{
	TaskList* inst = [NSEntityDescription insertNewObjectForEntityForName:@"TaskList" 
												   inManagedObjectContext: managedObjectContext()];

	inst.name = name;
	return inst;
}

-(void)delete{
	[managedObjectContext() deleteObject: self];
}

@end

@implementation TaskList (BWOrdered)

-(NSMutableArray*)orderedTasks{
	return [self mutableOrderedValueForKey: @"tasks"];
}

@end

@interface TaskList (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber *)primitiveIsCompleted;
- (void)setPrimitiveIsCompleted:(NSNumber *)value;

@end

@implementation TaskList (CoreDataGeneratedAccessors)
@dynamic isCompleted;

- (BOOL)isCompleted 
{
    NSNumber * tmpValue;
    
    [self willAccessValueForKey:@"isCompleted"];
    tmpValue = [self primitiveIsCompleted];
    [self didAccessValueForKey:@"isCompleted"];
    
    return [tmpValue boolValue];
}

- (void)setIsCompleted:(BOOL)value 
{
    [self willChangeValueForKey:@"isCompleted"];
    [self setPrimitiveIsCompleted:[NSNumber numberWithBool: value]];
    [self didChangeValueForKey:@"isCompleted"];
}


@end


