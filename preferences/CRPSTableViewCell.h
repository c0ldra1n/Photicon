//
//  CRPSTableViewCell.h
//  Reachboard
//
//  Created by c0ldra1n on 1/13/17.
//  Copyright © 2017 c0ldra1n. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PSSpecifier : NSObject

@property (nonatomic, retain) NSMutableDictionary *properties;

@end


@interface PSTableCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier;

- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier;

- (void)setSeparatorStyle:(UITableViewCellSeparatorStyle)style;

@property (nonatomic, retain) UIImage *icon;

@end


@interface CRPSTableViewCell : PSTableCell {
    int _touchCount;
    UIImageView *_headerOverlayView;
    UIImageView *_headerBackgroundView;
}

@end
