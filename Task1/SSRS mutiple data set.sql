DECLARE @OwnerId int = 1426

SELECT pty.[Id] , pty.[Name] PropertyName, 

CASE
	    WHEN (tp.PaymentFrequencyId = 1 /*Weekly*/) THEN  'week'
	    WHEN (tp.PaymentFrequencyId = 2 /*Fortnightly*/) THEN 'fortnight'
			ELSE  'month'
		END AS 'PaymentFrequency',


prp.Amount AS 'Rental Payment',
a.Number +' '+ a.Street+' '+a.Suburb+' '+a.City+' '+a.PostCode as PropertyAddress,
tp.StartDate, tp.EndDate
FROM 
dbo.Property pty 
INNER JOIN ( Select [PropertyId],[TenantId],[StartDate],[EndDate],[PaymentFrequencyId] from dbo.TenantProperty WHERE IsActive = 1) as tp ON pty.Id=tp.PropertyId
INNER JOIN dbo.tenant t ON t.Id = tp.TenantId

INNER JOIN dbo.PropertyRentalPayment prp ON prp.PropertyId =pty.id 
INNER JOIN dbo.OwnerProperty op ON op.PropertyId=pty.Id
INNER JOIN dbo.Address a ON a.AddressId = pty.[AddressId]
WHERE   
 t.IsActive =1 

SELECt PropertyId,
pe.Amount AS [ExpenseAmount],
	pe.Description [Expense],
	pe.Date [ExpenseDate]
FROM dbo.PropertyExpense pe
where PropertyId in (5637,
5638,
5638,
13008,
13521,
13521,
4409,
4409,
4409,
4409,
4564,
4564,
4604,
4604,
4631,
4664,
13008,
13008,
13008,
12982,
10422,
10323,
10323)


Select [PropertyId],[TenantId],[StartDate],[EndDate],[PaymentFrequencyId] from dbo.TenantProperty  
WHERE( [EndDate] IS  NULL OR [EndDate]>GetDate()) AND IsActive = 1
ORDER BY PropertyId