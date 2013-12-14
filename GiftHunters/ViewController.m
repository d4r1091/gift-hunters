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
#import "ESTBeaconManager.h"

@interface ViewController () <ESTBeaconManagerDelegate>

@property (nonatomic, strong) ESTBeaconManager* beaconManager;
@property (nonatomic, strong) ESTBeacon* selectedBeacon;

@end

@implementation ViewController
GiftView *gift;



- (void)viewDidLoad
{
    
    [super viewDidLoad];
 
                       
	// Do any additional setup after loading the view, typically from a nib.
    [self initBeaconManager];
}


- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    
    NSString *nome = user.first_name;
    NSLog(@"%@", nome);
    
    
}

- (void)initBeaconManager
{
    // setup Estimote beacon manager
    // craete manager instance
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    _beaconsToBeFound = [NSMutableArray arrayWithObjects:BEACON_1, BEACON_2, BEACON_3, BEACON_4, BEACON_5, XMAS_TREE, nil];
    // create sample region object (you can additionaly pass major / minor values)
    ESTBeaconRegion* region = [[ESTBeaconRegion alloc] initRegionWithIdentifier:@"EstimoteSampleRegion"];
    
    // start looking for estimtoe beacons in region
    // when beacon ranged beaconManager:didRangeBeacons:inRegion: invoked
    [self.beaconManager startRangingBeaconsInRegion:region];
}

-(void)beaconManager:(ESTBeaconManager *)manager
     didRangeBeacons:(NSArray *)beacons
            inRegion:(ESTBeaconRegion *)region
{
    BOOL areThereBeacons = [beacons count] > 0;
    
    if(areThereBeacons)
    {
        // beacon array is sorted based on distance
        // closest beacon is the first one
        ESTBeacon* closestBeacon = [beacons objectAtIndex:0];
        
        BOOL proximityFarOrUnknow = CLProximityFar||CLProximityUnknown;
        BOOL proximityNear = CLProximityNear;
        BOOL proximityImmediate = CLProximityImmediate;
        BOOL foundXmasTreeAtFirst = [closestBeacon.minor isEqualToNumber:XMAS_TREE];
        BOOL isTheRightBeacon = [closestBeacon.minor isEqualToNumber:[_beaconsToBeFound objectAtIndex:0]];
        
        if (foundXmasTreeAtFirst)
        {
            NSLog(@"TROVATO ALBERO LA PRIMA VOLTA");
            [manager stopAdvertising];
            [manager stopEstimoteBeaconDiscovery];
            [manager stopMonitoringForRegion:region];
            [manager stopRangingBeaconsInRegion:region];
        }
        else if (isTheRightBeacon&&[closestBeacon.minor isEqualToNumber:XMAS_TREE])
        {
            NSLog(@"ALBERO DI NATALE TROVATO");
        }
        else if (isTheRightBeacon&&proximityImmediate)
        {
            [self removeFoundBeaconWithMinor:closestBeacon.minor];
            [self callGiftViewForBeacon:closestBeacon.minor];
            NSLog(@"TROVATO BEACON: %@", [closestBeacon.minor stringValue]);
            
        }
        else if (isTheRightBeacon&&proximityNear)
        {
            _acquaFuoco.text = @"FUOCHERELLO";
        }
    }
}

- (void)removeFoundBeaconWithMinor:(NSNumber *)beacondFound
{
    [_beaconsToBeFound removeObject:beacondFound];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callGiftViewForBeacon:(NSNumber *)number {
    valido = [self checkBeacon];
    if(valido)
    {
        [self setRegalo:[number intValue]];
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
    if(!false)
    {
        return true;
    }
    else{
        
        return false;
    }
    
}
@end
