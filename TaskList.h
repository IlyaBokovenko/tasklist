#import <CoreData/CoreData.h>
#import "BWOrderedManagedObject.h"

@class Task;

@interface TaskList :  BWOrderedManagedObject  
{
}

@property (nonatomic, retain) id tasksOrdering;
@property (nonatomic, retain) NSSet* tasks;
@property (nonatomic, retain) NSString* name;

@end

@interface TaskList (CoreDataGeneratedAccessors)
@property (nonatomic) BOOL isCompleted;
@end


@interface TaskList (BWOrdered)

@property(readonly) NSMutableArray* orderedTasks;

@end

@interface TaskList (Utils) 
+(id) tasklistNamed: (NSString*)name;
-(void)delete;

@end