#import "CustomNavigationController.h"

@interface CustomNavigationController()

@property(retain) UIViewController* selectedController;

@end


@implementation CustomNavigationController
@synthesize controllers;
@synthesize selectedController;

#pragma mark private

- (void) showSelectedController {
	[selectedController.view removeFromSuperview];
	
	CGRect ignore, childFrame;
	CGFloat navbarHeight = navbar.bounds.size.height;
	CGRectDivide(self.view.bounds, &ignore, &childFrame, navbarHeight, CGRectMinYEdge);
	selectedController.view.frame = childFrame;
	
	[self.view addSubview: selectedController.view];
	
	navbar.items = [NSArray arrayWithObject: selectedController.navigationItem];
}


#pragma mark proprties


- (void) setSelectedController:(UIViewController*)_selectedController{	
	if(self.isViewLoaded) [selectedController.view removeFromSuperview];
	
    [_selectedController retain];
    [selectedController release];
    selectedController = _selectedController;
	
	if(self.isViewLoaded){
		[self showSelectedController];		
	}

}
            

- (void) setControllers:(NSArray*)_controllers{
    [_controllers retain];
    [controllers release];
    controllers = _controllers;
	
	self.selectedController = controllers.count ? [controllers objectAtIndex: 0] : nil;
}
            

#pragma mark UIViewController

- (void) viewDidLoad{
	[super viewDidLoad];

	[self showSelectedController];
}

- (void) dealloc{
	[selectedController release];
	[controllers release];
	[navbar release];
	[super dealloc];
}



@end