#import "GroupedTableViewStyleViewController.h"

#import "GroupedTableViewStyle.h"

@implementation GroupedTableViewStyleViewController

@synthesize tableView;

static NSUInteger kNumSections = 4;
static NSString *kHeaderText = @"ABCDwxyz";
static NSString *kFooterText = @"iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii Four score and seven years ago something something I like chicken";

- (void) flashScrollIndicators {
  [self.tableView flashScrollIndicators];
}

- (void) viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 
 [self performSelector:@selector(flashScrollIndicators) withObject:nil afterDelay:0];
}

- (void) dealloc {
  [tableView release];
  [super dealloc];
}

#if USE_TITLES_NOT_VIEWS

static NSString *cellText = @"Using titles for headers & footers";

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return kHeaderText;
}
- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  return kFooterText;
}

#else

static NSString *cellText = @"Using views for headers & footers";

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return [GroupedTableViewStyle heightForHeaderInSection:section];
}
- (UIView *) tableView:(UITableView *)tableViewParam viewForHeaderInSection:(NSInteger)section {
  return [GroupedTableViewStyle viewForHeaderInSection:section
                                              withText:kHeaderText];
}
- (BOOL) isLastSection:(NSUInteger)section {
  return (section == (kNumSections - 1));
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return [GroupedTableViewStyle
          heightForFooterWithText:kFooterText
          isLastSection:[self isLastSection:section]];
}
- (UIView *) tableView:(UITableView *)tableViewParam viewForFooterInSection:(NSInteger)section {
  return [GroupedTableViewStyle
          viewForFooterWithText:kFooterText
          isLastSection:[self isLastSection:section]];
}

#endif

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
  return kNumSections;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableViewParam
          cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"CellIdentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc]
             initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]
            autorelease];
  }
  cell.textLabel.text = cellText;
  return cell;
}

@end
