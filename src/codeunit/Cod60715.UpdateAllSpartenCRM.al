codeunit 60715 "UpdateAllSpartenCRM"
{
    TableNo = "Item Attribute Value Mapping";

    trigger OnRun()
    var
        JsonObjectL: JsonObject;
        ApiUrlL: text;
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;
        ItemAttributeValueL: Record "Item Attribute Value";
        ItemL: Record Item;
        TextGuid: Text;
        ZeroGuid: Guid;
        CustomCRMSynchronizationL: Codeunit CustomCRMSynchronization;
    begin
        CRMCustomSyncSetupL.Get();

        clear(JsonObjectL);
        if ItemL.Get(Rec."No.") and ItemAttributeValueL.get(Rec."Item Attribute ID", Rec."Item Attribute Value ID") then begin
            if (ItemL."CRM GUID" <> ZeroGuid) and (ItemAttributeValueL."CRM GUID" <> ZeroGuid) then begin
                TextGuid := format(ItemL."CRM GUID").Replace('{', '').Replace('}', '');
                APIUrlL := StrSubstNo(RelationURL, CRMCustomSyncSetupL."API URL", 'products', TextGuid, 'cos_product_cos_sparten');
                TextGuid := format(ItemAttributeValueL."CRM GUID").Replace('{', '').Replace('}', '');
                JsonObjectL.Add('@odata.id', CRMCustomSyncSetupL."API URL" + 'cos_spartens(' + TextGuid + ')');

                CustomCRMSynchronizationL.SendToCRM(JsonObjectL, ApiUrlL, false);

            end;
        end;
    end;




    var
        RelationURL: Label '%1%2(%3)/%4/$ref', Locked = true;
}