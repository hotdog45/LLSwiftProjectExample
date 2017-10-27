//
//  PXFDropDownMenu.h
//  PXFDropDownMenuDemo
//
//  Created by XieFan on 11/30/15.
//  Copyright (c) 2014 XieFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXFIndexPath : NSObject

@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) NSInteger leftRow;
@property (nonatomic, assign) NSInteger rightRow;
- (instancetype)initWithColumn:(NSInteger)column leftRow:(NSInteger)leftRow rightRow:(NSInteger)rightRow;
+ (instancetype)indexPathWithCol:(NSInteger)col leftRow:(NSInteger)leftRow rightRow:(NSInteger)rightRow;

@end

#pragma mark - tabel type
typedef enum {
    LeftTable = 0,
    RightTable,
}PXFTabelType;

#pragma mark - data source protocol
@class PXFDropDownMenu;

@protocol PXFDropDownMenuDataSource <NSObject>

@required
- (NSInteger)menu:(PXFDropDownMenu *)menu numberOfTableInColumn:(NSInteger)column;
- (NSInteger)menu:(PXFDropDownMenu *)menu numberOfRowsInTable:(PXFTabelType)tableType AtColumn:(NSInteger)column;
- (NSString *)menu:(PXFDropDownMenu *)menu titleForRowAtIndexPath:(PXFIndexPath *)indexPath;

@optional
//default value is 1
- (NSInteger)numberOfColumnsInMenu:(PXFDropDownMenu *)menu;
- (PXFIndexPath *)defaultSelectIndexPathOfMenu:(PXFDropDownMenu *)menu;

@end

#pragma mark - delegate
@protocol PXFDropDownMenuDelegate <NSObject>
@optional
- (void)menu:(PXFDropDownMenu *)menu didSelectRowAtIndexPath:(PXFIndexPath *)indexPath;
@end

#pragma mark - interface
@interface PXFDropDownMenu : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <PXFDropDownMenuDataSource> dataSource;
@property (nonatomic, weak) id <PXFDropDownMenuDelegate> delegate;

@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *separatorColor;
/**
 *  the width of menu will be set to screen width defaultly
 *
 *  @param origin the origin of this view's frame
 *  @param height menu's height
 *
 *  @return menu
 */
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;
- (NSString *)titleForRowAtIndexPath:(PXFIndexPath *)indexPath;
- (void)reloadData;

@end

