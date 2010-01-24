#import <CoreData/CoreData.h>
#import "BWOrderedManagedObject.h"

@class TaskList;

@interface ListsCollection :  BWOrderedManagedObject  
{
}

@property (nonatomic, retain) id listsOrdering;
@property (nonatomic, retain) NSSet* lists;

@end


@interface ListsCollection (BWOrdered)

@property(readonly) NSMutableArray* orderedLists;

@end

@interface ListsCollection (Utils)

+(NSMutableArray*) sharedCollection;

@end