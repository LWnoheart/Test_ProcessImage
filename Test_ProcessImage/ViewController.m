//
//  ViewController.m
//  ImageTest
//
//  Created by 李巍 on 16/8/26.
//  Copyright © 2016年 李巍. All rights reserved.
//

#import "ViewController.h"
@import GPUImage;

#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )
//处理32位像素的宏。为了得到红色通道的值，你需要得到前8位。为了得到其它的颜色通道值，你需要进行位移并取截取

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CGImageRef inputImageRef = [[UIImage imageNamed:@"ghost1.png"]CGImage];
//    NSUInteger width = CGImageGetWidth(inputImageRef);
//    NSUInteger height = CGImageGetHeight(inputImageRef);
//    
//    NSUInteger bytesPerPixel = 4;//每像素大小
//    NSUInteger bytesPerRow = bytesPerPixel * width;//计算图像每行有大
//    NSUInteger bitsPerComponent = 8;//每个颜色通道大小
//    
//    UInt32 *pixels;
//    pixels = calloc(height * width, sizeof(UInt32));//创建数组来存储像素的值
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(pixels, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
//    //创建一个RGB模式的颜色空间CGColorSpace和一个容器CGBitmapContext,将像素指针参数传递到容器中缓存进行存储
//    
//    
//    
//    CGContextDrawImage(context, CGRectMake(0, 0, width, height), inputImageRef);
//    //把缓存中的图形绘制到显示器上。像素的填充格式是由你在创建context的时候进行指定的
//    
//    
//    CGColorSpaceRelease(colorSpace);
//    CGContextRelease(context);
//    
//    
//    
//    NSLog(@"Brightness of image:");
//    // 2.
//    UInt32 * currentPixel = pixels;
//    for (NSUInteger j = 0; j < height; j++) {
//        for (NSUInteger i = 0; i < width; i++) {
//            // 3.得到当前像素的值赋值给currentPixel并把它的亮度值打印出来
//            UInt32 color = *currentPixel;
//            printf("%3.0f",     (R(color)+G(color)+B(color))/3.0);
//            // 4.指向下一个像素,把它加1后，它就会向前移动4字节（32位），然后指向了下一个像素的值
//            currentPixel++;
//            //还有一种非正统的方法就是把currentPiexl声明为一个指向8字节的类型的指针，比如char。这种方法，你每增加1，你将会移动图形的下一个颜色通道。与它进行位移运算，你会得到颜色通道的8位数值
//        } 
//        printf("\n"); 
//    }
    
    
    
//    CGRect changeRect = CGRectMake(100, 2000, 300, 300);
//    
//    
//    CGImageRef inputImageRef = [[UIImage imageNamed:@"Wallpaper.png"]CGImage];
//    NSUInteger width = CGImageGetWidth(inputImageRef);
//    NSUInteger height = CGImageGetHeight(inputImageRef);
//    
//    NSUInteger bytesPerPixel = 4;//每像素大小
//    NSUInteger bytesPerRow = bytesPerPixel * width;//计算图像每行有大
//    NSUInteger bitsPerComponent = 8;//每个颜色通道大小
//    
//    UInt32 *pixels;
//    pixels = calloc(height * width, sizeof(UInt32));//创建数组来存储像素的值
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(pixels, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
//    
//    CGContextDrawImage(context, CGRectMake(0, 0, width, height), inputImageRef);
//    
//    UInt32 * currentPixel = pixels;
//    for (NSUInteger j = 0; j < height; j++) {
//        for (NSUInteger i = 0; i < width; i++) {
//            if (i>changeRect.origin.x&&i<changeRect.origin.x+changeRect.size.width&&j>changeRect.origin.y&&j<changeRect.origin.y+changeRect.size.height) {
//                UInt32 color = *currentPixel;
//                *currentPixel = RGBAMake(R(color), G(color), B(color), 200);
//            }
//            currentPixel++;
//        }
//    }
//    
//    
//    
//    //把缓存中的图形绘制到显示器上。像素的填充格式是由你在创建context的时候进行指定的
//    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
//    UIImage *resultImage = [UIImage imageWithCGImage:newCGImage];
//
//    
//    
//    CGColorSpaceRelease(colorSpace);
//    CGContextRelease(context);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    WS(this);
    UIImage *wcwimae = [self ghostAddByGPUImage];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:wcwimae];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(this.view);
        make.width.height.lessThanOrEqualTo(this.view);
        make.width.equalTo(imageView.mas_height).multipliedBy(wcwimae.size.width/wcwimae.size.height);
    }];
    
    
    
}

