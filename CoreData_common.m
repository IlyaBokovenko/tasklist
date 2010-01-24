#import "CoreData_common.h"

NSString * const CoreDataException = @"Core Data Exception";
NSString * const CoreDataErrorKey = @"error";

@implementation NSError(CoreData)

-(void) raiseCoreDataException{
	NSDictionary* info = [NSDictionary dictionaryWithObject:self forKey: CoreDataErrorKey];
	NSException* ex = [NSException exceptionWithName: CoreDataException 
											  reason: [self localizedDescription]
											userInfo:info];
	[ex raise];
}

@end
