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
    IBOutlet UITextField *expenseTextInput;
    id <NewExpenseViewDelegateProtocol> delegate;
}

@property (assign) id <NewExpenseViewDelegateProtocol> delegate;

- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)acceptButtonTapped:(id)sender;

@end
