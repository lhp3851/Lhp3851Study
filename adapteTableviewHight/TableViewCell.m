//
//  TableViewCell.m
//  adapteTableviewHight
//
//  Created by ZizTour on 4/21/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}
//初始化控件
-(void)initLayuot{
    _name = [[UILabel alloc] initWithFrame:CGRectMake(71, 5, 250, 40)];
    [self addSubview:_name];
    _userImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 66, 66)];
    [self addSubview:_userImage];
    _introduction = [[UILabel alloc] initWithFrame:CGRectMake(5, 78, 250, 40)];
    [self addSubview:_introduction];
}

//赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    self.introduction.text = text;
    self.introduction.numberOfLines = 0;
    CGSize size = CGSizeMake(kSCREENWIDTH, 1000);
    UIFont *font=[UIFont systemFontOfSize:14];
    UIColor *color=[UIColor blueColor];
    NSDictionary *attributeDic= [NSDictionary dictionaryWithObjectsAndKeys:
                                 font, NSFontAttributeName,
                                 color, NSForegroundColorAttributeName,
                                 nil];
    //NSStringDrawingUsesLineFragmentOrigin 出现省略号
    //NSStringDrawingTruncatesLastVisibleLine  不换行  NSStringDrawingUsesFontLeading
    CGRect labelSize=[self.introduction.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributeDic context:nil];
//    CGSize labelSize = [self.introduction.text sizeWithFont:self.introduction.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.introduction.frame = CGRectMake(self.introduction.frame.origin.x, self.introduction.frame.origin.y, labelSize.size.width, labelSize.size.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.size.height+100;
    self.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}



@end
