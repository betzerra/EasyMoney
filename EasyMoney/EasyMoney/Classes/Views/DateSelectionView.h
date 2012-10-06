//
//  DateSelectionView.h
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/6/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"

@interface DateSelectionView : UIView{
    CKCalendarView *calendarView;
}

@property (assign) id <CKCalendarDelegate> delegate;
@property (assign) NSDate *selectedDate;

@end
