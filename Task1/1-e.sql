/*e.	Display all property names, current tenants first and last names and rental payments per week/ fortnight/month for the properties in question a). */


DECLARE @OwnerId int = 1426

SELECT pty.[Id] , pty.[Name] PropertyName, 
p.FirstName TenantFirstName,p.LastName AS TenantLastName,
tpf.[Name] AS 'Rental Payment Frequency',prp.Amount AS 'Rental Payment',tp.EndDate
FROM dbo.tenant t INNER JOIN dbo.Person p ON t.id=p.Id
INNER JOIN dbo.TenantProperty tp  ON tp.TenantId=t.Id
INNER JOIN dbo.Property pty ON pty.Id=tp.PropertyId
INNER JOIN dbo.PropertyRentalPayment prp ON prp.PropertyId =pty.id
INNER JOIN dbo.TenantPaymentFrequencies tpf ON tpf.id=prp.FrequencyType
INNER JOIN dbo.OwnerProperty op ON op.PropertyId=pty.Id
WHERE  t.IsActive =1 and tp.IsActive = 1 AND (tp.EndDate IS NOT NULL OR tp.EndDate >= GETDATE()) AND
 op.OwnerId=@OwnerId

