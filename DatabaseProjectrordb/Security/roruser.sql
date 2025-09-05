CREATE LOGIN [roruser]
    WITH PASSWORD = N'roruser';

CREATE USER [roruser] FOR LOGIN [roruser];

ALTER ROLE [db_owner] ADD MEMBER [roruser];
GO

