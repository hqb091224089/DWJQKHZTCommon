//
//  DWJQSqliteHelper.h
//  DWJQ
//
//  Created by luoxingyu on 16/7/12.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DWJQSqliteHelper : NSObject
{    NSString *pathToDatabase;
     BOOL logging;
     sqlite3 *database;
}
@property (nonatomic, retain) NSString *pathToDatabase;
@property (nonatomic) BOOL logging;
-(id) initWithPath:(NSString *)filePath;
-(id) initWithFileName:(NSString *)fileName;
-(NSArray *)executeSql:(NSString *)sql withParameters:(NSArray *)parameters;
-(NSArray *)executeSql:(NSString *)sql withParameters:(NSArray *)parameters withClassForRow:(Class)rowClass;
-(NSArray *)executeSql:(NSString *)sql;
-(NSArray *)executeSqlWithParameters:(NSString *)sql, ...;
-(NSArray *)tableNames;
-(void)beginTransaction;
-(void)commit;
-(void)rollback;
-(NSArray *)columnsForTableName:(NSString *)tableName;
-(NSUInteger)lastInsertRowId;

//配置
+(DWJQSqliteHelper *)startWithDefaultMigrations;
-(void)runMigrations;
-(NSUInteger)databaseVersion;
-(void)setDatabaseVersion:(NSUInteger)newVersionNumber;
-(id)initWithMigrations;
-(id)initWithMigrations:(BOOL)loggingEnabled;
@end
