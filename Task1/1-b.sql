/*b.  Display the current home value for each property in question a). */

DECLARE @OwnerId int = 1426

SELECT p.Id as [Property Id], p.[Name] as [Property Name],  pv.[Value] as [Property Value]
FROM dbo.OwnerProperty op INNER JOIN dbo.Property p ON op.propertyid =p.id
INNER JOIN (
	SELECT v.*
	FROM dbo.PropertyHomeValue  v
	inner join (
		SELECT PropertyId, MAX([date]) as LatestDate
		FROM PropertyHomeValue
		WHERE IsActive=1
		GROUP BY PropertyId
	) lp ON v.PropertyId = lp.PropertyId and v.date = lp.LatestDate
	WHERE v.HomeValueTypeId = 1 /*Current Home Value*/ and v.IsActive=1
) pv 
ON pv.PropertyId=p.id
INNER JOIN dbo.PropertyHomeValueType pvt ON pvt.Id = pv.HomeValueTypeId
WHERE op.OwnerId = @OwnerId AND op.OwnershipStatusId =1 /*Owner*/ AND p.IsActive=1
ORDER BY p.Id

