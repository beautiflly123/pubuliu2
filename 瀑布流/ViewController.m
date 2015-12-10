//
//  ViewController.m
//  瀑布流
//
//  Created by baiwang on 15/12/8.
//  Copyright © 2015年 baiwang. All rights reserved.
//

#import "ViewController.h"
#import "TMQuiltView.h"
#import "TMPhotoQuiltViewCell.h"

@interface ViewController ()<TMQuiltViewDataSource,TMQuiltViewDelegate>
{

    TMQuiltView *qtmquitView;
}
@property (nonatomic, retain) NSMutableArray *image;
@end

@implementation ViewController
@synthesize  image = _image;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    qtmquitView = [[TMQuiltView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    qtmquitView.delegate = self;
    qtmquitView.dataSource = self;
    [self.view  addSubview:qtmquitView];
    [qtmquitView reloadData];
    
}

- (NSMutableArray *)image
{
    //////////////////////////////

    if (!_image) {
        NSMutableArray *imageName = [NSMutableArray array];
        for (int i = 0; i <10; i++) {
            [imageName addObject:[NSString stringWithFormat:@"%d.jpeg",i % 10 + 1]];
            
        }
        _image = [imageName retain];
    }
    return _image;
}

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView{

    return [self.image count];
}

- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
    return [UIImage imageNamed:[self.image objectAtIndex:indexPath.row]];
}


- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath{

    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"];
    if (!cell) {
        cell = [[[TMPhotoQuiltViewCell alloc]initWithReuseIdentifier:@"PhotoCell"] autorelease];
        
    }
    cell.photoView.image = [self imageAtIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

#pragma mark - TMQuiltViewDelegate

- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView{

    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
        || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
    {
        return 3;
    } else {
        return 2;
    }
}

- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath{

    return [self imageAtIndexPath:indexPath].size.height / [self quiltViewNumberOfColumns:quiltView];
}

- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index:%ld",(long)indexPath.row);
}


@end
