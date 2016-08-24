//
//  ViewController.m
//  ArtPrePublishImage
//
//  Created by LeeWong on 16/7/11.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "ArtPrePostImage.h"

@interface ViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) ArtPrePostImage *image;
@end

@implementation ViewController

- (IBAction)choseclick:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}

- (void)configUI
{
    self.image = [[ArtPrePostImage alloc] init];
    [self.view addSubview:self.image];
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.equalTo(@100);
    }];
    
    self.image.removeImageBlock = ^(UIImage *image){
        
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.image addImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
