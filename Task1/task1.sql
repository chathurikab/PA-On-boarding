
















/*select p.Name as Propert_Name, per.FirstName as Tenant_First_Name, per.LastName as Tenant_Last_Name, prp.Amount as Rental_Payment,tpf.Name as Frequency

from [dbo].[OwnerProperty] as

op inner join [dbo].[Property] as p on

(op.PropertyId=p.Id) inner join [dbo].[Person] as per

on (per.Id=op.OwnerId) inner join [dbo].[PropertyRentalPayment] as prp on (prp.PropertyId=op.PropertyId) inner join

[dbo].[TenantPaymentFrequencies] as tpf on (tpf.Id=prp.FrequencyType)

where per.IsActive=1 and op.OwnerId=1426*/