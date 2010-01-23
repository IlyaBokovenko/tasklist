//
//  Task.h
//  Tasklist
//
//  Created by loki on 23.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class TaskList;

@interface Task :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * isCompleted;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) TaskList * list;

@end



