//
//  PeripheralShareInstance.m
//  iosBLEperipheral
//
//  Created by ha netlab on 17/6/17.
//  Copyright © 2017年 qixiangkeji. All rights reserved.
//

#import "PeripheralShareInstance.h"

@implementation PeripheralShareInstance
@synthesize peripheralManager;
@synthesize delegate;

+(PeripheralShareInstance *) sharedInstance{
    static PeripheralShareInstance *sensor = nil;
    static dispatch_once_t predict;
    dispatch_once(&predict, ^{
        sensor = [[PeripheralShareInstance alloc] init];
    });
    return sensor;
}
-(void)setup{
    peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil ];
}
//peripheralManager状态改变
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    switch (peripheral.state) {
            //在这里判断蓝牙设别的状态  当开启了则可调用  setUp方法(自定义)
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"powered on");
            //[info setText:[NSString stringWithFormat:@"设备名%@已经打开，可以使用center进行连接",LocalNameKey]];
            [self setUp];
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"powered off");
           // [info setText:@"powered off"];
            break;
            
        default:
            break;
    }
}
-(void)setUp{
    //characteristics字段描述
    CBUUID *CBUUIDCharacteristicUserDescriptionStringUUID = [CBUUID UUIDWithString:CBUUIDCharacteristicUserDescriptionString];
    
    /*
     可以通知的Characteristic
     properties：CBCharacteristicPropertyNotify
     permissions CBAttributePermissionsReadable
     */
    CBMutableCharacteristic *notiyCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:notiyCharacteristicUUID] properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    
    /*
     可读写的characteristics
     properties：CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead
     permissions CBAttributePermissionsReadable | CBAttributePermissionsWriteable
     */
    CBMutableCharacteristic *readwriteCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:readwriteCharacteristicUUID] properties:CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable | CBAttributePermissionsWriteable];
    //设置description
    CBMutableDescriptor *readwriteCharacteristicDescription1 = [[CBMutableDescriptor alloc]initWithType: CBUUIDCharacteristicUserDescriptionStringUUID value:@"name"];
    [readwriteCharacteristic setDescriptors:@[readwriteCharacteristicDescription1]];

    //service1初始化并加入两个characteristics
    CBMutableService *service1 = [[CBMutableService alloc]initWithType:[CBUUID UUIDWithString:ServiceUUID1] primary:YES];
    NSLog(@"%@",service1.UUID);
    
    [service1 setCharacteristics:@[notiyCharacteristic,readwriteCharacteristic]];
    
    
    //添加后就会调用代理的- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
    [peripheralManager addService:service1];
    // [peripheralManager addService:service2];
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    if (error == nil) {
        self.serviceNum++;
    }
    
    //因为我们添加了2个服务，所以想两次都添加完成后才去发送广播
    if (self.serviceNum==1) {
        //添加服务后可以在此向外界发出通告 调用完这个方法后会调用代理的
        //(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
        [peripheralManager startAdvertising:@{
                                              CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:ServiceUUID1]],
                                             // CBAdvertisementDataLocalNameKey : LocalNameKey
                                          
                                              }
         ];
        
    }
    
}
//peripheral开始发送advertising
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    NSLog(@"in peripheralManagerDidStartAdvertisiong");
}

//订阅characteristics
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic{
    NSLog(@"订阅了 %@的数据",characteristic.UUID);
    //每秒执行一次给主设备发送一个当前时间的秒数
    //  timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendData:) userInfo:characteristic  repeats:YES];
    
    CH = characteristic;
  //  [self send1:(CBMutableCharacteristic *)characteristic];
    
    //   [self sendData:CH];
    
}

-(BOOL)notifyData:(NSData *)data{
    if(CH!=NULL){
 return  [peripheralManager updateValue:data forCharacteristic:(CBMutableCharacteristic *)CH onSubscribedCentrals:nil];
    }else{
    
        return false;
    }
}
//取消订阅characteristics
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic{
    NSLog(@"取消订阅 %@的数据",characteristic.UUID);
    //取消回应
    //  [timer invalidate];
}

//发送数据，发送当前时间的秒数
-(BOOL)sendData:(NSTimer *)t {
    CBMutableCharacteristic *characteristic = t.userInfo;
    NSDateFormatter *dft = [[NSDateFormatter alloc]init];
    [dft setDateFormat:@"mm"];
    //  NSLog(@"%@",[dft stringFromDate:[NSDate date]]);
    
    //执行回应Central通知数据
    return  [peripheralManager updateValue:[@"" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:(CBMutableCharacteristic *)characteristic onSubscribedCentrals:nil];
    
}
//写characteristics请求
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests{
    //  NSLog(@"didReceiveWriteRequests");
    CBATTRequest *request = requests[0];
    
    //判断是否有写数据的权限
    if (request.characteristic.properties & CBCharacteristicPropertyWrite) {

//        if (self.z == 0) {
//            self.ms = [[NSDate date]timeIntervalSince1970]*1000;
//        }
//        if (self.z == 99) {
//            self.t = [[NSDate date]timeIntervalSince1970]*1000;
//            NSLog(@"%@",[NSString stringWithFormat:@"%llu",self.t-self.ms])  ;
//        }
//        self.z++;

        
        //需要转换成CBMutableCharacteristic对象才能进行写值
       [self.delegate valueUpdated:request.value];
//        self.ms = [[NSDate date] timeIntervalSince1970]*1000;
//        
//        self.c =(CBMutableCharacteristic *)request.characteristic;
//        self.c.value = request.value;
//        
//        self.string = [NSString stringWithFormat:@"%@",self.c.value];
//        self.a = [self.string stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//       self.b = [self.a stringByReplacingOccurrencesOfString:@" " withString:@""];
//        self.t = [self.b integerValue];
//        NSLog(@"t-ms=%@",[NSString stringWithFormat:@"%llu",self.t-self.ms]);
//      //  [lb setTitle:[NSString stringWithFormat:@"%llu",t-ms] forState:UIControlStateNormal];
//        //[a];
        [peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
//        if ([self.a hasPrefix:@"000"]) {
//            [self send1:(CBMutableCharacteristic *)self.CH];
//        }
//        else{
//            [self send2:(CBMutableCharacteristic *)self.CH];
//            
//        }
        
    }else{
        [peripheralManager respondToRequest:request withResult:CBATTErrorWriteNotPermitted];
    }
    
}
-(BOOL)send1:(CBMutableCharacteristic *)t {
    self.characteristic1 = t;
    //    NSDateFormatter *dft = [[NSDateFormatter alloc]init];
    //    [dft setDateFormat:@"mm"];
    //    NSLog(@"%@",[dft stringFromDate:[NSDate date]]);
    
    //执行回应Central通知数据
    return  [peripheralManager updateValue:[@"111" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:(CBMutableCharacteristic *)self.characteristic1 onSubscribedCentrals:nil];
    
}
-(BOOL)send2:(CBMutableCharacteristic *)t {
    self.characteristic2 = t;
    //    NSDateFormatter *dft = [[NSDateFormatter alloc]init];
    //    [dft setDateFormat:@"mm"];
    //    NSLog(@"%@",[dft stringFromDate:[NSDate date]]);
    
    //执行回应Central通知数据
    return  [peripheralManager updateValue:[@"1111" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:(CBMutableCharacteristic *)self.characteristic2 onSubscribedCentrals:nil];
    
}


- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral{
    // NSLog(@"peripheralManagerIsReadyToUpdateSubscribers");
    
}

@end
