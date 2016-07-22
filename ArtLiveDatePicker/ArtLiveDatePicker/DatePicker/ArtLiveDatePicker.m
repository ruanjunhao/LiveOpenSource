//
//  ArtLiveDatePicker.m
//  ArtLiveDatePicker
//
//  Created by LeeWong on 16/7/12.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "ArtLiveDatePicker.h"

@interface ArtLiveDatePicker () <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) UILabel *currentTimeLabel;

@property (nonatomic,strong) UIPickerView *pickerView;

@property (nonatomic,strong) UIView *sepLine;

@property (nonatomic,strong) UIButton *checkBtn;
@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,strong) NSString *year;
@property (nonatomic,strong) NSString *month;
@property (nonatomic,strong) NSString *day;
@property (nonatomic,strong) NSString *hour;
@property (nonatomic,strong) NSString *minute;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ArtLiveDatePicker

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self customUI];
        [self currentTime];
    }
    return self;
}


- (void)currentTime
{
    
    NSDate *now = [NSDate date];
    NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    self.year = [NSString stringWithFormat:@"%zd",[dateComponent year]];
    self.month = [NSString stringWithFormat:@"%02zd",[dateComponent month]];
    self.day = [NSString stringWithFormat:@"%02zd",[dateComponent day]];
    self.hour = [NSString stringWithFormat:@"%02zd",[dateComponent hour]];
    self.minute = [NSString stringWithFormat:@"%02zd",[dateComponent minute]];
    
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    [self.pickerView selectRow:[self.month integerValue]-1 inComponent:1 animated:NO];  //月份和小时从
    [self.pickerView selectRow:[self.day integerValue]-1 inComponent:2 animated:NO];
    [self.pickerView selectRow:[self.hour integerValue] inComponent:3 animated:NO];
    [self.pickerView selectRow:[self.minute integerValue] inComponent:4 animated:NO];

    self.currentTimeLabel.text = [NSString stringWithFormat:@"%@-%@-%@  %@:%@",self.year,self.month,self.day,self.hour,self.minute];
}


- (void)customUI
{
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(5);
    }];
    
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.currentTimeLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sepLine.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@100);
    }];
    
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@120);
        make.right.equalTo(self.mas_centerX).offset(-5);
        make.height.equalTo(@30);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.checkBtn);
        make.left.equalTo(self.mas_centerX).offset(5);
        make.centerY.equalTo(self.checkBtn.mas_centerY);
    }];
}

#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [self.dataSource count];
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *rows = self.dataSource[component];
    return [rows count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 50;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UIView *select  = [[UIView alloc] init];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.textColor = [UIColor colorWithRed:77/255. green:77/255. blue:77/255. alpha:1];
    NSArray *rows = self.dataSource[component];
    NSString *days = rows[row];
    lbl.text = days;
    [select addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(select);
    }];
    
    return select;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 1) {
        NSMutableArray *date = [NSMutableArray arrayWithCapacity:1];
        
        NSString *month = self.dataSource[1][row];
        for (NSInteger i = 1; i <= [self dayCount:[self.year integerValue] month:[month integerValue]]; i++) {
            [date addObject:[NSString stringWithFormat:@"%02zd",i]];
        }
        [self.dataSource removeObjectAtIndex:2];
        [self.dataSource insertObject:[date copy] atIndex:2];
        [self.pickerView reloadComponent:2];
    }
    
    
    switch (component) {
        case 0:
            self.year = self.dataSource[0][row];
            break;
        case 1:
            self.month = self.dataSource[1][row];
            break;
        case 2:
            self.day = self.dataSource[2][row];
            break;
        case 3:
            self.hour = self.dataSource[3][row];
            break;
        case 4:
            self.minute = self.dataSource[4][row];
            break;
        default:
            break;
    }
    
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@  %@ : %@",self.year,self.month,self.day,self.hour,self.minute];
}


#pragma mark - Data

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        //年
        [_dataSource addObject:@[@"2016",@"2017"]];
        
        //月
        NSMutableArray *date = [NSMutableArray arrayWithCapacity:1];
        for (NSInteger i = 1; i <= 12; i++) {
            [date addObject:[NSString stringWithFormat:@"%02zd",i]];
        }
        [_dataSource addObject:[date copy]];
        
        [date removeAllObjects];
        for (NSInteger i = 1; i <= 31; i++) {
            [date addObject:[NSString stringWithFormat:@"%02zd",i]];
        }
        [_dataSource addObject:[date copy]];
        
        //时
        [date removeAllObjects];
        for (NSInteger i = 0; i <= 23; i++) {
            [date addObject:[NSString stringWithFormat:@"%02zd",i]];
        }
        [_dataSource addObject:[date copy]];
        
        [date removeAllObjects];
        for (NSInteger i = 0; i <= 59; i++) {
            [date addObject:[NSString stringWithFormat:@"%02zd",i]];
        }
        [_dataSource addObject:[date copy]];
        [date removeAllObjects];

    }
    
    return _dataSource;
}

- (NSInteger)dayCount:(NSInteger)years month:(NSInteger)month
{
    NSInteger count = 0;
    if (month == 2) {
        if((years % 4 == 0 && years % 100!=0) || years % 400 == 0) //是闰年
        {
            count = 29;
        }
        else
        {
            count = 28;
        }

    }else if (4 == month || 6 == month || 9 == month || 11 == month){
        count = 30;
    }else{
        count = 31;
    }
    
    return count;
}

#pragma mark - Lazy Load

- (UILabel *)currentTimeLabel
{
    if (_currentTimeLabel == nil) {
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.font = [UIFont systemFontOfSize:13.];
        _currentTimeLabel.textColor = [UIColor colorWithRed:77/255. green:77/255. blue:77/255. alpha:1];
        [self addSubview:_currentTimeLabel];
    }
    
    return _currentTimeLabel;
}

- (UIPickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        [self addSubview:_pickerView];
    }
    
    return _pickerView;
}

- (UIView *)sepLine
{
    if (_sepLine ==  nil) {
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = [UIColor blackColor];
        [self addSubview:_sepLine];
    }
    return _sepLine;
}


- (UIButton *)checkBtn
{
    if (_checkBtn == nil) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_checkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_checkBtn setBackgroundColor:[UIColor blackColor]];
        [self addSubview:_checkBtn];
    }
    return _checkBtn;
}

- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setBackgroundColor:[UIColor grayColor]];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithRed:77/255. green:77/255. blue:77/255. alpha:1] forState:UIControlStateNormal];
        [self addSubview:_cancelBtn];
        
    }
    
    return _cancelBtn;
}

@end
