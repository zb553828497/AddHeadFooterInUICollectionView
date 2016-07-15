//
//  RecipeCollectionHeaderView.h
//  AddHeadFooterInUICollectionView
//
//  Created by zhangbin on 16/7/15.
//  Copyright © 2016年 zhangbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCollectionHeaderView : UICollectionReusableView
/** 头部图片*/
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
/** 头部文字*/
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
