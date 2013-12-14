//
//  GiftView.m
//  GiftHunters
//
//  Created by Dario Webmonks on 14/12/13.
//  Copyright (c) 2013 GiftHunters. All rights reserved.
//

#import "GiftView.h"
#import <FacebookSDK/FacebookSDK.h>

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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if(!_beaconValido)
    {
        [_lblDescrRegalo setHidden:true];
        [_lblDonatore setHidden:true];
        [_lblGiftFrom setHidden:true];
        [_imgRegalo setHidden:true];
    }
    else
    {
        NSURL *url = [NSURL URLWithString:_urlImg];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        [_imgRegalo setImage:image];
        _lblDonatore.text=_textDonatore;
        _lblDescrRegalo.text=_textDescrRegaloView;
    }
}


- (NSDictionary*)parseURLParams:(NSString *)query
{
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}


- (IBAction)fbShare:(id)sender
{
    // Put together the dialog parameters
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Ho trovato l'albero di natale!", @"name",
     @"Merry XMas!", @"caption",
     @"Auguri", @"description",
     @"http://www.wearemonk.com/", @"link",
     @"http://i.imgur.com/aEVRHIh.png", @"picture",
     nil];
    
    // Invoke the dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:
     ^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
         if (error) {
             // Error launching the dialog or publishing a story.
             NSLog(@"Error publishing story.");
         } else {
             if (result == FBWebDialogResultDialogNotCompleted) {
                 // User clicked the "x" icon
                 NSLog(@"User canceled story publishing.");
             } else {
                 // Handle the publish feed callback
                 NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                 if (![urlParams valueForKey:@"post_id"]) {
                     // User clicked the Cancel button
                     NSLog(@"User canceled story publishing.");
                 } else {
                     // User clicked the Share button
                     NSString *msg = [NSString stringWithFormat:
                                      @"Posted story, id: %@",
                                      [urlParams valueForKey:@"post_id"]];
                     NSLog(@"%@", msg);
                     // Show the result in an alert
                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                 message:msg
                                                delegate:nil
                                       cancelButtonTitle:@"OK!"
                                       otherButtonTitles:nil]
                      show];
                 }
             }
         }
     }];
}


- (IBAction)removeViewAction:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)share {
}
- (IBAction)FbShare:(id)sender {
}
@end
