//
//  ViewController.m
//  learnEncription
//
//  Created by Vaibhav Saran on 9/10/15.
//  Copyright (c) 2015 Practice Builders Inc. All rights reserved.
//

#import "ViewController.h"
#import "RNDecryptor.h"
#import "RNEncryptor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSString *message = @"AwEV9Vea5H7GMr72mgtl18vAiBhAvSaRaNeLiInDiAZB5jIhbpPrrudrSATvAiBhAvSaRaNeLiInDiAQ/0JvcYZNplVZTTJUcBit9oQb9qcLeBrRXMTwVdkmk8LOXA4lP1kUkwmDdPBlnsMGn9TCJBUMuzvAiBhAvSaRaNeLiInDiAk8OjcyF05bFejvAiBhAvSaRaNeLiInDiAmOcmUFgeOApRRpSTX1nxkxiAgmGVv3puke92CU9DAG62SxhduOtzjeC473LLIuRFy6KbDa3ydkmEU/C4hQv4IEed8WzpTt6dNzo8MEUX1Yd7p6vAiBhAvSaRaNeLiInDiAsHTsoT4oxHVacOf/vuYitp1HdX1GhOOTjVM8j61WNccXmotJK1nKaT7LnNph9WBtC0lgtxHQNSNHTF1AI=";
    NSString *password = @"TO/EswNM/JszVNcdkF/SsQ";

    NSData *data = [[NSData alloc] initWithBase64EncodedString:[message stringByReplacingOccurrencesOfString:@"vAiBhAvSaRaNeLiInDiA" withString:@"+"] options:0];
    NSError *error;
    NSData *decryptedData = [RNDecryptor decryptData:data
                                        withPassword:password
                                               error:&error];

    NSString* newStr = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];

    if(!error)
        NSLog(@"\n\nString:\n%@", newStr);
    else
        NSLog(@"\n\nError:%@", error);
    NSLog(@"\nEnc Lenght: %lu", message.length);
    NSLog(@"\nDec Lenght: %lu", newStr.length);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end










