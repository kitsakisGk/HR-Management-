USE [HR_Shifts]
GO
/****** Object:  StoredProcedure [dbo].[WritenShifts]    Script Date: 23/5/2024 2:12:11 μμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WritenShifts]
    @FromDate DATE,
    @ToDate DATE
AS
BEGIN
    SELECT
        UserID, 
        CONVERT(VARCHAR, SH_Date, 103) AS SH_Date, 
        EmployeeID, 
        EmployeeName, 
        Shift_No
    FROM 
        Shifts_Trans
    WHERE 
        SH_Date BETWEEN @FromDate AND @ToDate
    ORDER BY 
        T_ID;
END
