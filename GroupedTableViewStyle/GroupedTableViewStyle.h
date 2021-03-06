// Collection of static utility methods that create views for headers and
// footers of a UITableView with style UITableViewStyleGrouped. The returned
// views have a style consistent with section headers and footers generated by
// tableView:titleForHeaderInSection: and tableView:titleForFooterInSection:,
// respectively.

#import <Foundation/Foundation.h>

@interface GroupedTableViewStyle : NSObject {
  // No data, static utility methods only.
}

// Applies the color and shadow used in headers and footers to any label.
+ (void) setLabelColorAndShadow:(UILabel *)label;

#pragma mark Header methods.

// Returns the height for the header view of the given section. This method
// should be delegated to by tableView:viewForHeaderInSection:.
+ (CGFloat) heightForHeaderInSection:(NSUInteger)section;

// Returns a view for the header of the given section containing the given text.
// This method should be delegated to by tableView:viewForHeaderInSection:. Note
// that the view returned only supports one line of text; ensuring this is the
// responsibility of the client.
+ (UIView *) viewForHeaderInSection:(NSUInteger)section
                           withText:(NSString *)text;

// Returns a label in the style of a section header. The returned label contains
// the given text on a single line.
+ (UILabel *) labelLikeHeaderWithText:(NSString *)text;

#pragma mark Footer methods.

// Returns the height of the footer view containing the given text, which is
// also dependent on whether the section is the last section in the table. This
// method should be delegated to by tableView:heightForFooterInSection:.
+ (CGFloat) heightForFooterWithText:(NSString *)text
                      isLastSection:(BOOL)isLastSection;

// Returns a view for the footer containing the given text. This method should
// be delegated to by tableView:viewForFooterInSection:.
+ (UIView *) viewForFooterWithText:(NSString *)text
                     isLastSection:(BOOL)isLastSection;

// Returns a label in the style of a section footer. The returned label has the
// given width but may span multiple lines. 
+ (UILabel *) labelLikeFooterWithText:(NSString *)text
                                width:(CGFloat)width;

@end
