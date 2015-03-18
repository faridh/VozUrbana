//
//  LocationResultsViewController.m
//  UsoDeSuelo
//
//  Created by Phoenix on 3/6/15.
//  Copyright (c) 2015 Faridh Mendoza. All rights reserved.
//

#import "LocationResultsViewController.h"

@interface LocationResultsViewController ()

@end

@implementation LocationResultsViewController

@synthesize locationResults;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)scrollToTop
{
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [locationResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    // Configure the cell...
    NSDictionary *resultContents = [locationResults objectAtIndex:indexPath.row];
    NSString *resultLabel = resultContents[@"description"];
    cell.textLabel.text = resultLabel;
    cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *location = [locationResults objectAtIndex:indexPath.row];
    [DataSource instance].selectedLocation = location;
    
    if ( delegate && [delegate conformsToProtocol:@protocol(LocationResultsViewDelegate)] ) {
        if ( [delegate respondsToSelector:@selector(locationSelected)] )
            [delegate locationSelected];
    }
}

@end
