//
//  Tweak.h
//  Photicon
//
//  Created by c0ldra1n on 1/13/17.
//  Copyright © 2017 c0ldra1n. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SBIconViewLocationNormal    = 1,
    SBIconViewLocationStark     = 2,
    SBIconViewLocationDock      = 3,
    /* SBIconViewLocationUnknown   = 4, */
    SBIconViewLocationSwitcher  = 5,
    SBIconViewLocationSwitcherLandscape = 6,
    SBIconViewLocationFolder    = 7
} SBIconViewLocation;

@interface SBLockScreenManager : NSObject

-(void)_finishUIUnlockFromSource:(int)arg1 withOptions:(id)arg2;

@end

@interface SBIcon : NSObject

-(id)applicationBundleID;

@end

@interface SBIconImageView : UIView

@property (nonatomic,readonly) SBIcon *icon;

-(UIImage *)_currentOverlayImage;

-(void)iconImageDidUpdate:(id)arg1;
-(void)updateImageAnimated:(BOOL)arg1 ;

@end


@interface SBIconView : UIView {
    SBIconImageView *_iconImageView;
}

@end

@interface SBIconModel : NSObject

-(id)expectedIconForDisplayIdentifier:(id)arg1;

@end


@interface SBIconViewMap : NSObject

-(id)mappedIconViewForIcon:(id)arg1;

@end

@interface SBIconController : NSObject

@property (nonatomic,readonly) SBIconViewMap * homescreenIconViewMap;

+(id)sharedInstance;

-(id)model;

-(BOOL)relayout;

@end

@interface SBUIController : NSObject

@end
