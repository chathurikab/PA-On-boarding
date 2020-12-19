/*e.	Display all property names, current tenants first and last names and rental payments per week/ fortnight/month for the properties in question a). */
-- PropertyRentalPayment has two payments setup one is weekly and one is monthly, resulting to show two records for BI Property 3

DECLARE @OwnerId int = 1426

SELECT pty.[Id] , pty.[Name] , p.FirstName,p.LastName,tpf.[Name] AS 'Rental Payment Frequency',prp.Amount AS 'Rental Payment'
FROM dbo.tenant t INNER JOIN dbo.Person p ON t.id=p.Id
INNER JOIN dbo.TenantProperty tp  ON tp.TenantId=t.Id
INNER JOIN dbo.Property pty ON pty.Id=tp.PropertyId
INNER JOIN dbo.PropertyRentalPayment prp ON prp.PropertyId =pty.id
INNER JOIN dbo.TenantPaymentFrequencies tpf ON tpf.id=prp.FrequencyType
INNER JOIN dbo.OwnerProperty op ON op.PropertyId=pty.Id
WHERE  op.OwnerId = @OwnerId
and t.IsActive =1

