//
//  DWJQBaseDBData.h
//  DWJQ
//
//  Created by luoxingyu on 16/7/12.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQBaseData.h"
@class DWJQSqliteHelper;
@interface DWJQBaseDBData : DWJQBaseData
{
    NSUInteger primaryKey;
    BOOL savedInDatabase;
}
@property (nonatomic) NSUInteger primaryKey;
@property (nonatomic) BOOL savedInDatabase;



+(void)setDatabase:(DWJQSqliteHelper *)newDatabase;
+(DWJQSqliteHelper *)database;
-(void)resetAll;
-(DWJQBaseDBData*)table:(NSString *)table;
-(DWJQBaseDBData*)field:(id)field;
-(DWJQBaseDBData*)limit:(NSUInteger)start size:(NSUInteger)size;
-(DWJQBaseDBData*)order:(NSString *)order;
-(DWJQBaseDBData*)group:(NSString *)group;
-(DWJQBaseDBData*)whereRaw:(NSString *)str value:(NSDictionary *)map;
-(DWJQBaseDBData*)where:(NSDictionary *)map;
-(NSArray *)select;
-(NSUInteger)getCount;

-(void)update:(NSDictionary *)data;
-(void)beforeUpdate:(NSDictionary *)data;
-(void)afterUpdate:(NSDictionary *)data;

-(void)save;
-(void)beforeSave;
-(void)afterSave;

-(void)deleteSelf;
-(void)beforeDeleteSelf;
-(void)afterDeleteSelf;

-(void)delete;
-(void)beforeDelete;
-(void)afterDelete;


+(void)afterFind:(NSArray **)results;
+(void)beforeFindSql:(NSString **)sql parameters:(NSArray **)parameters;
+(NSArray *)findWithSql:(NSString *)sql withParameters:(NSArray *)parameters;
+(NSArray *)findWithSqlWithParameters:(NSString *)sql, ...;
+(NSArray *)findWithSql:(NSString *)sql;
+(NSArray *)findByColumn:(NSString *)column value:(id)value;
+(NSArray *)findByColumn:(NSString *)column unsignedIntegerValue:(NSUInteger)value;
+(NSArray *)findByColumn:(NSString *)column integerValue:(NSInteger)value;
+(NSArray *)findByColumn:(NSString *)column doubleValue:(double)value;
+(id)find:(NSUInteger)primaryKey;
+(NSArray *)findAll;
+(void)deleteAll;
-(BOOL)isTableExist;
-(void)createTable;

@end
