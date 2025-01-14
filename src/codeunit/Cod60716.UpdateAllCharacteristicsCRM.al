codeunit 60716 "UpdateAllCharacteristicsCRM"
{
    TableNo = "Item Attribute Value Mapping";
    trigger OnRun()
    var
        JsonObjectL: JsonObject;
        ApiUrlL: text;
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;
        ItemAttributeValueL: Record "Item Attribute Value";
        ItemAttributeValue2L: Record "Item Attribute Value";
        ItemL: Record Item;
        TextGuid: Text;
        ZeroGuid: Guid;
        CustomCRMSynchronizationL: Codeunit CustomCRMSynchronization;
    begin
        CRMCustomSyncSetupL.Get();

        clear(JsonObjectL);
        if ItemL.Get(Rec."No.") and ItemAttributeValueL.get(Rec."Item Attribute ID", Rec."Item Attribute Value ID") then begin
            if ItemAttributeValueL.Value <> '' then begin
                ItemAttributeValue2L.SetRange("Attribute ID", 21);// live
                ItemAttributeValue2L.SetRange(Value, ItemAttributeValueL.Value);
                if ItemAttributeValue2L.FindFirst() then
                    if (ItemL."CRM GUID" <> ZeroGuid) and (ItemAttributeValue2L."CRM GUID" <> ZeroGuid) then begin
                        TextGuid := format(ItemL."CRM GUID").Replace('{', '').Replace('}', '');
                        APIUrlL := StrSubstNo(RelationURL, CRMCustomSyncSetupL."API URL", 'products', TextGuid, 'cos_product_cos_characteristic');
                        TextGuid := format(ItemAttributeValue2L."CRM GUID").Replace('{', '').Replace('}', '');
                        JsonObjectL.Add('@odata.id', CRMCustomSyncSetupL."API URL" + 'cos_characteristics(' + TextGuid + ')');

                        CustomCRMSynchronizationL.SendToCRM(JsonObjectL, APIUrlL, false);
                    end;
            end;
        end;
    end;


    var
        RelationURL: Label '%1%2(%3)/%4/$ref', Locked = true;
}