//
//  UIKitHelper.h
//  PixelKnights
//
//  Created by Ezequiel Becerra on 1/10/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIKitHelper : NSObject

+ (CGRect) centeredFrameWithUIView:(UIView *)aView;
+ (UIView*) viewFromNibNamed:(NSString*)nibname;
+ (BOOL) isIPad;

@end
