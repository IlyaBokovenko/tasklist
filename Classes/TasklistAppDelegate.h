#import <UIKit/UIKit.h>

NSManagedObjectContext* managedObjectContext();


@interface TasklistAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;

	IBOutlet UINavigationController* topController;
	
	NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;	
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end

