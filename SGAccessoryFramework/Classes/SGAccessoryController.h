//
//  SGAccessoryController.h
//  SGAccessoryFramework
//
//  Created by Saurabh Garg on 8/3/10.
//  Copyright 2010 Cerebrawl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ExternalAccessory/ExternalAccessory.h>

#define INPUT_BUFFER_LENGTH 512
#define kSGAccessoryNotification @"SGAccessoryNotification"
#define kSGAccessoryProtocolString @"com.cerebrawl.ios.SGAccessoryFramework.demo"


@interface SGAccessoryController : NSObject <EAAccessoryDelegate>{
	EAAccessory *anAccessory;
	EASession *aSession;
	NSString *aProtocolString;
	
	NSMutableData *writeData;
	NSMutableData *readData;
}

+ (SGAccessoryController *)sharedAccessoryController;
- (void)setupAccessoryControllerforAccessory:(EAAccessory *)acc 
						  withProtocolString:(NSString *)protocolString;
- (BOOL)openSession;
- (void)closeSession;

- (void)writeData:(NSData *)data;
- (void)readData;
- (void)accessoryDidDisconnect:(EAAccessory *)accessory;

@property (nonatomic, readonly) EAAccessory *anAccessory;
@property (nonatomic, readonly) NSString *aProtocolString;

@end
