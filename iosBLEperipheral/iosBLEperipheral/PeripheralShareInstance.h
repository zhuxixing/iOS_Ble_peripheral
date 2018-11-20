//
//  PeripheralShareInstance.h
//  iosBLEperipheral
//
//  Created by ha netlab on 17/6/17.
//  Copyright © 2017年 qixiangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>
@protocol BTSmart
@optional
//
//- (void) peripheralFound:(CBPeripheral *)peripheral;
-(void)valueUpdated : (NSData *)data;
//
//-(void)dismiss;


@end
static NSString *const ServiceUUID1 = @"FEE8";
static NSString *const notiyCharacteristicUUID =  @"FFF7";
static NSString *const readwriteCharacteristicUUID =  @"FFF6";
static NSString * const LocalNameKey =  @"myPeripheral";
static  CBCharacteristic *CH;
@interface PeripheralShareInstance : NSObject<CBPeripheralManagerDelegate>
@property(nonatomic,strong)CBPeripheralManager *peripheralManager;
@property (nonatomic,strong) id<BTSmart> delegate;
@property (nonatomic) int serviceNum;
@property (nonatomic,strong)NSString *a;
@property(nonatomic,strong)NSString *b;

@property (nonatomic)UInt64 t;
@property(nonatomic)UInt64 ms;
@property(nonatomic)int z;
@property (nonatomic,strong)CBMutableCharacteristic *c;
@property (nonatomic,strong)NSString *string;
@property(nonatomic,strong)CBMutableCharacteristic *characteristic1;
@property(nonatomic,strong)CBMutableCharacteristic *characteristic2;
+(PeripheralShareInstance *)sharedInstance;
-(void) setup;
-(BOOL) notifyData:(NSData *)data;
@end
