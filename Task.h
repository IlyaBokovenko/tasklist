//
//  Task.h
//  Tasklist
//
//  Created by loki on 31.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Task :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSNumber * isCompleted;

@end



