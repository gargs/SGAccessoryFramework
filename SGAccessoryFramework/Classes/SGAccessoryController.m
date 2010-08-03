//
//  SGAccessoryController.m
//  SGAccessoryFramework
//
//  Created by Saurabh Garg on 8/3/10.
//  Copyright 2010 Cerebrawl. All rights reserved.
//

#import "SGAccessoryController.h"


@implementation SGAccessoryController

@synthesize anAccessory;
@synthesize aProtocolString;

+ (SGAccessoryController *)sharedAccessoryController {
	return nil;
}
- (void)setupAccessoryControllerforAccessory:(EAAccessory *)acc 
						  withProtocolString:(NSString *)protocolString {}
- (BOOL)openSession {
	return NO;
}
- (void)closeSession {}

- (void)writeData:(NSData *)writeData {}
- (void)write {}
- (void)read {}
- (void)accessoryDidDisconnect:(EAAccessory *)accessory {}

@end
