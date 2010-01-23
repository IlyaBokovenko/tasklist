//
//  TaskList.h
//  Tasklist
//
//  Created by loki on 23.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Task;

@interface TaskList :  NSManagedObject  
{
}

@property (nonatomic, retain) NSSet* tasks;

@end


@interface TaskList (CoreDataGeneratedAccessors)
- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)value;
- (void)removeTasks:(NSSet *)value;

@end

