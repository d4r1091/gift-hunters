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
@property (strong, nonatomic) IBOutlet UILabel *lblTrovato;
@property (strong, nonatomic) IBOutlet UILabel *lblPunti;
@property (strong, nonatomic) IBOutlet UILabel *lblDescrRegalo;
@property (strong, nonatomic) IBOutlet UILabel *lblDonatore;
@property (strong, nonatomic) IBOutlet UIImageView *imgRegalo;
@property NSString *textDescrRegaloView;
@property NSString *textDonatore;
@property NSString *textPunto;
@property (strong, nonatomic) IBOutlet UILabel *lblGiftFrom;
@property NSString *urlImg;
@property bool beaconValido;


@end
