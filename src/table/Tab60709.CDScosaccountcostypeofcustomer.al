table 60709 "CDS cos_account_cos_typeofcustomer"
{
    ExternalName = 'cos_account_cos_typeofcustomer';
    TableType = CDS;

    fields
    {
        field(1; cos_account_cos_typeofcustomerId; GUID)
        {
            ExternalName = 'cos_account_cos_typeofcustomerid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Read;
        }
        field(2; VersionNumber; BigInteger)
        {
            ExternalName = 'versionnumber';
            ExternalType = 'BigInt';
            ExternalAccess = Read;
        }
        field(3; accountid; GUID)
        {
            ExternalName = 'accountid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Read;
        }
        field(4; cos_typeofcustomerid; GUID)
        {
            ExternalName = 'cos_typeofcustomerid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Read;
        }
    }
    keys
    {
        key(PK; cos_account_cos_typeofcustomerId)
        {
            Clustered = true;
        }
    }
}