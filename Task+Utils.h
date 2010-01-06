#import "Task.h"

@interface Task (Utils) 
+(id) fetchTasks;
+(id) taskWithMemo: (NSString*)memo;

-(void)delete;

@end