-(UIImage *)ghostAddByGPUImage
{
    // 1. Create the GPUImagePictures
    UIImage *input = [UIImage imageNamed:@"Wallpaper.png"];
    GPUImagePicture * inputGPUImage = [[GPUImagePicture alloc] initWithImage:input];
    UIImage * ghostImage = [self createPaddedGhostImageWithSize:input.size];
    GPUImagePicture * ghostGPUImage = [[GPUImagePicture alloc] initWithImage:ghostImage];
    // 2. Set up the filter chain
    GPUImageAlphaBlendFilter * alphaBlendFilter = [[GPUImageAlphaBlendFilter alloc] init];//滤镜
    alphaBlendFilter.mix = 0.5;
    [inputGPUImage addTarget:alphaBlendFilter atTextureLocation:0];//底
    [ghostGPUImage addTarget:alphaBlendFilter atTextureLocation:1];//顶
    GPUImageGrayscaleFilter * grayscaleFilter = [[GPUImageGrayscaleFilter alloc] init];
    [alphaBlendFilter addTarget:grayscaleFilter];
    // 3. Process & grab output image
    [grayscaleFilter useNextFrameForImageCapture];
    [inputGPUImage processImage];
    [ghostGPUImage processImage];
    UIImage * output = [grayscaleFilter imageFromCurrentFramebuffer];
    return output;
}

-(UIImage *)ghostAddByCoreImage
{
    //Core Image
    //Core Image是Apple的图像处理的解决方案。它避免了所有底层的像素操作方法，转而使用高级别的滤镜替代了它们。Core Image最好的部分在于它对比操作原始像素或Core Graphics有着极好的性能。这个库使用CPU和GPU混合处理提供接近实时的性能。Apple还提供了巨大的预先制作的滤镜库。在OSX中，你甚至可以使用Core Image Kernel Language创建你自己的滤镜.
    
    UIImage *bottomImage = [UIImage imageNamed:@"Wallpaper.png"];
    
    CIImage * inputCIImage = [[CIImage alloc] initWithImage:bottomImage];
    // 1. Create a grayscale filter.你可能记得，饱和度是HSV颜色空间的一个通道。这里的0表示了灰度。
    CIFilter * grayFilter = [CIFilter filterWithName:@"CIColorControls"];
    [grayFilter setValue:@(0) forKeyPath:@"inputSaturation"];
    // 2. Create your ghost filter
    // Use Core Graphics for this
    UIImage * ghostImage = [self createPaddedGhostImageWithSize:bottomImage.size];
    CIImage * ghostCIImage = [[CIImage alloc] initWithImage:ghostImage];
    // 3. Apply alpha to Ghosty
    CIFilter * alphaFilter = [CIFilter filterWithName:@"CIColorMatrix"];
    CIVector * alphaVector = [CIVector vectorWithX:0 Y:0 Z:0.5 W:0];
    [alphaFilter setValue:alphaVector forKeyPath:@"inputAVector"];
    // 4. Alpha blend filter
    CIFilter * blendFilter = [CIFilter filterWithName:@"CISourceAtopCompositing"];
    // 5. Apply your filters
    [alphaFilter setValue:ghostCIImage forKeyPath:@"inputImage"];
    ghostCIImage = [alphaFilter outputImage];
    [blendFilter setValue:ghostCIImage forKeyPath:@"inputImage"];
    [blendFilter setValue:inputCIImage forKeyPath:@"inputBackgroundImage"];
    CIImage * blendOutput = [blendFilter outputImage];
    [grayFilter setValue:blendOutput forKeyPath:@"inputImage"];
    CIImage * outputCIImage = [grayFilter outputImage];
    // 6. Render your output image
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef outputCGImage = [context createCGImage:outputCIImage fromRect:[outputCIImage extent]];
    UIImage * outputImage = [UIImage imageWithCGImage:outputCGImage];
    CGImageRelease(outputCGImage);
    return outputImage;
}

