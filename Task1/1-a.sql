/*a.	Display a list of all property names and their property id’s for Owner Id: 1426. */

declare @OwnerId int = 1426

SELECT p.Id AS 'Property ID',p.[Name] AS 'Property Name'
FROM dbo.OwnerProperty op INNER JOIN dbo.Property p ON op.PropertyId =p.Id
WHERE op.OwnerId=@OwnerId AND op.OwnershipStatusId =1 /*Owner*/
AND p.IsActive =1

