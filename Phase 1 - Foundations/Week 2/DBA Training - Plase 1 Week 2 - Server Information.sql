/*
Week 2: Installation verification
Goal: Confirm edition, connectivity, and basic instance info.
*/

SELECT 
    @@SERVERNAME AS ServerName,
    @@VERSION AS SqlServerVersion;

SELECT 
    name,
    database_id,
    create_date,
    state_desc,
    recovery_model_desc
FROM sys.databases
ORDER BY name;

-- List tables in the current database (whatever DB you're in)
SELECT 
    s.name AS SchemaName,
    t.name AS TableName,
    t.create_date
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id = t.schema_id
ORDER BY s.name, t.name;

-- List columns for all user tables in the current DB
SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    c.column_id,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length,
    c.is_nullable
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id = t.schema_id
JOIN sys.columns c ON c.object_id = t.object_id
JOIN sys.types ty ON ty.user_type_id = c.user_type_id
ORDER BY s.name, t.name, c.column_id;

-- Server Information
SELECT 
    SERVERPROPERTY('ServerName') AS ServerName,
    SERVERPROPERTY('InstanceName') AS InstanceName,
    SERVERPROPERTY('Edition') AS Edition,
    SERVERPROPERTY('ProductVersion') AS ProductVersion,
    SERVERPROPERTY('ProductLevel') AS ProductLevel;

SELECT 
    SYSTEM_USER AS [SYSTEM_USER],
    SUSER_SNAME() AS [SUSER_SNAME],
    ORIGINAL_LOGIN() AS [ORIGINAL_LOGIN];

SELECT DB_NAME() AS CurrentDatabase;

-- Agent / services visibility (permissions may vary)
SELECT 
    servicename,
    startup_type_desc,
    status_desc,
    last_startup_time
FROM sys.dm_server_services
ORDER BY servicename;

SELECT 
    SERVERPROPERTY('InstanceDefaultDataPath') AS DefaultDataPath,
    SERVERPROPERTY('InstanceDefaultLogPath')  AS DefaultLogPath;