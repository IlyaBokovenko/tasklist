#import "Task.h"
#import "TasklistAppDelegate.h"

@implementation Task 

@dynamic text;

@end

@implementation Task(Utils)

+(id) taskWithText: (NSString*)text{
	Task* inst = [NSEntityDescription insertNewObjectForEntityForName:@"Task" 
											   inManagedObjectContext: managedObjectContext()];

	inst.text = text;
	return inst;
}

-(void)delete{
	[managedObjectContext() deleteObject: self];
}

@end



@interface Task (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber *)primitiveIsCompleted;
- (void)setPrimitiveIsCompleted:(NSNumber *)value;

@end

@implementation Task (CoreDataGeneratedAccessors)
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


