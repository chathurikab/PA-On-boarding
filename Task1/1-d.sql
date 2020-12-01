
/*d.	Display all the jobs available*/

SELECT j.JobDescription AS 'Job Title',js.[Status] AS 'Status of the job'
FROM dbo.job j INNER JOIN dbo.JobStatus js ON j.Id=js.Id
WHERE js.id=1 /* Open*/

