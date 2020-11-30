
/*a.	Display a list of all property names and their property id’s for Owner Id: 1426. */

SELECT p.[Name],p.Id
FROM dbo.OwnerProperty op INNER JOIN dbo.Property p ON op.propertyid =p.id
WHERE op.OwnerId=1426

/*b.  Display the current home value for each property in question a). */


-- include [HomeValueTypeId]=1
SELECT p.[Name], p.Id, pv.[Value]
FROM dbo.OwnerProperty op INNER JOIN dbo.Property p ON op.propertyid =p.id
INNER JOIN dbo.PropertyHomeValue pv ON pv.PropertyId=p.id
INNER JOIN dbo.PropertyHomeValueType pvt ON pvt.Id=1
WHERE op.OwnerId = 1426
--AND pvt.Id = 1
ORDER BY p.Id

--Assumption:property is active and take the latest updatedate

/*c.	For each property in question a), return the following:                                                                      
i.	Using rental payment amount, rental payment frequency, tenant start date and tenant end date to write a query that returns the sum of all payments from start date to end date. 
ii.	Display the yield. */

SELECT tp.PropertyId,p.[Name],tp.PaymentFrequencyId,tpf.[Name],tp.StartDate,tp.PaymentStartDate,tp.EndDate,tp.PaymentAmount,CASE

                                                                                                              WHEN (tp.PaymentFrequencyId =1) THEN DATEDIFF(week,tp.StartDate,tp.EndDate) * tp.PaymentAmount
																											  WHEN (tp.PaymentFrequencyId =2) THEN (DATEDIFF(week,tp.StartDate,tp.EndDate)/2) * tp.PaymentAmount
																											  ELSE  (DATEDIFF(month,tp.StartDate,tp.EndDate) +1) * tp.PaymentAmount
																											  END AS 'Total Payment'

FROM dbo.tenantproperty tp INNER JOIN dbo.property p ON tp.PropertyId =p.Id
INNER JOIN dbo.TenantPaymentFrequencies tpf ON tpf.Id =tp.PaymentFrequencyId
WHERE tp.PropertyId  IN (5597,5637,5638)









/*d.	Display all the jobs available*/

SELECT *
FROM dbo.job j INNER JOIN dbo.JobStatus js ON j.Id=js.Id
WHERE js.id=1






/*e.	Display all property names, current tenants first and last names and rental payments per week/ fortnight/month for the properties in question a). */

SELECT pty.[Name] , p.FirstName,p.LastName,tpf.[Name] AS 'Rental Payment Frequency',prp.Amount AS 'Rental Payment'
FROM dbo.tenant t INNER JOIN dbo.Person p ON t.id=p.Id
INNER JOIN dbo.TenantProperty tp  ON tp.TenantId=t.Id
INNER JOIN dbo.Property pty ON pty.Id=tp.PropertyId
INNER JOIN dbo.PropertyRentalPayment prp ON prp.PropertyId =pty.id
INNER JOIN dbo.TenantPaymentFrequencies tpf ON tpf.id=prp.FrequencyType
INNER JOIN dbo.OwnerProperty op ON op.PropertyId=pty.Id
WHERE  op.OwnerId = 1426
--pty.Id IN (5597,5637,5638)
and t.IsActive =1


select p.Name as Propert_Name, per.FirstName as Tenant_First_Name, per.LastName as Tenant_Last_Name, prp.Amount as Rental_Payment,tpf.Name as Frequency

from [dbo].[OwnerProperty] as

op inner join [dbo].[Property] as p on

(op.PropertyId=p.Id) inner join [dbo].[Person] as per

on (per.Id=op.OwnerId) inner join [dbo].[PropertyRentalPayment] as prp on (prp.PropertyId=op.PropertyId) inner join

[dbo].[TenantPaymentFrequencies] as tpf on (tpf.Id=prp.FrequencyType)

where per.IsActive=1 and op.OwnerId=1426