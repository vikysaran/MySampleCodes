//
//  ViewController.m
//  learningAfNetworking
//
//  Created by pbo on 2/25/16.
//  Copyright © 2016 Practice Builders. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet __block UIProgressView *progress;
@property (weak, nonatomic) IBOutlet __block UILabel *lbl;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _img.image = [UIImage imageNamed:@"taj.jpg"];
    //_img.image = [UIImage imageNamed:@"gotu.jpg"];
}

- (IBAction)btn_click:(id)sender
{
    NSLog(@"Clicked");
    _progress.progress = 0.00f;
    NSString *strServerUrl = @"http://staging.webpracticebuilders.com/test/upload.php";
    NSString *str = [[self class] encodeToBase64String:_img.image];

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Vaibhav", @"fname",
                          @"Saran", @"lname",
                          @"Faridabad", @"address",
                          str, @"myimage",
                          nil];

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:strServerUrl parameters:nil error:nil];

    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:req
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^
                      {
                          //Update the progress view
                          [self.progress setProgress:uploadProgress.fractionCompleted];
                          NSLog(@"Proggress%f",uploadProgress.fractionCompleted);
                          [_lbl setText:[NSString stringWithFormat:@"%.f%%", uploadProgress.fractionCompleted*100]];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
                  {
                      if (error)
                      {
                          NSLog(@"Error: %@", error);
                      }
                      else
                      {
                          NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                          //NSLog(@"\nresponseString:%@", responseString);
                          NSLog(@"DONE");
                      }
                  }];
    
    [uploadTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString *)encodeToBase64String:(UIImage *)image
{
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
}

@end
