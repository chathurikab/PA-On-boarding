/*b.  Display the current home value for each property in question a). */


-- include [HomeValueTypeId]=1
SELECT p.[Name], p.Id, pv.[Value]
FROM dbo.OwnerProperty op INNER JOIN dbo.Property p ON op.propertyid =p.id
INNER JOIN dbo.PropertyHomeValue pv ON pv.PropertyId=p.id
INNER JOIN dbo.PropertyHomeValueType pvt ON pvt.Id=1
WHERE op.OwnerId = 1426
AND p.IsActive=1
ORDER BY p.Id

--Assumption:property is active and take the latest updatedate