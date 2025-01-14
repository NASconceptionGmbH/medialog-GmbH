tableextension 60725 "CRM Sales Order" extends "CRM Salesorder"
{
    // Description = 'Angebot, das angenommen wurde.';

    fields
    {

        field(60700; new_IhreReferenz; Text[35])
        {
            ExternalName = 'new_ihrereferenz';
            ExternalType = 'String';
            Description = '';
            Caption = 'Ihre Referenz';
        }
    }
}