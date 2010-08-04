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

static SGAccessoryController *accessoryController;

+ (SGAccessoryController *)sharedAccessoryController {
	@synchronized(self) {
		if (accessoryController == nil)
			accessoryController = [[SGAccessoryController alloc] init];
	}
	return accessoryController;
}

- (void)setupAccessoryControllerforAccessory:(EAAccessory *)acc 
						  withProtocolString:(NSString *)protocolString {
	[anAccessory release];
	anAccessory = [acc retain];
	
	[aProtocolString release];
	aProtocolString = [protocolString copy];
}

- (BOOL)openSession {
	//TODO: Implement openSession
	return NO;
}

- (void)closeSession {
	//TODO: Implement closeSession
}

- (void)writeData:(NSData *)data {
	if (writeData == nil)
		writeData = [[NSMutableData alloc] init];
	[writeData appendData:data];
	
	while (([[aSession outputStream] hasSpaceAvailable]) && ([writeData length] > 0)) {
		NSInteger bytesWritten = [[aSession outputStream] write:[writeData bytes]
													  maxLength:[writeData length]];
		if (bytesWritten == -1) {
			NSLog(@"Stream error on write");
			break;
		}
		else if (bytesWritten > 0) 
			[writeData replaceBytesInRange:NSMakeRange(0, bytesWritten) 
								 withBytes:NULL 
									length: 0];
	}
}

- (void)readData {
	uint8_t buf[INPUT_BUFFER_LENGTH];
	readData = [[NSMutableData alloc] init];
	
	while ([[aSession inputStream] hasBytesAvailable]) {
		NSUInteger bytesRead = [[aSession inputStream] read:buf
												  maxLength:INPUT_BUFFER_LENGTH];
		[readData appendBytes:buf length:bytesRead];
	}
	//This is where we issue a notification to the listener with data as payload
	//In the future we would prefer to use delegation
	NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc] init];
	[userInfoDict setObject:readData forKey:@"payload"];
	[[NSNotificationCenter defaultCenter] postNotificationName:kSGAccessoryNotification
														object:self
													  userInfo:userInfoDict];
	[userInfoDict release];
	[readData release];
}

- (void)accessoryDidDisconnect:(EAAccessory *)accessory {
	NSLog(@"Accessory disconnected");
	[self setupAccessoryControllerforAccessory:nil
							withProtocolString:nil];
}

- (void)dealloc {
	[self closeSession];
	[self setupAccessoryControllerforAccessory:nil
							withProtocolString:nil];
	[writeData release];
	writeData = nil;
	
	[readData release];
	readData = nil;
	
	[super dealloc];
}

//TODO: add stream delegate methods
//TODO: Implement delegation or something better

@end
