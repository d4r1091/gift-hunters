//
//  ViewController.h
//  GiftHunters
//
//  Created by Dario Webmonks on 14/12/13.
//  Copyright (c) 2013 GiftHunters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSString *textDescrRegalo;
    NSString *textGifter;
    NSString *urlImage;
    bool valido;

}

@property (strong, nonatomic) IBOutlet UIButton *giftViewButton;
@property (weak, nonatomic) IBOutlet UILabel *punteggioTotale;
@property (weak, nonatomic) IBOutlet UILabel *ultimoRegaloTrovato;
@property (weak, nonatomic) IBOutlet UILabel *nRegaliTrovati;
@property (weak, nonatomic) IBOutlet UILabel *titoloRegalo;
@property (weak, nonatomic) IBOutlet UIImageView *imgRegalo;
@property (nonatomic) BOOL fuoco;
@property (weak, nonatomic) IBOutlet UILabel *acquaFuoco;
- (IBAction)callGiftView:(id)sender;


@end
