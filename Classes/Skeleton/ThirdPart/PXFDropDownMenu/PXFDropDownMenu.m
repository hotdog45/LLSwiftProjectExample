//  PXFDropDownMenu.m
//  PXFDropDownMenuDemo
//
//  Created by XieFan on 11/30/15.
//  Copyright (c) 2014 XieFan. All rights reserved.
//

#import "PXFDropDownMenu.h"
#import "ShiftStyeTableViewCell2.h"

@implementation PXFIndexPath
- (instancetype)initWithColumn:(NSInteger)column leftRow:(NSInteger)leftRow rightRow:(NSInteger)rightRow {
    self = [super init];
    if (self) {
        _column = column;
        _leftRow = leftRow;
        _rightRow = rightRow;
    }
    return self;
}

+ (instancetype)indexPathWithCol:(NSInteger)col leftRow:(NSInteger)leftRow rightRow:(NSInteger)rightRow {
    PXFIndexPath *indexPath = [[self alloc] initWithColumn:col leftRow:leftRow rightRow:rightRow];
    return indexPath;
}
@end

#pragma mark - menu implementation

@interface PXFDropDownMenu ()
@property (nonatomic, strong) PXFIndexPath *currentSelectedMenudIndex;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) NSInteger numOfMenu;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
//data source
@property (nonatomic, copy) NSArray *array;
//layers array
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *indicators;
@property (nonatomic, copy) NSArray *bgLayers;
@property (nonatomic, strong) NSMutableArray *selectedIndexArray;
@property (nonatomic, strong) NSArray *imageArray;
@end


@implementation PXFDropDownMenu

#pragma mark - init method
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, height)];
    if (self) {
        _origin = origin;
        _currentSelectedMenudIndex = [PXFIndexPath indexPathWithCol:-1 leftRow:-1 rightRow:-1];
        _show = NO;
        
        //left tableView init
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width/2 + 1, 0) style:UITableViewStylePlain];
        _leftTableView.rowHeight = 40;
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x + self.frame.size.width/2, self.frame.origin.y + self.frame.size.height, self.frame.size.width/2, 0) style:UITableViewStylePlain];
        _rightTableView.rowHeight = 40;
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        
        //self tapped
        self.backgroundColor = [UIColor whiteColor];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
        [self addGestureRecognizer:tapGesture];
        
        //background init and tapped
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, screenSize.height)];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
        [_backGroundView addGestureRecognizer:gesture];
    
    }
    return self;
}

#pragma mark - init support
- (CALayer *)createBgLayerWithColor:(UIColor *)color andPosition:(CGPoint)position {
    CALayer *layer = [CALayer layer];
    
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, self.frame.size.width/self.numOfMenu, self.frame.size.height-1);
    layer.backgroundColor = color.CGColor;
    
    return layer;
}

- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 2)];
    [path addLineToPoint:CGPointMake(4, 6)];
    [path addLineToPoint:CGPointMake(8, 2)];
    [path stroke];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = nil;
    layer.strokeColor = color.CGColor;

    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    
    return layer;
}

- (CATextLayer *)createTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point {
    
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = 14.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}

- (CGSize)calculateTitleSizeWithString:(NSString *)string {
    CGFloat fontSize = 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

#pragma mark - gesture handle
- (void)menuTapped:(UITapGestureRecognizer *)paramSender {
    CGPoint touchPoint = [paramSender locationInView:self];
    //calculate index
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                [self animateTitle:_titles[i] show:NO complete:^{
                    
                }];
            }];
            CATextLayer *title = _titles[i];
            title.foregroundColor = self.textColor.CGColor;
            CAShapeLayer *indicator = _indicators[i];
            indicator.strokeColor = self.textColor.CGColor;
        }

    }
    
    if (tapIndex == _currentSelectedMenudIndex.column && _show) {
        [self animateIdicator:_indicators[_currentSelectedMenudIndex.column] background:_backGroundView title:_titles[_currentSelectedMenudIndex.column] forward:NO complecte:^{
            _currentSelectedMenudIndex.column  = tapIndex;
            _show = NO;
        }];
        CATextLayer *title = _titles[tapIndex];
        title.foregroundColor = self.textColor.CGColor;
        CAShapeLayer *indicator = _indicators[tapIndex];
        indicator.strokeColor = self.textColor.CGColor;
    } else {
        _currentSelectedMenudIndex.column = tapIndex;
        [_leftTableView reloadData];
        [_rightTableView reloadData];

        PXFIndexPath *pxfIndex = (PXFIndexPath *)self.selectedIndexArray[_currentSelectedMenudIndex.column];

        
        [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:pxfIndex.leftRow inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        [_rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:pxfIndex.rightRow inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];


        
        [self animateIdicator:_indicators[tapIndex] background:_backGroundView title:_titles[tapIndex] forward:YES complecte:^{
            _show = YES;
        }];
        CATextLayer *title = _titles[tapIndex];
        title.foregroundColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1].CGColor;
        CAShapeLayer *indicator = _indicators[tapIndex];
        indicator.strokeColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1].CGColor;
    }
}

- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender {
    [self animateIdicator:_indicators[ _currentSelectedMenudIndex.column] background:_backGroundView title:_titles[ _currentSelectedMenudIndex.column] forward:NO complecte:^{
        _show = NO;
    }];
    CATextLayer *title = _titles[_currentSelectedMenudIndex.column];
    title.foregroundColor = self.textColor.CGColor;
    CAShapeLayer *indicator = _indicators[_currentSelectedMenudIndex.column];
    indicator.strokeColor = self.textColor.CGColor;
}

#pragma mark - animation method
- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim forKey:anim.keyPath];
        [indicator setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    complete();
}

- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    complete();
}

- (void)animateTableViewShow:(BOOL)show complete:(void(^)())complete {
    NSInteger tableNumber = [self.dataSource menu:self numberOfTableInColumn:_currentSelectedMenudIndex.column];

    if (show) {
        _leftTableView.frame = CGRectMake(self.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width/tableNumber + 1, 0);
        _rightTableView.frame = CGRectMake(self.origin.x + self.frame.size.width/tableNumber, self.frame.origin.y + self.frame.size.height, self.frame.size.width/tableNumber, 0);

        [self.superview addSubview:_leftTableView];
        
        if (tableNumber > 1) {
            [self.superview addSubview:_rightTableView];
        }
        
        CGFloat tableViewHeight = ([self.leftTableView numberOfRowsInSection:0] > 8) ? (8 * self.leftTableView.rowHeight) : ([self.leftTableView numberOfRowsInSection:0] * self.leftTableView.rowHeight);

        [UIView animateWithDuration:0.2 animations:^{
            _leftTableView.frame = CGRectMake(self.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width/tableNumber + 1, tableViewHeight);
            if (tableNumber > 1) {
                _rightTableView.frame = CGRectMake(self.origin.x + self.frame.size.width/tableNumber, self.frame.origin.y + self.frame.size.height, self.frame.size.width/tableNumber, tableViewHeight);
            }
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            _leftTableView.frame = CGRectMake(self.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width/tableNumber + 1, 0);
            if (tableNumber > 1) {
                _rightTableView.frame = CGRectMake(self.origin.x + self.frame.size.width/tableNumber, self.frame.origin.y + self.frame.size.height, self.frame.size.width/tableNumber, 0);
            }
        } completion:^(BOOL finished) {
            [_leftTableView removeFromSuperview];
            [_rightTableView removeFromSuperview];

        }];
    }

    
    complete();
}

- (void)animateTitle:(CATextLayer *)title show:(BOOL)show complete:(void(^)())complete {
    CGSize size = [self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    title.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    complete();
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)())complete{
    
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateTitle:title show:forward complete:^{
            [self animateBackGroundView:background show:forward complete:^{
                [self animateTableViewShow:forward complete:^{
                }];
            }];
        }];
    }];
    
    complete();
}

