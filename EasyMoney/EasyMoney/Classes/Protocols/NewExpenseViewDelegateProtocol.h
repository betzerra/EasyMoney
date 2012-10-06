//
//  NewExpenseViewDelegateProtocol.h
//  EasyMoney
//
//  Created by Ezequiel A Becerra on 10/4/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewExpenseViewDelegateProtocol <NSObject>

-(void)acceptButtonTapped;
-(void)cancelButtonTapped;
-(void)dateButtonTapped;

@end
