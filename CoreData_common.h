
extern NSString * const CoreDataException;
extern NSString * const CoreDataErrorKey;

@interface NSError (CoreData)

-(void) raiseCoreDataException;

@end
