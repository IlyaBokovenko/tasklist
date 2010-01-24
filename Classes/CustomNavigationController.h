#import <UIKit/UIKit.h>


@interface CustomNavigationController : UIViewController {
	IBOutlet UINavigationBar* navbar;
	
	NSArray* controllers;
	UIViewController* selectedController;
}
@property(retain) NSArray* controllers;

@end
