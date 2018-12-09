//
//  ViewController.m
//  RGgif2images
//
//  Created by yangrui on 2018/12/1.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stest_gif_waiting.gif" ofType:nil];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    
    // 从data 中读取数据, 将 NSData 转换成CGImageSource
    CGImageSourceRef imgSourceRef = CGImageSourceCreateWithData( (__bridge CFDataRef)gifData, nil);
    
    NSInteger imgSourceCount = CGImageSourceGetCount(imgSourceRef);
    
    // 遍历所有的图片
    NSMutableArray <UIImage *>*imgArrM = [NSMutableArray array];
    NSTimeInterval totalDuration = 0;
    for(int i = 0; i < imgSourceCount ; i++ ){
        // image
        CGImageRef imgRef =  CGImageSourceCreateImageAtIndex(imgSourceRef, i, nil);
        UIImage *img = [[UIImage alloc] initWithCGImage:imgRef];
        [imgArrM addObject:img];
        
        //
        CFDictionaryRef propertyDic = CGImageSourceCopyPropertiesAtIndex(imgSourceRef, i, nil);
        
        NSDictionary *gifDic = CFDictionaryGetValue(propertyDic, kCGImagePropertyGIFDictionary);
        totalDuration += [gifDic[@"DelayTime"] floatValue];
        
    }
    
    
    NSLog(@"totalDuration : %f",totalDuration);
    
    
    
    self.imgView.animationImages = imgArrM;
    self.imgView.animationDuration = totalDuration;
    self.imgView.animationRepeatCount = 0;
    [self.imgView startAnimating];
}





@end
