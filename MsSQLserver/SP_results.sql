USE [HR_Shifts]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Results]    Script Date: 23/5/2024 1:43:28 μμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[Sp_Results]
	
AS 
BEGIN 

DECLARE @Email AS VARCHAR(100)
DECLARE @Displayname AS VARCHAR(100)
DECLARE @Section AS VARCHAR(100)
Declare @Counter as int
DECLARE @body AS VARCHAR(1000)
DECLARE @ReceiveMail AS VARCHAR(4000)
DECLARE @ReceiveMailCC AS VARCHAR(200)


Declare Name_1 cursor Forward_only   for  	
		SELECT  S_ID 
		FROM S_users AS u WHERE NOT EXISTS ( SELECT * FROM Shifts_Trans AS st WHERE u.S_ID = st.UserID AND SH_Date > GETDATE() + 3)		
						  AND  Notification_Time <=   left(convert(varchar,  getdate(), 108), 5)

Open Name_1
Fetch Next From Name_1 into @Counter
		
While @@FETCH_STATUS = 0 
		begin
		SELECT @Email = Email, @Displayname = Fullname, @Section = Section
			FROM S_users AS u WHERE  S_ID = @Counter

			
			SET @ReceiveMail = @Email
			SET @body = 'Αγαπητέ(η) ' + @Displayname + ', ' + CHAR(13) + CHAR(10) +
				'Δεν έχετε αποστείλει τις βάρδιες των εργαζομένων του τμήματος ' + @Section + '.'+ CHAR(13) + CHAR(10) +
				'Παρακαλώ πολύ να τις αποστείλετε άμεσα.' + CHAR(13) + CHAR(10) + 
				'Ευχαριστούμε πολύ.'

			SET @ReceiveMailCC = 'random@delta.gr'

			EXEC msdb..sp_send_dbmail @profile_name = 'HR Management',
				@recipients = @ReceiveMail,
				@copy_recipients = @ReceiveMailCC,
				@subject = 'Αποστολή βαρδιών',
				@body = @body

Fetch Next From Name_1 into @Counter
end
Close Name_1
Deallocate  Name_1

END