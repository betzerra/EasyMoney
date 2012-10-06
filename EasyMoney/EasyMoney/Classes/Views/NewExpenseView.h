//
//  NewExpenseView.h
//  EasyMoney
//
//  Created by Ezequiel A Becerra on 10/4/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewExpenseViewDelegateProtocol.h"

#define CORNER_RADIUS 7

@interface NewExpenseView : UIView{
    NSDateFormatter *dateFormatter;
    NSDate *dateSelected;
    
    IBOutlet UITextField *expenseTextInput;
    IBOutlet UIButton *dateButton;
    id <NewExpenseViewDelegateProtocol> delegate;
}

@property (readonly) NSString *text;
@property (assign) id <NewExpenseViewDelegateProtocol> delegate;
@property (retain) NSDate *dateSelected;

- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)acceptButtonTapped:(id)sender;
- (IBAction)dateButtonTapped:(id)sender;

@end
