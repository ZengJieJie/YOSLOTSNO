
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface PlatformIosApi : NSObject

+ (UIImage*)imageByScalingAndCroppingForSize:(UIImage*)sourceImage size:(CGSize)targetSize;

@end



