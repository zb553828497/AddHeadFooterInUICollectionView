//
//  RecipeCollectionViewController.m
//  AddHeadFooterInUICollectionView
//
//  Created by zhangbin on 16/7/15.
//  Copyright © 2016年 zhangbin. All rights reserved.
//


#import "RecipeCollectionViewController.h"
#import "RecipeViewCell.h"
#import "RecipeCollectionHeaderView.h"

@interface RecipeCollectionViewController () {
    NSArray *recipeImages;
}

@end

@implementation RecipeCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    NSArray *mainDishImages = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", nil];
    NSLog(@"%ld",mainDishImages.count);
    NSArray *drinkDessertImages = [NSArray arrayWithObjects:@"12", @"13", @"14", @"15", @"16",@"17", nil];
    //  如何将两个数组中的不同内容存进去的？
    recipeImages = [NSArray arrayWithObjects:mainDishImages, drinkDessertImages, nil];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
}
// 2组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    NSLog(@"%ld",recipeImages.count);
    return recipeImages.count;
}
// 每组有多少个小格子，第0组的小格子为11个，第1组的小格子为5个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    // section取值为0，1。为0时取出recipeImages中的第0个数组，也就是11个小格子；为1时取出recipeImages中的第1个数组，也就是6个小格子
//    NSLog(@"%ld",[[recipeImages objectAtIndex:section] count]);
    return [[recipeImages objectAtIndex:section] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    // 由于头部的内容和尾部的内容的控件是在storyboard中创建的，所以根据下面的HeaderView和FooterView标识去storyboard中找对应包含这些标识的控件，然后赋值给控件就能显示内容了。storyboard中的控件等价于手动创建的控件，只不过storyboard中的控件只需要拖动就可以创建
    
    // 设置头部的内容
    if (kind == UICollectionElementKindSectionHeader) {
        // 必须在storyboard中对应头部控件上写上HeaderView这个标识，否则头部内容不显示，因为这段代码底层是找有HeaderView的控件
        RecipeCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        // 拼接标题字符串。section为0，1 所以section+1，取值为1，2
        NSString *title = [[NSString alloc]initWithFormat:@"Recipe Group #%ld", indexPath.section + 1];
//        NSLog(@"%@",title);
        // 将标题赋值给title属性显示到每组的头部上
        headerView.title.text = title;
        UIImage *headerImage = [UIImage imageNamed:@"HeaderImage"];
        // 为每组的头部添加背景图片
        headerView.backgroundImage.image = headerImage;
        
        reusableview = headerView;
        
        
    }
    // 设置尾部的内容
    if (kind == UICollectionElementKindSectionFooter) {
        // 必须在storyboard中对应尾部控件上写上FooterView这个标识，否则尾部内容不显示，因为这段代码底层是找有FooterView的控件
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}

// 每一个小格子长啥样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    RecipeViewCell *cell = (RecipeViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // 为每一个图片绑定一个100的tag，那么我们必须在storyboard中的UIImageView控件上写上100，否则程序运行图片不显示
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    // 取出recipeImages数组中的第section组，第row行的数据，显示到系统的image属性上
//    NSLog(@"%ld",recipeImages.count);
    recipeImageView.image = [UIImage imageNamed:[recipeImages[indexPath.section] objectAtIndex:indexPath.row]];
    // 为每一个小格子设置背景图片
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border.png"]];
    
    return cell;
}

@end
