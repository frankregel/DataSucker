//
//  DataSourceModel.m
//  DataSucker
//
//  Created by Frank Regel on 24.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import "DataSourceModel.h"

@interface DataSourceModel()
@property NSArray *postArray;


@end

@implementation DataSourceModel

-(NSArray*)loadDataFromWanWith:(NSString*)quellURL and:(NSString*)keyForObject
{
        //URL benennen
        NSURL *tmpUrl = [NSURL URLWithString:quellURL];
        //NSData die Daten der Quelle übergeben
        NSData *quellData = [NSData dataWithContentsOfURL:tmpUrl];
        //NSData in ein Dictionary umwandeln
        NSDictionary *dictionaryJSON = [NSJSONSerialization JSONObjectWithData:quellData
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:nil];
        //ERgebnisse ins Array schreiben
        _postArray = [dictionaryJSON objectForKey:keyForObject];
    
    
        return _postArray;
}

@end
