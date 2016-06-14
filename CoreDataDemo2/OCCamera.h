//
//  OCCamera.h
//  CoreDataDemo2
//
//  Created by Terry on 16/6/13.
//  Copyright © 2016年 Terry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OCCamera : NSObject
+(NSString *)imagePicker: (UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info andImageView:(UIImageView *)imageView andImageName:(NSString *)imageName;

+(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;


+(void)addImage:(id)sender;
@end
