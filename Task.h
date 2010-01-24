#import <CoreData/CoreData.h>
#import "BWOrderedManagedObject.h"

@interface Task :  BWOrderedManagedObject  
{
}

@property (nonatomic, retain) NSString * text;

@end

@interface Task (CoreDataGeneratedAccessors)
@property (nonatomic) BOOL isCompleted;
@end


@interface Task (Utils) 

+(id) taskWithText: (NSString*)text;
-(void)delete;

@end

