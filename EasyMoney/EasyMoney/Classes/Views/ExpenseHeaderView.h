//
//  ExpenseHeaderView.h
//  EasyMoney
//
//  Created by Ezequiel Becerra on 10/8/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseHeaderView : UIView{
    IBOutlet UILabel *titleLabel;
}

@property (copy) NSString *title;

@end
