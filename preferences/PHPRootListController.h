
#import <UIKit/UIKit.h>

#ifdef THEOSBUILD
    #import <Preferences/PSListController.h>
#else
    @interface PSViewController : UIViewController
    @end
    @interface PSListController : PSViewController
    @end
#endif

@interface PHPRootListController : PSListController

@end
