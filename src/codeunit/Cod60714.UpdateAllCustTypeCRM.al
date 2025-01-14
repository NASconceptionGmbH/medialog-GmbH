codeunit 60714 "UpdateAllCustTypeCRM"
{
    TableNo = "Customer Type";
    trigger OnRun()

    var
        TypeofBusinessL: Record "Type of Business";
        Customer: Record Customer;
        JsonObjectL: JsonObject;
        ApiUrlL: text;
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;
        TextGuid: Text;
        ZeroGuid: Guid;
        CustomCRMSynchronizationL: Codeunit CustomCRMSynchronization;
    begin
        CRMCustomSyncSetupL.Get();
        clear(JsonObjectL);
        if Customer.Get(Rec."Customer No.") AND TypeofBusinessL.Get(Rec."Type of Business Code") then begin
            if (Customer."CRM GUID" <> ZeroGuid) and (TypeofBusinessL."CRM GUID" <> ZeroGuid) then begin
                TextGuid := format(Customer."CRM GUID").Replace('{', '').Replace('}', '');
                APIUrlL := StrSubstNo(RelationURL, CRMCustomSyncSetupL."API URL", 'accounts', TextGuid, 'cos_account_cos_typeofcustomer');
                TextGuid := format(TypeofBusinessL."CRM GUID").Replace('{', '').Replace('}', '');
                JsonObjectL.Add('@odata.id', CRMCustomSyncSetupL."API URL" + 'cos_typeofcustomers(' + TextGuid + ')');

                CustomCRMSynchronizationL.SendToCRM(JsonObjectL, APIUrlL, false);

            end;
        end;
    end;


    var
        RelationURL: Label '%1%2(%3)/%4/$ref', Locked = true;
}