#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSAssert(self.dataSource != nil, @"menu's dataSource shouldn't be nil");
    if (self.dataSource == nil) {
        return 0;
    }
    if ([tableView isEqual:self.leftTableView]) {
        if ([self.dataSource respondsToSelector:@selector(menu:numberOfRowsInTable:AtColumn:)]) {
            return [self.dataSource menu:self numberOfRowsInTable:LeftTable AtColumn:self. currentSelectedMenudIndex.column];
        } else {
            NSAssert(0 == 1, @"required method of dataSource protocol should be implemented");
            return 0;
        }
    }
    else {
        if ([self.dataSource respondsToSelector:@selector(menu:numberOfRowsInTable:AtColumn:)]) {
            return [self.dataSource menu:self numberOfRowsInTable:RightTable AtColumn:_currentSelectedMenudIndex.column];
        } else {
            NSAssert(0 == 1, @"required method of dataSource protocol should be implemented");
            return 0;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier,*nibName;
    PXFIndexPath *pxfIndex = (PXFIndexPath *)self.selectedIndexArray[_currentSelectedMenudIndex.column];

    cellIdentifier = @"ShiftStyeTableViewCell2";
    nibName = cellIdentifier;
    ShiftStyeTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *arry = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        cell = [arry objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSAssert(self.dataSource != nil, @"menu's datasource shouldn't be nil");
    if (indexPath.row == 0) {
        cell.content = @"全部";
    }
    else {
        if ([self.dataSource respondsToSelector:@selector(menu:titleForRowAtIndexPath:)]) {
            cell.content = [self.dataSource menu:self titleForRowAtIndexPath:[PXFIndexPath indexPathWithCol:_currentSelectedMenudIndex.column leftRow:indexPath.row rightRow:-1]];
        }
        else {
            NSAssert(0 == 1, @"dataSource method needs to be implemented");
        }
    }
    if (pxfIndex.leftRow == indexPath.row) {
        cell.selected = YES;
        
    }
    return cell;


}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PXFIndexPath *pxfIndex = (PXFIndexPath *)self.selectedIndexArray[_currentSelectedMenudIndex.column];

    switch (_currentSelectedMenudIndex.column) {
        case 0:{
            _currentSelectedMenudIndex.leftRow = indexPath.row;
            pxfIndex.leftRow = indexPath.row;
            
            if ([tableView isEqual:self.leftTableView]) {
                if (self.delegate || [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
                    [self confiMenu];
                    [self.delegate menu:self didSelectRowAtIndexPath:[PXFIndexPath indexPathWithCol:_currentSelectedMenudIndex.column leftRow:indexPath.row rightRow:-1]];
                    
                } else {
                    //TODO: delegate is nil
                }
            }
            break;
        }
        case 1:{
            _currentSelectedMenudIndex.leftRow = indexPath.row;
            pxfIndex.leftRow = indexPath.row;

            if ([tableView isEqual:self.leftTableView]) {
                if (self.delegate || [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
                    [self confiMenu];
                    [self.delegate menu:self didSelectRowAtIndexPath:[PXFIndexPath indexPathWithCol:_currentSelectedMenudIndex.column leftRow:indexPath.row rightRow:-1]];

                } else {
                    //TODO: delegate is nil
                }
            }
            break;
        }
        case 2:{
            _currentSelectedMenudIndex.leftRow = indexPath.row;
            pxfIndex.leftRow = indexPath.row;

            if ([tableView isEqual:self.leftTableView]) {
                if (self.delegate || [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
                    [self confiMenu];
                    [self.delegate menu:self didSelectRowAtIndexPath:[PXFIndexPath indexPathWithCol:_currentSelectedMenudIndex.column leftRow:indexPath.row rightRow:-1]];
                    
                } else {
                    //TODO: delegate is nil
                }
            }
            break;
        }
        case 3:{
            _currentSelectedMenudIndex.leftRow = indexPath.row;
            pxfIndex.leftRow = indexPath.row;
            
            if ([tableView isEqual:self.leftTableView]) {
                if (self.delegate || [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
                    [self confiMenu];
                    [self.delegate menu:self didSelectRowAtIndexPath:[PXFIndexPath indexPathWithCol:_currentSelectedMenudIndex.column leftRow:indexPath.row rightRow:-1]];
                    
                } else {
                    //TODO: delegate is nil
                }
            }
            break;
        }
        default:
            break;
    }
}

- (void)confiMenu {

    CATextLayer *title = (CATextLayer *)_titles[ _currentSelectedMenudIndex.column];

    title.string = [self.dataSource menu:self titleForRowAtIndexPath:_currentSelectedMenudIndex];
    
    [self animateIdicator:_indicators[ _currentSelectedMenudIndex.column] background:_backGroundView title:_titles[ _currentSelectedMenudIndex.column] forward:NO complecte:^{
        _show = NO;
    }];
    title.foregroundColor = self.textColor.CGColor;
    
    CAShapeLayer *indicator = (CAShapeLayer *)_indicators[ _currentSelectedMenudIndex.column];
    indicator.strokeColor = self.textColor.CGColor;

    indicator.position = CGPointMake(title.position.x + title.frame.size.width / 2 + 8, indicator.position.y);
    
}

- (void)reloadData {
    if ([_dataSource respondsToSelector:@selector(defaultSelectIndexPathOfMenu:)]) {
        PXFIndexPath *indexPath = [_dataSource defaultSelectIndexPathOfMenu:self];
        self.selectedIndexArray[indexPath.column] = indexPath;
        self.currentSelectedMenudIndex = indexPath;
    }
    [self confiMenu];
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

#pragma mark - setter && getter
- (void)setDataSource:(id<PXFDropDownMenuDataSource>)dataSource {
    _dataSource = dataSource;
    
    //configure view
    if ([_dataSource respondsToSelector:@selector(numberOfColumnsInMenu:)]) {
        _numOfMenu = [_dataSource numberOfColumnsInMenu:self];
    } else {
        _numOfMenu = 1;
    }
    
    for (int i=0; i<_numOfMenu; i++) {
        self.selectedIndexArray[i] = [PXFIndexPath indexPathWithCol:i leftRow:0 rightRow:0];
    }
    
    if ([_dataSource respondsToSelector:@selector(defaultSelectIndexPathOfMenu:)]) {
        PXFIndexPath *indexPath = [_dataSource defaultSelectIndexPathOfMenu:self];
        self.selectedIndexArray[indexPath.column] = indexPath;
        self.currentSelectedMenudIndex = indexPath;
    }
    
    CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
    CGFloat bgLayerInterval = self.frame.size.width / _numOfMenu;
    
    NSMutableArray *tempTitles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempIndicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempBgLayers = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    
    for (int i = 0; i < _numOfMenu; i++) {
        //bgLayer
        CGPoint bgLayerPosition = CGPointMake((i+0.5)*bgLayerInterval, self.frame.size.height/2);
        CALayer *bgLayer = [self createBgLayerWithColor:[UIColor whiteColor] andPosition:bgLayerPosition];
        [self.layer addSublayer:bgLayer];
        [tempBgLayers addObject:bgLayer];
        
        //title
        CGPoint titlePosition = CGPointMake( (i * 2 + 1) * textLayerInterval , self.frame.size.height / 2 - 2);
        NSString *titleString ;
        
        titleString = [self.dataSource menu:self titleForRowAtIndexPath:self.selectedIndexArray[i]];
        
        CATextLayer *title = [self createTextLayerWithNSString:titleString withColor:self.textColor andPosition:titlePosition];
        [self.layer addSublayer:title];
        [tempTitles addObject:title];
        
        //indicator
        CAShapeLayer *indicator = [self createIndicatorWithColor:self.indicatorColor andPosition:CGPointMake(titlePosition.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2)];
        [self.layer addSublayer:indicator];
        [tempIndicators addObject:indicator];
        
    }
    for (int i=1; i<_numOfMenu; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(bgLayerInterval*i, self.frame.size.height/3, 1, self.frame.size.height/3)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
    }
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    bottomLine.backgroundColor = self.separatorColor;
    [self addSubview:bottomLine];
    
    _titles = [tempTitles copy];
    _indicators = [tempIndicators copy];
    _bgLayers = [tempBgLayers copy];
}

- (UIColor *)indicatorColor {
    if (!_indicatorColor) {
        _indicatorColor = [UIColor colorWithRed:60/255.0 green:68/255.0 blue:82/255.0 alpha:1];
    }
    return _indicatorColor;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor colorWithRed:60/255.0 green:68/255.0 blue:82/255.0 alpha:1];
    }
    return _textColor;
}

- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:0.4];
    }
    return _separatorColor;
}

- (NSString *)titleForRowAtIndexPath:(PXFIndexPath *)indexPath {
    return [self.dataSource menu:self titleForRowAtIndexPath:indexPath];
}

- (NSMutableArray *)selectedIndexArray {
    if (_selectedIndexArray == nil) {
        _selectedIndexArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _selectedIndexArray;
}

- (NSArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = @[@"list_all",@"list_distance",@"list_star"];
    }
    return _imageArray;
}

@end

