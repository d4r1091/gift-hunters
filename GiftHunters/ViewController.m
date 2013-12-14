//
//  ViewController.m
//  GiftHunters
//
//  Created by Dario Webmonks on 14/12/13.
//  Copyright (c) 2013 GiftHunters. All rights reserved.
//

#import "ViewController.h"
#import "GiftView.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController
GiftView *gift;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callGiftView:(id)sender {
    valido = [self checkBeacon];
    if(valido)
    {
        [self setRegalo:1];
    }
    else
    {
        gift = [[GiftView alloc] init];
        gift.beaconValido=NO;
        gift.lblTrovato.text = @"Non hai trovato il regalo giusto!";
        gift.lblPunti.text = @"-5";
        [self.view addSubview:gift];

        
    }
    
   
}

-(void)setRegalo: (int)intRegalo
{
    PFQuery *queryRegalo = [PFQuery queryWithClassName:@"Gifts"];
    [queryRegalo whereKey:@"minor" equalTo:@(intRegalo)];
    [queryRegalo findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects)
            {
                textDescrRegalo=[object valueForKey:@"gift_description"];
                urlImage = [object valueForKey:@"url_img"];
                textGifter = [object valueForKey:@"gift_person"];
            }
            NSLog(@"%@", textDescrRegalo);
            NSLog(@"%@", urlImage);
            NSLog(@"%@", textGifter);
            
            gift = [[GiftView alloc] init];
            gift.beaconValido = YES;
            gift.lblTrovato.text = @"Regalo trovato!";
            gift.lblPunti.text = @"+10";
            gift.textDonatore = textGifter;
            gift.textDescrRegaloView = textDescrRegalo;
            gift.urlImg = urlImage;
            [self.view addSubview:gift];
        }
            else
        {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}


-(bool)checkBeacon
{
    if(false)
    {
        return true;
    }
    else{
        
        return false;
    }
    
}
@end
