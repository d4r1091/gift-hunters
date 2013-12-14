//
//  GiftView.m
//  GiftHunters
//
//  Created by Dario Webmonks on 14/12/13.
//  Copyright (c) 2013 GiftHunters. All rights reserved.
//

#import "GiftView.h"

@implementation GiftView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [self loadInstanceFromNib];
    }
    return self;
}

- (GiftView *)loadInstanceFromNib
{
	GiftView *result = nil;
	NSArray* elements = [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner: nil options: nil];
	for (id anObject in elements)
	{
		if ([anObject isKindOfClass:[self class]])
		{
			result = anObject;
			break;
		}
	}
	return result;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)removeViewAction:(id)sender {
    [self removeFromSuperview];
}
@end
