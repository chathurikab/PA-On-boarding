
-- Without CTE (using TenantProperty.PaymentAmount )
SELECT tp.PropertyId,p.[Name],tpf.[Name],person.FirstName+' '+ person.LastName AS [Name], tp.StartDate,tp.EndDate,tp.PaymentAmount,
	CASE
	    WHEN (tp.PaymentFrequencyId = 1 /*Weekly*/) THEN  'per week'
	    WHEN (tp.PaymentFrequencyId = 2 /*Fortnightly*/) THEN 'per fortnight'
			ELSE  'per month'
		END AS 'PaymentDuration',
	pe.Amount AS [ExpenseAmount],
	pe.Description [Expense],
	pe.Date [ExpenseDate],a.Number+' '+a.Street+' '+a.Suburb+' '+a.City+' '+a.Region+' '+a.PostCode AS [Address],P.Bathroom,P.Bedroom

FROM dbo.TenantProperty tp INNER JOIN dbo.property p ON (tp.PropertyId =p.Id)
INNER JOIN dbo.TenantPaymentFrequencies tpf ON (tpf.Id =tp.PaymentFrequencyId)
INNER JOIN dbo.OwnerProperty op ON op.PropertyId=p.Id
INNER JOIN dbo.Person person ON person.Id = op.OwnerId
INNER JOIN dbo.PropertyExpense pe ON pe.PropertyId=p.Id
INNER JOIN dbo.Address a ON a.AddressId=p.AddressId
WHERE   p.IsActive =1
ORDER BY 1










SELECT        OwnerProperty.OwnerId,Person.FirstName+' '+Person.LastName as[Name] ,property.id AS [PropertyID],Property.Bedroom, Property.Bathroom, TenantProperty.PaymentAmount, PropertyExpense.Description AS PropertyExpenseDescription, PropertyExpense.Amount AS PropertyExpenseAmount, 
                         PropertyExpense.Date, Property.Description AS PropertyDescription, Person.FirstName + ' ' + Person.LastName AS OwnerName, OwnerProperty.PropertyId, 
                         Address.Number + ' ' + Address.Street + ' ' + Address.Suburb + ' ' + Address.City + ' ' + Address.Region + ' ' + Address.PostCode AS Address,TenantPaymentFrequencies.[Name],property.IsActive
FROM            OwnerProperty 
                        INNER JOIN Property ON OwnerProperty.PropertyId = Property.Id 
						 INNER JOIN PropertyExpense ON Property.Id = PropertyExpense.PropertyId 
						 --INNER JOIN PropertyRentalPayment ON Property.Id = PropertyRentalPayment.PropertyId 
						INNER JOIN Person ON OwnerProperty.OwnerId = Person.Id 
						INNER JOIN Address ON Property.AddressId = Address.AddressId
						INNER JOIN TenantProperty ON Property.Id = TenantProperty.PropertyId
						INNER JOIN TenantPaymentFrequencies ON TenantProperty.PaymentFrequencyId = TenantPaymentFrequencies.Id
WHERE        Property.Id =5643 and Property.IsActive =1


SELECT        OwnerProperty.OwnerId, Person.FirstName + ' ' + Person.LastName AS Name, Property.Id AS PropertyID, Property.Bedroom, Property.Bathroom, TenantProperty.PaymentAmount, 
                         PropertyExpense.Description AS PropertyExpenseDescription, PropertyExpense.Amount AS PropertyExpenseAmount, PropertyExpense.Date, Property.Name AS PropertyName, 
                         Person.FirstName + ' ' + Person.LastName AS OwnerName, 
                         Address.Number + ' ' + Address.Street + ' ' + Address.Suburb + ' ' + Address.City + ' ' + Address.Region + ' ' + Address.PostCode AS Address, TenantPaymentFrequencies.Name AS [PaymentFrequecy]
FROM            OwnerProperty INNER JOIN
                         Property ON OwnerProperty.PropertyId = Property.Id INNER JOIN
                         PropertyExpense ON Property.Id = PropertyExpense.PropertyId INNER JOIN
                         Person ON OwnerProperty.OwnerId = Person.Id INNER JOIN
                         Address ON Property.AddressId = Address.AddressId INNER JOIN
                         TenantProperty ON Property.Id = TenantProperty.PropertyId INNER JOIN
                         TenantPaymentFrequencies ON TenantProperty.PaymentFrequencyId = TenantPaymentFrequencies.Id
WHERE        (Property.Id =4643)