

/*c.	For each property in question a), return the following:                                                                      
i.	Using rental payment amount, rental payment frequency, tenant start date and tenant end date to write a query that returns the sum of all payments from start date to end date. 
ii.	Display the yield. */

-- i >

-- With CTE using sum of PropertyRentalPayment.Amount
WITH ActualPayment(PropertyId, TenantId, FrequencyCode,[StartDate],[EndDate], [Sum of all payments])
AS
(
	select tp.PropertyId, tp.TenantId, pf.Code as FrequencyCode, tp.[StartDate],tp.[EndDate], sum(rp.Amount) [Sum of all payments]
	FROM [dbo].[TenantProperty] tp 
	INNER JOIN dbo.[TenantPaymentFrequencies] pf on pf.Id = tp.PaymentFrequencyId  
	INNER JOIN dbo.[PropertyRentalPayment] rp on  rp.PropertyId = tp.PropertyId 
	GROUP BY tp.PropertyId, tp.TenantId, pf.Code, tp.[StartDate],tp.[EndDate]
), 
ExpectedPayment(PropertyId, TenantId, [StartDate],[EndDate], [Expected Payments])
AS 
(
   SELECT tp.PropertyId, tp.TenantId, tp.StartDate,tp.EndDate, 
	CASE
	    WHEN (tp.PaymentFrequencyId = 1 /*Weekly*/) THEN DATEDIFF(WEEK,tp.StartDate,tp.EndDate) * tp.PaymentAmount
	    WHEN (tp.PaymentFrequencyId = 2 /*Fortnightly*/) THEN (DATEDIFF(WEEK,tp.StartDate,tp.EndDate)/2) * tp.PaymentAmount
			ELSE  (DATEDIFF(MONTH,tp.StartDate,tp.EndDate) +1) * tp.PaymentAmount
		END AS [Expected Payment]
	FROM dbo.TenantProperty tp INNER JOIN dbo.property p ON (tp.PropertyId =p.Id)
	INNER JOIN dbo.TenantPaymentFrequencies tpf ON (tpf.Id =tp.PaymentFrequencyId)
	INNER JOIN dbo.OwnerProperty op ON op.PropertyId=p.Id
)
SELECT p.Id AS 'Property ID', p.[Name] AS 'Property Name', tp.StartDate, tp.EndDate, ap.[Sum of all payments], ep.[Expected Payments]
FROM dbo.OwnerProperty op INNER JOIN dbo.Property p ON op.propertyid =p.id
INNER JOIN [dbo].[TenantProperty] tp ON tp.PropertyId = p.Id
INNER JOIN ActualPayment ap ON (ap.TenantId = tp.TenantId AND ap.PropertyId = tp.PropertyId)
INNER JOIN ExpectedPayment ep ON (ep.TenantId = tp.TenantId AND ep.PropertyId = tp.PropertyId)
WHERE op.OwnerId=1426 AND op.OwnershipStatusId =1 /*Owner*/
AND p.IsActive =1
ORDER BY  p.Id, p.[Name], tp.[TenantId]

GO

-- Without CTE (using TenantProperty.PaymentAmount )
SELECT tp.PropertyId,p.[Name],tpf.[Name],tp.StartDate,tp.EndDate,tp.PaymentAmount,
	CASE
	    WHEN (tp.PaymentFrequencyId = 1 /*Weekly*/) THEN DATEDIFF(WEEK,tp.StartDate,tp.EndDate) * tp.PaymentAmount
	    WHEN (tp.PaymentFrequencyId = 2 /*Fortnightly*/) THEN (DATEDIFF(WEEK,tp.StartDate,tp.EndDate)/2) * tp.PaymentAmount
			ELSE  (DATEDIFF(MONTH,tp.StartDate,tp.EndDate) +1) * tp.PaymentAmount
		END AS 'Expected Payment'

FROM dbo.TenantProperty tp INNER JOIN dbo.property p ON (tp.PropertyId =p.Id)
INNER JOIN dbo.TenantPaymentFrequencies tpf ON (tpf.Id =tp.PaymentFrequencyId)
INNER JOIN dbo.OwnerProperty op ON op.PropertyId=p.Id
WHERE  op.OwnerId = 1426 and op.OwnershipStatusId =1 /*Owner*/ AND p.IsActive =1


GO
-- With CTE Above (using TenantProperty.PaymentAmount )
WITH ActualPayment(PropertyId, TenantId, [StartDate],[EndDate], [PaymentFrequencyId], [PaymentAmount], [Expected Payment])
AS
(
	SELECT tp.PropertyId,tp.TenantId,tp.StartDate,tp.EndDate, tp.PaymentFrequencyId, tp.PaymentAmount,
	CASE
	    WHEN (tp.PaymentFrequencyId = 1 /*Weekly*/) THEN DATEDIFF(WEEK,tp.StartDate,tp.EndDate) * tp.PaymentAmount
	    WHEN (tp.PaymentFrequencyId = 2 /*Fortnightly*/) THEN (DATEDIFF(WEEK,tp.StartDate,tp.EndDate)/2) * tp.PaymentAmount
			ELSE  (DATEDIFF(MONTH,tp.StartDate,tp.EndDate) +1) * tp.PaymentAmount
		END AS 'Expected Payment'

	FROM dbo.TenantProperty tp
)
SELECT tp.PropertyId,p.[Name],tpf.[Name],tp.StartDate,tp.EndDate,  tp.[PaymentAmount], tp.[Expected Payment]
FROM ActualPayment tp INNER JOIN dbo.property p ON (tp.PropertyId =p.Id)
INNER JOIN dbo.TenantPaymentFrequencies tpf ON (tpf.Id =tp.PaymentFrequencyId)
INNER JOIN dbo.OwnerProperty op ON op.PropertyId=p.Id
WHERE op.OwnerId = 1426 and op.OwnershipStatusId =1 /*Owner*/ AND p.IsActive =1

--====================================================================================================================================


----ii If yield is expected from PropertyFinance- yield field. This is the query for it.

SELECT tp.PropertyId,p.[Name],tpf.[Name],tp.StartDate,tp.EndDate,tp.PaymentAmount,
	CASE
	    WHEN (tp.PaymentFrequencyId = 1 /*Weekly*/) THEN DATEDIFF(WEEK,tp.StartDate,tp.EndDate) * tp.PaymentAmount
	    WHEN (tp.PaymentFrequencyId = 2 /*Fortnightly*/) THEN (DATEDIFF(WEEK,tp.StartDate,tp.EndDate)/2) * tp.PaymentAmount
			ELSE  (DATEDIFF(MONTH,tp.StartDate,tp.EndDate) +1) * tp.PaymentAmount
		END AS 'Expected Payment' ,pf.Yield

FROM dbo.TenantProperty tp INNER JOIN dbo.property p ON (tp.PropertyId =p.Id)
INNER JOIN dbo.TenantPaymentFrequencies tpf ON (tpf.Id =tp.PaymentFrequencyId)
INNER JOIN dbo.OwnerProperty op ON op.PropertyId=p.Id
INNER JOIN dbo.PropertyFinance pf ON pf.propertyid=p.Id
WHERE  op.OwnerId = 1426 and op.OwnershipStatusId =1 /*Owner*/ AND p.IsActive =1


GO