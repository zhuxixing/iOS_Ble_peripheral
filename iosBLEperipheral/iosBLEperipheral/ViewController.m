//
//  ViewController.m
//  iosBLEperipheral
//
//  Created by ha netlab on 17/6/17.
//  Copyright © 2017年 qixiangkeji. All rights reserved.
//

#import "ViewController.h"
#import "PeripheralShareInstance.h"
@interface ViewController ()<BTSmart>
@property(nonatomic,strong) PeripheralShareInstance *senseor;
@property (nonatomic,strong) UILabel *lb;
@property (nonatomic,strong) UISlider *sl;
@property (nonatomic)int a;
@property (nonatomic)UInt64 ms;
@property(nonatomic)UInt64 dd;
@property(nonnull,strong)NSTimer *timer10;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.senseor = [PeripheralShareInstance sharedInstance];
    [self.senseor setup];
    self.senseor.delegate = self;
     self.lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    [self.view addSubview:self.lb];
    self.lb.text = @"abcd";
    self.lb.backgroundColor = [UIColor redColor];
    self.a = 0;
    self.sl = [[UISlider alloc]initWithFrame:CGRectMake(200, 200, 300, 20)];
 //   [self.view addSubview:self.sl];
    self.sl.maximumValue = 20;
    self.sl.minimumValue = 0;
    self.sl.value = 3;
    self.sl.continuous = YES;
    [self.sl addTarget:self action:@selector(sliderchange:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(150 , 0, 100, 100)];
    [self.view addSubview:btn1];
    [btn1 setTitle:@"10ms" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 addTarget:self action:@selector(yanchi10ms) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(250 , 0, 100, 100)];
    [self.view addSubview:btn2];
    [btn2 setTitle:@"20ms" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor yellowColor];
    [btn2 addTarget:self action:@selector(yanchi20ms) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(350 , 0, 100, 100)];
    [self.view addSubview:btn3];
    [btn3 setTitle:@"30ms" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor blueColor];
    [btn3 addTarget:self action:@selector(yanchi30ms) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(450 , 0, 100, 100)];
    [self.view addSubview:btn4];
    [btn4 setTitle:@"40ms" forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor cyanColor];
    [btn4 addTarget:self action:@selector(yanchi40ms) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(550 , 0, 100, 100)];
    [self.view addSubview:btn5];
    [btn5 setTitle:@"50ms" forState:UIControlStateNormal];
    btn5.backgroundColor = [UIColor grayColor];
    [btn5 addTarget:self action:@selector(yanchi50ms) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn6 = [[UIButton alloc]initWithFrame:CGRectMake(150 , 150, 100, 100)];
    [self.view addSubview:btn6];
    [btn6 setTitle:@"60ms" forState:UIControlStateNormal];
    btn6.backgroundColor = [UIColor lightGrayColor];
    [btn6 addTarget:self action:@selector(yanchi60ms) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn7 = [[UIButton alloc]initWithFrame:CGRectMake(150 , 300, 100, 100)];
    [self.view addSubview:btn7];
    [btn7 setTitle:@"70ms" forState:UIControlStateNormal];
    btn7.backgroundColor = [UIColor darkGrayColor];
    [btn7 addTarget:self action:@selector(yanchi70ms) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn8 = [[UIButton alloc]initWithFrame:CGRectMake(150 , 450, 100, 100)];
    [self.view addSubview:btn8];
    [btn8 setTitle:@"80ms" forState:UIControlStateNormal];
    btn8.backgroundColor = [UIColor yellowColor];
    [btn8 addTarget:self action:@selector(yanchi80ms) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn9 = [[UIButton alloc]initWithFrame:CGRectMake(150 , 550, 100, 100)];
    [self.view addSubview:btn9];
    [btn9 setTitle:@"90ms" forState:UIControlStateNormal];
    btn9.backgroundColor = [UIColor greenColor];
    [btn9 addTarget:self action:@selector(yanchi90ms) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn10 = [[UIButton alloc]initWithFrame:CGRectMake(300 , 200, 100, 100)];
    [self.view addSubview:btn10];
    [btn10 setTitle:@"100ms" forState:UIControlStateNormal];
    btn10.backgroundColor = [UIColor yellowColor];
    [btn10 addTarget:self action:@selector(yanchi100ms) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btninit  =[[UIButton   alloc]initWithFrame:CGRectMake(400, 400, 100, 100)];
    [self.view addSubview:btninit];
    [btninit setTitle:@"init" forState:UIControlStateNormal];
    btninit.backgroundColor = [UIColor blackColor];
     [btninit addTarget:self action:@selector(chushihua) forControlEvents:UIControlEventTouchUpInside];
}
-(void)chushihua{

    [self.timer10 invalidate];
    self.a = 0;
}
-(void)yanchi10ms{

    self.timer10 = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(fasong) userInfo:nil repeats:YES];
}
-(void)yanchi20ms{
    
    self.timer10 = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(fasong) userInfo:nil repeats:YES];
}
-(void)yanchi30ms{
    
    self.timer10 = [NSTimer scheduledTimerWithTimeInterval:0.03f target:self selector:@selector(fasong) userInfo:nil repeats:YES];
}
-(void)yanchi40ms{
    
    self.timer10 = [NSTimer scheduledTimerWithTimeInterval:0.04f target:self selector:@selector(fasong) userInfo:nil repeats:YES];
}

-(void)yanchi50ms{
    
    self.timer10 = [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(fasong) userInfo:nil repeats:YES];
}
-(void)yanchi60ms{
    
    self.timer10 = [NSTimer scheduledTimerWithTimeInterval:0.06f target:self selector:@selector(fasong) userInfo:nil repeats:YES];
}

-(void)yanchi70ms{
    
    self.timer10 = [NSTimer scheduledTimerWithTimeInterval:0.07f target:self selector:@selector(fasong) userInfo:nil repeats:YES];
}
-(void)yanchi80ms{
    
    self.timer10 = [NSTimer scheduledTimerWithTimeInterval:0.08f target:self selector:@selector(fasong) userInfo:nil repeats:YES];
}
-(void)yanchi90ms{
    
    self.timer10 = [NSTimer scheduledTimerWithTimeInterval:0.09f target:self selector:@selector(fasong) userInfo:nil repeats:YES];
}
-(void)yanchi100ms{
    
    self.timer10 = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(fasong) userInfo:nil repeats:YES];
}

-(void)fasong{
   
    [self.senseor notifyData:[[NSString stringWithFormat:@"cc%d",++self.a] dataUsingEncoding:NSUTF8StringEncoding]];
}


-(void)sliderchange:(id)sender{

    if ([sender isKindOfClass:[UISlider class]]) {
        UISlider *slider = sender;
        float value = slider.value;
        NSLog(@"%d",(int)value);
        self.lb.text =[NSString stringWithFormat:@"%d", (int)value];
        switch ((int)value) {
        //    case 0:
//                [self.senseor notifyData:[self stringToByte:@"040401030100"]];
//                break;
            case 1:
                [self.senseor notifyData:[self stringToByte:@"0404010300"]];
                break;
      //      case 2:
//                [self.senseor notifyData:[self stringToByte:@"040401030102"]];
//                break;
            case 3:
                [self.senseor notifyData:[self stringToByte:@"0404010302"]];
                break;
    //        case 4:
//                [self.senseor notifyData:[self stringToByte:@"040401030104"]];
//                break;
            case 5:
                [self.senseor notifyData:[self stringToByte:@"0404010304"]];
                break;
   //         case 6:
//                [self.senseor notifyData:[self stringToByte:@"040401030106"]];
//                break;
            case 7:
                [self.senseor notifyData:[self stringToByte:@"0404010306"]];
                break;
      //      case 8:
//                [self.senseor notifyData:[self stringToByte:@"040401030108"]];
//                break;
            case 9:
                [self.senseor notifyData:[self stringToByte:@"0404010308"]];
                break;
     //       case 10:
//                [self.senseor notifyData:[self stringToByte:@"04040103010a"]];
//                break;
            case 11:
                [self.senseor notifyData:[self stringToByte:@"040401030a"]];
                break;
        //    case 12:
//                [self.senseor notifyData:[self stringToByte:@"04040103010c"]];
//                break;
            case 13:
                [self.senseor notifyData:[self stringToByte:@"040401030c"]];
                break;
       //     case 14:
//                [self.senseor notifyData:[self stringToByte:@"04040103010e"]];
//                break;
            case 15:
                [self.senseor notifyData:[self stringToByte:@"040401030e"]];
                break;
        //    case 16:
//                [self.senseor notifyData:[self stringToByte:@"040401030110"]];
//                break;
            case 17:
                [self.senseor notifyData:[self stringToByte:@"0404010310"]];
                break;
       //     case 18:
//                [self.senseor notifyData:[self stringToByte:@"040401030112"]];
//                break;
            case 19:
                [self.senseor notifyData:[self stringToByte:@"0404010312"]];
                break;
            case 20:
                [self.senseor notifyData:[self stringToByte:@"0404010314"]];
                break;

            default:
                break;
        }

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)valueUpdated:(NSData *)data{
//    if (self.a == 0) {
//        self.ms = [[NSDate date]timeIntervalSince1970]*1000;
//    }
//    if (self.a==99) {
//        self.dd = [[NSDate date]timeIntervalSince1970]*1000;
//        self.lb.text = [NSString stringWithFormat:@"%llu",self.dd-self.ms];
//    }
//    
//    self.a++;
self.lb.text = [NSString stringWithFormat:@"%@",data];
//    NSLog(@"写过来的是这%@",[NSString stringWithFormat:@"%@",data]);
 //   [self.senseor notifyData:data];
}
-(NSData*)stringToByte:(NSString*)string
{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;
        
        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
        NSData *data = [NSData dataWithBytes:tempbyt length:1];
        [bytes appendData:data];
    }
    return bytes;
}
@end
