tableextension 60724 "CRMInvoice" extends "CRM Invoice"
{
    Description = 'Auftrag, der in Rechnung gestellt wurde.';

    fields
    {
        field(60700; new_bcrechnungslink; Text[250])
        {
            ExternalName = 'new_bcrechnungslink';
            ExternalType = 'String';
            Description = '';
            Caption = 'BC Rechnungslink';
        }
        field(60701; new_buchungsdatum; Date)
        {
            ExternalName = 'new_buchungsdatum';
            ExternalType = 'DateTime';
            Description = '';
            Caption = 'Buchungsdatum';
        }
        field(60702; new_urlsaveprocessed; Boolean)
        {
            ExternalName = 'new_urlsaveprocessed';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'URL Speicherung';
        }
    }
}