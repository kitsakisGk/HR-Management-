USE [HR_Shifts]
GO
/****** Object:  StoredProcedure [dbo].[SP_Imports]    Script Date: 23/5/2024 2:09:26 μμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_Imports] 
(
    @UserID int
)
AS

exec DLTAGSTARGIT.Delta.dbo.[SP_xlsImport_Shifts] @UserID



delete From  CUR
From Shifts_Trans as CUR
inner join  DLTAGSTARGIT.Delta.dbo.Shifts_Trans as N
on CUR.SH_Date = N.SH_Date and 
CUR.EmployeeID = N.EmployeeID
where N.SH_Date > getdate()


insert into Shifts_Trans ([UserID], [SH_Date], [EmployeeID], [EmployeeName], [Shift_No], [SystemDate])
select [UserID], [SH_Date], [EmployeeID], [EmployeeName], [Shift_No], [SystemDate]
From DLTAGSTARGIT.Delta.dbo.Shifts_Trans
where SH_Date > getdate()
Delete From Shifts_Trans where Shift_No is null and  SH_Date > getdate()
/*
Delete From Shifts_Trans
From Shifts_Trans 
where not  exists (Select * From PME.dbo.PD_Users where PD_Users.PMEU_CardNo  =Shifts_Trans.EmployeeID )
and  SH_Date > getdate()*/