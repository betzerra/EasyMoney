//
//  DateSelectionView.m
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/6/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "DateSelectionView.h"

@implementation DateSelectionView
@synthesize delegate;

#pragma mark - Private

-(void)setup{
    calendarView = [[CKCalendarView alloc] initWithStartDay:startMonday];
    calendarView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:calendarView];
    self.clipsToBounds = YES;
}

#pragma mark - Properties

-(void)setDelegate:(id<CKCalendarDelegate>)aDelegate{
    calendarView.delegate = aDelegate;
}

-(id<CKCalendarDelegate>)delegate{
    return calendarView.delegate;
}

-(void)setSelectedDate:(NSDate *)aDate{
    calendarView.selectedDate = aDate;
}

-(NSDate *)selectedDate{
    return calendarView.selectedDate;
}

#pragma mark - Public

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)dealloc {
    [calendarView release];
    [super dealloc];
}

@end