- (UIImage *)createPaddedGhostImageWithSize:(CGSize)inputSize {
    UIImage * ghostImage = [UIImage imageNamed:@"ghost.png"];
    CGFloat ghostImageAspectRatio = ghostImage.size.width / ghostImage.size.height;
    NSInteger targetGhostWidth = inputSize.width * 0.25;
    CGSize ghostSize = CGSizeMake(targetGhostWidth, targetGhostWidth / ghostImageAspectRatio);
    CGPoint ghostOrigin = CGPointMake(inputSize.width * 0.5, inputSize.height * 0.2);
    CGRect ghostRect = {ghostOrigin, ghostSize};
    UIGraphicsBeginImageContext(inputSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect inputRect = {CGPointZero, inputSize};
    CGContextClearRect(context, inputRect);
    CGAffineTransform flip = CGAffineTransformMakeScale(1.0, -1.0);
    CGAffineTransform flipThenShift = CGAffineTransformTranslate(flip,0,-inputSize.height);
    CGContextConcatCTM(context, flipThenShift);
    CGRect transformedGhostRect = CGRectApplyAffineTransform(ghostRect, flipThenShift);
    CGContextDrawImage(context, transformedGhostRect, [ghostImage CGImage]);
    UIImage * paddedGhost = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return paddedGhost;
}


-(UIImage *)ghostAddByCoreGraphics
{
    //使用Core Graphics
    //context，包括了当前的填充颜色，描边颜色，变形，蒙版，在哪里绘制等。Bitmap context，它可以绘制位图。
    
    UIImage *bottomImage = [UIImage imageNamed:@"Wallpaper.png"];
    CGRect rect = {CGPointZero,bottomImage.size};
    NSInteger bottomWidth = CGRectGetWidth(rect);
    NSInteger bottomHeight = CGRectGetHeight(rect);
    // 1) Calculate the location of Ghosty
    UIImage *ghostImage = [UIImage imageNamed:@"ghost.png"];
    CGFloat ghostImageAspectRatio = ghostImage.size.width / ghostImage.size.height;
    NSInteger targetGhostWidth = bottomWidth * 0.25;
    CGSize ghostSize = CGSizeMake(targetGhostWidth, targetGhostWidth / ghostImageAspectRatio);
    CGPoint ghostOrigin = CGPointMake(bottomWidth * 0.5, bottomHeight * 0.2);
    CGRect ghostRect = {ghostOrigin, ghostSize};
    // 2) Draw your image into the context.
    UIGraphicsBeginImageContext(bottomImage.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform flip = CGAffineTransformMakeScale(1.0, -1.0);
    CGAffineTransform flipThenShift = CGAffineTransformTranslate(flip,0,-bottomHeight);
    CGContextConcatCTM(context, flipThenShift);
    CGContextDrawImage(context, rect, [bottomImage CGImage]);
    CGContextSetBlendMode(context, kCGBlendModeSourceAtop);
    CGContextSetAlpha(context,0.5);
    CGRect transformedGhostRect = CGRectApplyAffineTransform(ghostRect, flipThenShift);
    CGContextDrawImage(context, transformedGhostRect, [ghostImage CGImage]);
    // 3) Retrieve your processed image
    UIImage * imageWithGhost = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 4) Draw your image into a grayscale context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    context = CGBitmapContextCreate(nil, bottomWidth, bottomHeight,
                                    8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CGContextDrawImage(context, rect, [imageWithGhost CGImage]);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage * finalImage = [UIImage imageWithCGImage:imageRef];
    // 5) Cleanup
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    //注意到为什么我们第二次需要释放context而第一次不需要了吗？这是因为第一次时，你使用UIGraphicsGetCurrentImageContext()获取了context。这里的关键词是‘get’。‘Get’意味着你获取了当前context的引用，你并不持有它。在第二次中，你调用了CGBitmapContextCreateImage()，Create意味着你持有这个对象，并需要管理它的生命周期。这也是你为什么需要释放imageRef的原因，因为你是通过CGBitmapContextCreateImage()创建它的。你处理的内容越复杂，你使用Core Graphics则能节省更多的时间。
    return finalImage;
}

-(UIImage *)ghostAddByPixels
{
    //使用像素
    NSUInteger bytesPerPixel = 4;//每像素大小
    NSUInteger bitsPerComponent = 8;//每个颜色通道大小
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger topOriginX = 500;
    NSUInteger topOriginY = 700;
    
    CGImageRef bottomImageRef = [[UIImage imageNamed:@"Wallpaper.png"]CGImage];
    NSUInteger bottomWidth = CGImageGetWidth(bottomImageRef);
    NSUInteger bottomHeight = CGImageGetHeight(bottomImageRef);
    UInt32 *bottomPixels = calloc(bottomWidth * bottomHeight, sizeof(UInt32));
    CGContextRef bottomContext = CGBitmapContextCreate(bottomPixels, bottomWidth, bottomHeight, bitsPerComponent, bytesPerPixel*bottomWidth, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGContextDrawImage(bottomContext, CGRectMake(0, 0, bottomWidth, bottomHeight), bottomImageRef);
    
    CGImageRef topImageRef = [[UIImage imageNamed:@"ghost.png"]CGImage];
    NSUInteger topWidth = CGImageGetWidth(topImageRef);
    NSUInteger topHeight = CGImageGetHeight(topImageRef);
    UInt32 *topPixels = calloc(topWidth * topHeight, sizeof(UInt32));;
    CGContextRef topContext = CGBitmapContextCreate(topPixels, topWidth, topHeight, bitsPerComponent, bytesPerPixel*topWidth, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGContextDrawImage(topContext, CGRectMake(0, 0, topWidth, topHeight), topImageRef);
    
    // 2.3 Blend each pixel
    for (NSUInteger j = 0; j < topHeight; j++) {
        for (NSUInteger i = 0; i < topWidth; i++) {
            UInt32 *bottomPixel = bottomPixels + (j+topOriginY)*bottomWidth + topOriginX + i;
            UInt32 bottomColor = *bottomPixel;
            
            UInt32 *topPixel = topPixels + i +j*topWidth;
            UInt32 topColor = *topPixel;
            
            // Blend the ghost with 50% alpha
            CGFloat topAlpha = 0.5f * (A(topColor) / 255.0);
            UInt32 newR = R(bottomColor) * (1 - topAlpha) + R(topColor) * topAlpha;
            UInt32 newG = G(bottomColor) * (1 - topAlpha) + G(topColor) * topAlpha;
            UInt32 newB = B(bottomColor) * (1 - topAlpha) + B(topColor) * topAlpha;
            
            //Clamp, not really useful here :p
            newR = MAX(0,MIN(255, newR));
            newG = MAX(0,MIN(255, newG));
            newB = MAX(0,MIN(255, newB));
            
            *bottomPixel = RGBAMake(newR, newG, newB, A(bottomColor));
        }
    }
    
    
    // 3. Convert the image to Black & White
    for (NSUInteger j = 0; j < bottomHeight; j++) {
        for (NSUInteger i = 0; i < bottomWidth; i++) {
            UInt32 * currentPixel = bottomPixels + (j * bottomWidth) + i;
            UInt32 color = *currentPixel;
            
            // Average of RGB = greyscale
            UInt32 averageColor = (R(color) + G(color) + B(color)) / 3.0;
            
            *currentPixel = RGBAMake(averageColor, averageColor, averageColor, A(color));
        }
    }
    
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(bottomContext);
    UIImage *resultImage = [UIImage imageWithCGImage:newCGImage];
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(bottomContext);
    CGContextRelease(topContext);
    free(bottomPixels);
    free(topPixels);
    return resultImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//NewColor = TopColor * TopColor.Alpha + BottomColor * (1 - TopColor.Alpha)
@end
