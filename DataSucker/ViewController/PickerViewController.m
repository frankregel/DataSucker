//
//  PickerViewController.m
//  DataSucker
//
//  Created by Frank Regel on 24.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import "PickerViewController.h"
#import "DataSourceModel.h"

@interface PickerViewController () //<DataSourceDelegate>
@property NSArray *postArray;
@property DataSourceModel *dataSource;
@property UIPickerView *picker;

@end

@implementation PickerViewController

- (id) init
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor grayColor];
        [self loadPostObjectsFromSource];
        [self loadPicker];

    }
    return self;
}

#pragma mark - pickerview laden
-(void) loadPicker
{
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, 320, 300)];
    picker.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:picker];
    [picker setDelegate:self];
}


#pragma mark - delegates implementieren
//delegates
//Anzahl der Rollen
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//Anzahl der Spalten Zellen
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _postArray.count;
}
//Höhe der Zellen
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    //die Höhe der einzelnen Zellen bestimmen.
    return 70;
}

/*-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *oneResultDict = [_postArray objectAtIndex:row];
    NSString *rowTitle = [oneResultDict objectForKey:@"title"];
    return rowTitle;
}
*/



-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    NSDictionary *oneResultDict = [_postArray objectAtIndex:row];
    
    //aus ner URL die Daten holen, die ich brauche
    NSData *tmpImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[oneResultDict objectForKey:@"thumbnail"]]];
    
    UIImage *tmpImage = [UIImage imageWithData:tmpImageData];
    
    //Image zuweisen
    UIImageView *rowImage = [[UIImageView alloc] initWithImage:tmpImage];
    rowImage.frame = CGRectMake(0, 0, 60, 60);
    //rowImage.backgroundColor = [UIColor clearColor];
    
    //Text ans Label geben
    UILabel *rowLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 200, 60)];
    rowLabel.text = [oneResultDict objectForKey:@"title"];
    //rowLabel.backgroundColor = [UIColor clearColor];
    
    //UIView erstellen und image und Label hinzufügen !!!!UIVIEW Y- Height DARF NICHT ZU HOCH SEIN!!!!
    UIView *rowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    //Inhalte adden
    [rowView insertSubview:rowImage atIndex:0];
    [rowView insertSubview:rowLabel atIndex:1];

    
    
    return rowView;
}

#pragma mark - Datenquelle
-(void) loadPostObjectsFromSource
{
    _dataSource = [DataSourceModel new];
    _postArray = [_dataSource loadDataFromWanWith:@"http://www.dealdoktor.de/api/get_top_deals/" and:@"posts"];
}

#pragma mark - System
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end