#import "GroupedTableViewStyle.h"

@implementation GroupedTableViewStyle

#define kScreenWidth 320
#define kLabelLeftPosition 19
#define kLabelWidth 282
#define kHeaderFontHeight 17
#define kFooterFontHeight 15

+ (void) setLabelColorAndShadow:(UILabel *)label {
  label.textColor = [UIColor
                     colorWithRed:76/255.0
                     green:86/255.0
                     blue:108/255.0
                     alpha:1];
  label.shadowColor = [UIColor whiteColor];
  label.shadowOffset = CGSizeMake(0, 1);
}

+ (CGFloat) widthForHeaderText:(NSString *)headerText {
  UIFont *font = [UIFont boldSystemFontOfSize:kHeaderFontHeight];
  CGSize headerTextSize = [headerText
                           sizeWithFont:font
                           constrainedToSize:CGSizeMake(INT_MAX, font.lineHeight)
                           lineBreakMode:UILineBreakModeClip];
  return headerTextSize.width;
}

+ (CGFloat) heightForHeaderInSection:(NSUInteger)section {
  if (section == 0) {
    // First section has extra height.
    return 46;
  }
  return 42;
}

+ (UIView *) viewForHeaderInSection:(NSUInteger)section withText:(NSString *)text {
  CGFloat headerHeight = [GroupedTableViewStyle
                          heightForHeaderInSection:section];
  UIView *header = [[[UIView alloc]
                     initWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight)]
                    autorelease];
  header.backgroundColor = [UIColor groupTableViewBackgroundColor];
  
  CGFloat topPosition;
  if (section == 0) {
    // Header for first section has extra space above the text.
    topPosition = 17;
  } else {
    topPosition = 13;
  }
  
  UILabel *label = [GroupedTableViewStyle labelLikeHeaderWithText:text];
  CGRect frame = label.frame;
  frame.origin = CGPointMake(kLabelLeftPosition, topPosition);
  if (frame.size.width > kLabelWidth) {
    // Do not exceed the maximum width.
    frame.size.width = kLabelWidth;
  }
  label.frame = frame;
  [header addSubview:label];
  return header;
}

+ (UILabel *) labelLikeHeaderWithText:(NSString *)text {
  CGFloat headerTextWidth = [GroupedTableViewStyle widthForHeaderText:text];
  UIFont *font = [UIFont boldSystemFontOfSize:kHeaderFontHeight];
  
  UILabel *label = [[[UILabel alloc]
                     initWithFrame:CGRectMake(0,
                                              0,
                                              headerTextWidth,
                                              font.lineHeight)]
                    autorelease];
  label.backgroundColor = [UIColor clearColor];
  label.text = text;
  label.font = font;
  [GroupedTableViewStyle setLabelColorAndShadow:label];
  
  return label;
}

+ (CGFloat) heightForFooterText:(NSString *)footerText
                      withWidth:(CGFloat)width {
  CGSize footerTextSize = [footerText
                           sizeWithFont:[UIFont systemFontOfSize:kFooterFontHeight]
                           constrainedToSize:CGSizeMake(width, INT_MAX)
                           lineBreakMode:UILineBreakModeWordWrap];
  return footerTextSize.height;
}

+ (CGFloat) heightForFooterWithText:(NSString *)text
                      isLastSection:(BOOL)isLastSection {
  CGFloat footerHeight = (6 + [GroupedTableViewStyle heightForFooterText:text
                                                               withWidth:kLabelWidth]);
  if (isLastSection) {
    // Footer for last section has extra space below the text.
    footerHeight += 6;
  }
  return footerHeight;
}

+ (UIView *) viewForFooterWithText:(NSString *)text
                     isLastSection:(BOOL)isLastSection {
  CGFloat footerHeight = [GroupedTableViewStyle
                          heightForFooterWithText:text
                          isLastSection:isLastSection];
  UIView *footer = [[[UIView alloc]
                     initWithFrame:CGRectMake(0, 0, kScreenWidth, footerHeight)]
                    autorelease];
  footer.backgroundColor = [UIColor groupTableViewBackgroundColor];
  
  UILabel *label = [GroupedTableViewStyle labelLikeFooterWithText:text
                                                            width:kLabelWidth];
  CGRect frame = label.frame;
  frame.origin = CGPointMake(kLabelLeftPosition, 6);
  label.frame = frame;
  [footer addSubview:label];
  return footer;
}

+ (UILabel *) labelLikeFooterWithText:(NSString *)text
                                width:(CGFloat)width {
  CGFloat footerTextHeight = [GroupedTableViewStyle heightForFooterText:text
                                                              withWidth:width];
  UIFont *font = [UIFont systemFontOfSize:kFooterFontHeight];

  UILabel *label = [[[UILabel alloc]
                     initWithFrame:CGRectMake(0,
                                              0,
                                              width,
                                              footerTextHeight)]
                    autorelease];
  label.backgroundColor = [UIColor clearColor];
  label.text = text;
  label.font = font;
  label.textAlignment = UITextAlignmentCenter;
  label.lineBreakMode = UILineBreakModeWordWrap;
  label.numberOfLines = 0;
  [GroupedTableViewStyle setLabelColorAndShadow:label];
  
  return label;
}

@end
