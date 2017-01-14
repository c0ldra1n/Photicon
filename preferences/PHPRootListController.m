
#include "PHPRootListController.h"
#import "PHPAlbumPickerViewController.h"

#ifdef THEOSBUILD
#pragma message("THEOSBUILD online")
#endif

@implementation PHPRootListController

-(void)twitter{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/0xc0ldra1n"]];
}

-(void)selectAlbum{
    
    PHPAlbumPickerViewController *albumVC = [[PHPAlbumPickerViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:albumVC];
    
    [self presentViewController:navigationVC animated:YES completion:nil];
    
}

-(void)respring{
    system("killall -9 SpringBoard");
}

#ifdef THEOSBUILD
- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
    }
    return _specifiers;
}
#endif

@end
