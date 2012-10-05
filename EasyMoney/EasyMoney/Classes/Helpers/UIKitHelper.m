//
//  UIKitHelper.m
//  PixelKnights
//
//  Created by Ezequiel Becerra on 1/10/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "UIKitHelper.h"

@implementation UIKitHelper

+ (CGRect) centeredFrameWithUIView:(UIView *)aView{
    CGRect retVal = CGRectMake((aView.superview.frame.size.width - aView.frame.size.width)/2,
                               (aView.superview.frame.size.height - aView.frame.size.height)/2,
                               aView.frame.size.width,
                               aView.frame.size.height);
    return retVal;
}

+ (UIView*) viewFromNibNamed:(NSString*)nibname{
	UIView* view = nil;
	
	NSArray* tops = [[NSBundle mainBundle] loadNibNamed:nibname owner:nil options:nil];
	
	for( int i = 0;i < [tops count];i ++){
		if ( [[tops objectAtIndex:i] isKindOfClass:[UIView class]]){
			view = [tops objectAtIndex:i];
			break;
		}
	}	
		
	return view;
}

+ (BOOL) isIPad{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}

@end
