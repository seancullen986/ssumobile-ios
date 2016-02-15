//
//  SSUSelectionTableViewController.m
//  SSUMobile
//
//  Created by Eric Amorde on 7/9/15.
//  Copyright (c) 2015 Computer Science. All rights reserved.
//


//TODO: I cleaned this up a bit already, but there's more to do. I took this from a very old project.

#import "SSUSelectionController.h"

static NSString * const kCellReuseIdentifier = @"SelectionCell";
static NSString * const kSearchCellReuseIdentifier = @"SearchCell";

@interface SSUSelectionController()

@property (nonatomic, strong) UISearchDisplayController * searchController;

@end

@implementation SSUSelectionController

#pragma mark - Initialization

/*
 Other init methods call this one
 */
- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.allowUserDismissal = YES;
        self.textKey = @"description";
        self.title = @"Select an Option";
        self.navigationItem.hidesBackButton = YES;
    }
    return self;
}

- (id) initWithItems:(NSArray *)items
{
    self = [self initWithStyle:UITableViewStylePlain];
    if (self) {
        NSAssert(items.count > 0, @"SSUSelectionController must be initialized with at least 1 choice. 0 found.");
        self.choices = items;
    }
    return self;
}

#pragma mark - View Lifecyle

- (void) viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.searchBar.placeholder = @"Search";
    self.searchBar.delegate = self;
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.delegate = self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.tableView.tableHeaderView = self.searchBar;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.allowUserDismissal) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
        self.navigationItem.rightBarButtonItem = doneButton;
    }
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

#pragma mark - UITableView

- (NSObject *) objectAtIndexPath:(NSIndexPath *)indexPath {
    return [self.choices objectAtIndex:indexPath.row];
}

- (NSIndexPath *) indexOfObject:(id)object {
    return [NSIndexPath indexPathForRow:[self.choices indexOfObject:object] inSection:0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return 1;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return self.searchData.count;
    return [self.choices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self tableView:tableView searchCellForRowAtIndexPath:indexPath];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellReuseIdentifier];
    }
    
    id choice = [self objectAtIndexPath:indexPath];
    if ([choice isKindOfClass:[NSString class]]) {
        cell.textLabel.text = choice;
    }
    else {
        cell.textLabel.text = [choice valueForKeyPath:self.textKey];
    }
    
    if (self.subtitleKey) {
        cell.detailTextLabel.text = [choice valueForKeyPath:self.subtitleKey];
    }
    
    if ([indexPath isEqual:self.selectedIndex] ||
        ([indexPath isEqual:self.defaultIndex] && !self.selectedIndex)) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView searchCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCellReuseIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSearchCellReuseIdentifier];
    }
    
    id choice = [self.searchData objectAtIndex:indexPath.row];
    cell.textLabel.text = [choice valueForKey:self.textKey];
    if (self.subtitleKey) {
        cell.detailTextLabel.text = [choice valueForKey:self.subtitleKey];
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        id selectedObj = [self.searchData objectAtIndex:indexPath.row];
        self.selectedIndex = [self indexOfObject:selectedObj];
        [self.searchDisplayController setActive:NO animated:YES];
        [self.tableView scrollToRowAtIndexPath:self.selectedIndex
                              atScrollPosition:UITableViewScrollPositionMiddle
                                      animated:NO];
        if ([self.delegate respondsToSelector:@selector(userDidSelectItem:atIndexPath:fromController:)]) {
            [self.delegate userDidSelectItem:self.selectedItem atIndexPath:self.selectedIndex fromController:self];
        }
    }
    else {
        self.selectedIndex = indexPath;
        self.defaultIndex = nil;
        self.selectedItem = [self objectAtIndexPath:indexPath];
        
        [self.tableView reloadData];
        if ([self.delegate respondsToSelector:@selector(userDidSelectItem:atIndexPath:fromController:)]) {
            [self.delegate userDidSelectItem:self.selectedItem atIndexPath:self.selectedIndex fromController:self];
        }
    }
    if (!self.allowUserDismissal) {
        [self dismiss];
    }
}

# pragma mark - Search

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:nil];
    return YES;
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K contains[c] %@",self.textKey,searchText];
    self.searchData = [self.choices filteredArrayUsingPredicate:predicate];
}

# pragma mark - Other

- (void) dismiss {
    [self dismissViewControllerAnimated:YES completion:NULL];
    if ([self.delegate respondsToSelector:@selector(selectionControllerDismissed:)])
        [self.delegate selectionControllerDismissed:self];
}

- (void) cancelButtonPressed {
    [self dismiss];
}

- (void) doneButtonPressed {
    [self dismiss];
}

- (void) setSelectedIndex:(NSIndexPath *)selectedIndex {
    _selectedIndex = selectedIndex;
    self.selectedItem = [self objectAtIndexPath:selectedIndex];
    [self.tableView reloadData];
}

@end

