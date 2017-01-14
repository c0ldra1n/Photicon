//
//  CRPSTableViewCell.m
//  Reachboard
//
//  Created by c0ldra1n on 1/13/17.
//  Copyright © 2017 c0ldra1n. All rights reserved.
//

#import "CRPSTableViewCell.h"

@implementation CRPSTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];
    
    if (self) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = (CGFloat)[specifier.properties[@"height"] floatValue];
        
        NSString *imageDir = specifier.properties[@"image"];
        
        NSString *backgroundDir = specifier.properties[@"background-image"];
        
        UIImage *overlayImage = [UIImage imageWithContentsOfFile:imageDir];
        UIImage *backgroundImage = [UIImage imageWithContentsOfFile:backgroundDir];
        
        _headerOverlayView = [[UIImageView alloc] initWithImage:overlayImage];
        _headerBackgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        
        _headerBackgroundView.frame = CGRectMake(0, 0, width, height);
        _headerBackgroundView.center = _headerBackgroundView.center;
        _headerOverlayView.center = _headerBackgroundView.center;
        
        [self addSubview:_headerBackgroundView];
        [self addSubview:_headerOverlayView];
        
        self.backgroundColor = [UIColor whiteColor];
        
        _touchCount = 0;
        
    }
    
    return self;
    
}

-(void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
#ifdef TRUSTTHECELL
    width = self.frame.size.width;
#endif
    CGFloat height = (CGFloat)[specifier.properties[@"height"] floatValue];
    
    _headerBackgroundView.frame = CGRectMake(0, 0, width, height);
    _headerBackgroundView.center = _headerBackgroundView.center;
    _headerOverlayView.center = _headerBackgroundView.center;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    _touchCount += 1;
    
    if (_touchCount == 10) {
        _touchCount = 0;
        
        UIAlertController *uac = [UIAlertController alertControllerWithTitle:@"Ooh, you found an easter egg!" message:@"Congrats. You found an easter egg." preferredStyle:UIAlertControllerStyleAlert];
        
        [uac addAction:[UIAlertAction actionWithTitle:@"Woah that's cool!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIViewController *vc = [[UIViewController alloc] init];
                
                UITextView *textView = [[UITextView alloc] init];
                
                textView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
                textView.textColor = [UIColor whiteColor];
                
                textView.textAlignment = NSTextAlignmentCenter;
                textView.font = [UIFont systemFontOfSize:15.0f];
                textView.text = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://eshin2020.ddns.net/easteregg.txt"] encoding:NSUTF8StringEncoding error:nil];
                
                vc.view = textView;
                
                [(UINavigationController *)([UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0]) pushViewController:vc animated:YES];
                
            });
            
        }]];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:uac animated:YES completion:nil];
        
    }
}


@end
