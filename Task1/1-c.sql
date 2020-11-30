

/*c.	For each property in question a), return the following:                                                                      
i.	Using rental payment amount, rental payment frequency, tenant start date and tenant end date to write a query that returns the sum of all payments from start date to end date. 
ii.	Display the yield. */

SELECT tp.PropertyId,p.[Name],tpf.[Name],tp.StartDate,tp.EndDate,tp.PaymentAmount,CASE

                                                                                                              WHEN (tp.PaymentFrequencyId =1) THEN DATEDIFF(week,tp.StartDate,tp.EndDate) * tp.PaymentAmount
																											  WHEN (tp.PaymentFrequencyId =2) THEN (DATEDIFF(week,tp.StartDate,tp.EndDate)/2) * tp.PaymentAmount
																											  ELSE  (DATEDIFF(month,tp.StartDate,tp.EndDate) +1) * tp.PaymentAmount
																											  END AS 'Total Payment'

FROM dbo.tenantproperty tp INNER JOIN dbo.property p ON tp.PropertyId =p.Id
INNER JOIN dbo.TenantPaymentFrequencies tpf ON tpf.Id =tp.PaymentFrequencyId
--WHERE tp.PropertyId  IN (5597,5637,5638)
INNER JOIN dbo.OwnerProperty op ON op.PropertyId=p.Id
WHERE  op.OwnerId = 1426


