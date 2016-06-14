//
//  OCCamera.m
//  CoreDataDemo2
//
//  Created by Terry on 16/6/13.
//  Copyright © 2016年 Terry. All rights reserved.
//

#import "OCCamera.h"

@implementation OCCamera
+(NSString *)imagePicker:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info andImageView:(UIImageView *)imageView andImageName:(NSString *)imageName{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSString *fileName = [[NSMutableString alloc] init];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        NSString *imageFile = [documentsDirectory stringByAppendingFormat:@"/%@.jpg", imageName];
        NSLog(@"%@", imageFile);
        
        success = [fileManager fileExistsAtPath:imageFile];
        if(success) {
            success = [fileManager removeItemAtPath:imageFile error:&error];
        }
        BOOL test = [UIImageJPEGRepresentation(image, 1.0f) writeToFile:imageFile atomically:YES];
        fileName = imageFile;
    }
    
    
    else if([mediaType isEqualToString:@"public.movie"]){
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"%@", videoURL);
        NSLog(@"found a video");
        NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
        
        /****************************************/
        
        NSString *videoFile = [documentsDirectory stringByAppendingPathComponent:@"temp.mov"];
        NSLog(@"%@", videoFile);
        
        success = [fileManager fileExistsAtPath:videoFile];
        if(success) {
            success = [fileManager removeItemAtPath:videoFile error:&error];
        }
        [videoData writeToFile:videoFile atomically:YES];
        fileName = videoFile;
    }
    [picker dismissModalViewControllerAnimated:YES];
    return fileName;
}

+(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissModalViewControllerAnimated:YES];
    
}

+(void)addImage:(id)mySelf {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.mediaTypes = temp_MediaTypes;
        picker.delegate = mySelf;
    }
    
    [mySelf presentModalViewController:picker animated:YES];
}


@end
