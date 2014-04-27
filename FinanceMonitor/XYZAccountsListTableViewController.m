//
//  XYZAccountsListTableViewController.m
//  FinanceMonitor
//
//  Created by NEC on 4/19/14.
//  Copyright (c) 2014 nceliano. All rights reserved.
//

#import "XYZAccountsListTableViewController.h"
#import "XYZAllAccountsInformation_Record.h"
#import "XYZAccountInfoViewController.h"
#import "XYZWebServices.h"
#import "GlobalObjects.h"

@interface XYZAccountsListTableViewController ()

@property NSMutableArray *Accounts;

@end

@implementation XYZAccountsListTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //removes extra tableView rows
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self setPageValues];
}

- (void)setPageValues
{
    self.Accounts = [[NSMutableArray alloc] init];
    
    for (NSObject *obj in [GlobalObjects allAccInfoForUser]) {
        NSMutableDictionary *dict = (NSMutableDictionary*)obj;
        
        XYZAllAccountsInformation_Record *newItem = [[XYZAllAccountsInformation_Record alloc] init];
        newItem.ID = dict[@"ID"];
        newItem.AccNickName = dict[@"AccNickName"];
        newItem.IsActive = dict[@"IsActive"];
        
        if (newItem.IsActive) {
            [self.Accounts addObject:newItem];
        }
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.Accounts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    XYZAllAccountsInformation_Record *item = [self.Accounts objectAtIndex:indexPath.row];
    
    cell.tag = [item.ID integerValue];
    cell.textLabel.text = item.AccNickName;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *cell = sender;
    
    XYZAccountInfoViewController *controller = segue.destinationViewController;
    
    controller.pageTitle = cell.textLabel.text;
    controller.accountID = cell.tag;
}


@end
