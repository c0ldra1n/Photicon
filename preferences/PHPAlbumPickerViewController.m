//
//  PHPAlbumPickerViewController.m
//  Photicon
//
//  Created by c0ldra1n on 1/14/17.
//  Copyright © 2017 c0ldra1n. All rights reserved.
//

#import <PhotoLibraryServices/Processed/PLPhotoLibrary.h>
#import <PhotoLibraryServices/Processed/PLManagedAlbum.h>
#import <PhotoLibraryServices/Processed/PLManagedAsset.h>

#import "PHPAlbumPickerViewController.h"

#define ALBUM_PHPreferences ([[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/io.c0ldra1n.photicon-prefs-extras.plist"]?:[[NSMutableDictionary alloc] init])

#define PHAlbumName (ALBUM_PHPreferences[@"PHAlbumName"] ?: @"Camera Roll")

@interface PHPAlbumPickerViewController () {
    NSUInteger selectedIndex;
}

@property (strong) NSArray *albums;

@end

@implementation PHPAlbumPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *albums_unfiltered = [[[PLPhotoLibrary sharedPhotoLibrary] albums] mutableCopy];
    
    [albums_unfiltered removeObjectAtIndex:0];  //  Camera Roll Duplicate Fix
    
    NSMutableArray *filteredAlbums = [[NSMutableArray alloc] init];
    
    for (PLManagedAlbum *album in albums_unfiltered) {
        if (([album photosCount] != 0) && ![album.localizedTitle isEqualToString:@"Hidden"]) {
            [filteredAlbums addObject:album];
        }
    }
    
    self.albums = filteredAlbums;

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.title = @"Select Album";
    
    [self.tableView reloadData];    //   When everything is done
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albums.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    PLManagedAlbum *album = self.albums[indexPath.row];
    
    cell.textLabel.text = [album localizedTitle];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%llu Photos", [album photosCount]];
    
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    if ([[album localizedTitle] isEqualToString:PHAlbumName]) {
        
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        
        selectedIndex = indexPath.row;
        
    }else{
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        
    }
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
    
    [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    selectedIndex = indexPath.row;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

-(void)done{
    
    PLManagedAlbum *album = self.albums[selectedIndex];
    
    NSString *name = [album localizedTitle];
    
    NSMutableDictionary *mutablePrefs = ALBUM_PHPreferences;
    
    [mutablePrefs setValue:name forKey:@"PHAlbumName"];
    
    [mutablePrefs writeToFile:@"/var/mobile/Library/Preferences/io.c0ldra1n.photicon-prefs-extras.plist" atomically:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
