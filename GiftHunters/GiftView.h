//
//  GiftView.h
//  GiftHunters
//
//  Created by Dario Webmonks on 14/12/13.
//  Copyright (c) 2013 GiftHunters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftView : UIView
@property (strong, nonatomic) IBOutlet UIButton *removeViewBtn;
- (IBAction)removeViewAction:(id)sender;
- (GiftView *)loadInstanceFromNib;

@end
