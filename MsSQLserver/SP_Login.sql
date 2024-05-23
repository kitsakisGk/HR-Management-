USE [HR_Shifts]
GO
/****** Object:  StoredProcedure [dbo].[SP_Login]    Script Date: 23/5/2024 2:11:54 μμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[SP_Login]
@Username as varchar(50),
@Password as varchar(50),
@UserID as int output, 
@Fullname as varchar(50) output,
@Department as varchar(50) output
as

select @UserID = isNull(S_ID, 0), @Fullname = isNull([Fullname], ''), @Department = isNull([Section], '') from S_users 
where Username = @Username and Password = @Password 


