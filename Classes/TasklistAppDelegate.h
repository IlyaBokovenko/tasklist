#import <UIKit/UIKit.h>

NSManagedObjectContext* managedObjectContext();

@class CustomNavigationController;
@class TasklistsManager;

@interface TasklistAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	IBOutlet CustomNavigationController* topController;
	IBOutlet TasklistsManager* manager;
	
	NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;	
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end

