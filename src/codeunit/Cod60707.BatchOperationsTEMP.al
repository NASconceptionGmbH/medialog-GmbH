codeunit 60707 "BatchOperationsTEMP"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    begin
        case Rec."Parameter String" of
            'UNCOUPLEOLD':
                DeleteOldCouplings();
            'COUPLE':
                CoupleCharacteristics();
            'UPDATEATTRIBUTES':
                UpdateAttributes();
            'FIXCOUPLINGS':
                FixCouplings();
            'GENERATEISSUES':
                GenerateIssueLists();
            'UPDATEITEMDESCRIPTIONS':
                UpdateItemDescriptions();
        end;
    end;

    procedure FixCouplings()
    begin
        CoupleCharacteristics();
        Commit();
        DeleteOldCouplings();
        Commit();
        UpdateCRMIDs();
    end;

    procedure UnCoupleAll()
    var
        ItemAttributeValue: Record "Item Attribute Value";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        if EnvironmentInformationL.IsProduction() then
            ItemAttributeValue.SetRange("Attribute ID", 21) //live 
        else
            ItemAttributeValue.SetRange("Attribute ID", 22); //sandbox
        if ItemAttributeValue.FindSet() then
            repeat
                CRMCouplingManagement.RemoveCoupling(ItemAttributeValue.RecordId);
            until ItemAttributeValue.Next() = 0;
    end;

    procedure CoupleCharacteristics()
    var
        CRMIntegrationRecordL: Record "CRM Integration Record";
        CDScos_characteristic: Record "CDS cos_characteristic";
        ItemAttributeValue: Record "Item Attribute Value";
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
        if EnvironmentInformationL.IsProduction() then
            ItemAttributeValue.SetRange("Attribute ID", 21) //live 
        else
            ItemAttributeValue.SetRange("Attribute ID", 22); //sandbox
        if ItemAttributeValue.FindSet() then
            repeat
                CDScos_characteristic.SetRange(cos_name, ItemAttributeValue."Value");
                if CDScos_characteristic.FindFirst() then begin
                    CRMIntegrationRecordL.SetRange("Table ID", 7501);
                    CRMIntegrationRecordL.SetRange("Integration ID", ItemAttributeValue.SystemId);
                    if CRMIntegrationRecordL.FindFirst() then
                        CRMIntegrationRecordL.Rename(CDScos_characteristic.cos_characteristicId, ItemAttributeValue.SystemId)
                end
            until ItemAttributeValue.Next() = 0;
    end;

    procedure DeleteOldCouplings()
    var
        ItemAttributeValue: Record "Item Attribute value";
        ItemAttributeValue2: Record "Item Attribute value";
        CRMIntegrationRecordL: Record "CRM Integration Record";
        CRMIntegrationRecord2L: Record "CRM Integration Record";
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
        if EnvironmentInformationL.IsProduction() then
            ItemAttributeValue.SetRange("Attribute ID", 21) //live 
        else
            ItemAttributeValue.SetRange("Attribute ID", 22); //sandbox
        if ItemAttributeValue.FindSet() then
            repeat
                CRMIntegrationRecordL.SetRange("Table ID", 7501);
                CRMIntegrationRecordL.SetRange("Integration ID", ItemAttributeValue.SystemId);
                if CRMIntegrationRecordL.FindFirst() then begin
                    CRMIntegrationRecord2L.SetRange("Table ID", 7501);
                    CRMIntegrationRecord2L.SetRange("CRM ID", CRMIntegrationRecordL."CRM ID");
                    if CRMIntegrationRecord2L.FindSet() then
                        repeat
                            if EnvironmentInformationL.IsProduction() then
                                ItemAttributeValue.SetRange("Attribute ID", 21) //live 
                            else
                                ItemAttributeValue.SetRange("Attribute ID", 22); //sandbox
                            ItemAttributeValue2.SetRange(SystemId, CRMIntegrationRecord2L."Integration ID");
                            if ItemAttributeValue2.FindFirst() then begin

                            end else begin
                                CRMIntegrationRecord2L.Delete();
                            end;
                        until CRMIntegrationRecord2L.Next() = 0;
                end
            until ItemAttributeValue.Next() = 0;
    end;

    procedure UpdateCRMIDs()
    var
        EnvironmentInformationL: Codeunit "Environment Information";
        ItemAttributeValue: Record "Item Attribute Value";
        CRMIntegrationRecord: Record "CRM Integration Record";
    begin
        if EnvironmentInformationL.IsProduction() then
            ItemAttributeValue.SetRange("Attribute ID", 21) //live 
        else
            ItemAttributeValue.SetRange("Attribute ID", 22); //sandbox
        if ItemAttributeValue.FindSet() then
            repeat
                Clear(CRMIntegrationRecord);
                CRMIntegrationRecord.SetRange("Table ID", 7501);
                CRMIntegrationRecord.SetRange("Integration ID", ItemAttributeValue.SystemId);
                if CRMIntegrationRecord.FindFirst() then begin
                    ItemAttributeValue."CRM GUID" := CRMIntegrationRecord."CRM ID";
                    ItemAttributeValue.Modify();
                end;

            until ItemAttributeValue.Next() = 0;
    end;

    procedure UpdateAttributes()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ContactL: record Contact;
        UpdateContactL: Boolean;
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then
            repeat
                UpdateContactL := false;
                if SalesHeader."Sell-to Contact No." <> '' then begin
                    if ContactL.Get(SalesHeader."Sell-to Contact No.") then begin
                        UpdateContactL := true;
                    end;
                end;
                SalesLine.setrange("Document Type", SalesLine."Document Type"::Order);
                salesline.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                if SalesLine.FindSet() then begin
                    InsertSparte(SalesLine);
                    InsertCharacteristics(SalesLine);
                    if UpdateContactL then
                        InsertCharacteristicsContact(SalesLine, ContactL);
                end;
            until SalesHeader.Next() = 0;

    end;


    local procedure InsertSparte(SalesLineV: Record "Sales Line")
    var
        CustomerSpartentoCRML: Record "Customer Sparten CRM";
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
    begin
        // ItemL.Get("No.");
        if ItemAttributeValueMappingL.Get(27, SalesLineV."No.", 19) then begin
            CustomerSpartentoCRML.Init();
            CustomerSpartentoCRML."Customer No." := SalesLineV."Sell-to Customer No.";
            CustomerSpartentoCRML.validate("Item Attribute Value ID", ItemAttributeValueMappingL."Item Attribute Value ID");
            if NOT CustomerSpartentoCRML.Insert() then;
        end;
    end;

    local procedure InsertCharacteristics(SalesLineV: Record "Sales Line")
    var
        CustomerCharacteristicsCRML: Record "Customer Characteristics CRM";
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
        ItemAttributeValueL: Record "Item Attribute Value";
        ItemAttributeValue2L: Record "Item Attribute Value";
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        // ItemL.Get("No.");
        //21|26|27|28
        ItemAttributeValueMappingL.SetRange("Table ID", 27);
        ItemAttributeValueMappingL.SetRange("No.", SalesLineV."No.");
        if EnvironmentInformationL.IsProduction() then
            ItemAttributeValueMappingL.SetFilter("Item Attribute ID", '21|26|27|28') //prod
        else //prod
            ItemAttributeValueMappingL.SetFilter("Item Attribute ID", '22|23|24'); //sandbox

        if ItemAttributeValueMappingL.FindSet() then
            repeat
                if ItemAttributeValueL.get(ItemAttributeValueMappingL."Item Attribute ID", ItemAttributeValueMappingL."Item Attribute Value ID") then
                    if ItemAttributeValueL.Value <> '' then begin
                        ItemAttributeValue2L.Reset();
                        if EnvironmentInformationL.IsProduction() then
                            ItemAttributeValue2L.SetRange("Attribute ID", 21) //prod
                        else
                            ItemAttributeValue2L.SetRange("Attribute ID", 22); //sandbox
                        ItemAttributeValue2L.SetRange(Value, ItemAttributeValueL.Value);
                        if ItemAttributeValue2L.FindFirst() then begin
                            CustomerCharacteristicsCRML.Init();
                            CustomerCharacteristicsCRML."Customer No." := SalesLineV."Sell-to Customer No.";
                            CustomerCharacteristicsCRML.validate("Item Attribute Value ID", ItemAttributeValue2L."ID");
                            if NOT CustomerCharacteristicsCRML.Insert() then;
                        end;
                    end
            until ItemAttributeValueMappingL.Next() = 0;



        // if ItemAttributeValueMappingL.Get(27, "No.", 19) then begin
        //     CustomerSpartentoCRML.Init();
        //     CustomerSpartentoCRML."Customer No." := "Sell-to Customer No.";
        //     CustomerSpartentoCRML.validate("Item Attribute Value ID", ItemAttributeValueMappingL."Item Attribute Value ID");
        //     if NOT CustomerSpartentoCRML.Insert() then;
        // end;
    end;

    local procedure InsertCharacteristicsContact(SalesLineV: Record "Sales Line"; ContactV: Record Contact)
    var
        ContactCharacteristicsCRML: Record "Contact Characteristics CRM";
        ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
        ItemAttributeValueL: Record "Item Attribute Value";
        ItemAttributeValue2L: Record "Item Attribute Value";
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        // ItemL.Get("No.");
        //21|26|27|28
        ItemAttributeValueMappingL.SetRange("Table ID", 27);
        ItemAttributeValueMappingL.SetRange("No.", SalesLineV."No.");
        if EnvironmentInformationL.IsProduction() then
            ItemAttributeValueMappingL.SetFilter("Item Attribute ID", '21|26|27|28') //prod
        else //prod
            ItemAttributeValueMappingL.SetFilter("Item Attribute ID", '22|23|24'); //sandbox

        if ItemAttributeValueMappingL.FindSet() then
            repeat
                if ItemAttributeValueL.get(ItemAttributeValueMappingL."Item Attribute ID", ItemAttributeValueMappingL."Item Attribute Value ID") then
                    if ItemAttributeValueL.Value <> '' then begin
                        ItemAttributeValue2L.Reset();
                        if EnvironmentInformationL.IsProduction() then
                            ItemAttributeValue2L.SetRange("Attribute ID", 21) //prod
                        else
                            ItemAttributeValue2L.SetRange("Attribute ID", 22); //sandbox
                        ItemAttributeValue2L.SetRange(Value, ItemAttributeValueL.Value);
                        if ItemAttributeValue2L.FindFirst() then begin
                            ContactCharacteristicsCRML.Init();
                            ContactCharacteristicsCRML."Contact No." := ContactV."No.";
                            ContactCharacteristicsCRML.validate("Item Attribute Value ID", ItemAttributeValue2L."ID");
                            if NOT ContactCharacteristicsCRML.Insert() then;
                        end;
                    end
            until ItemAttributeValueMappingL.Next() = 0;



        // if ItemAttributeValueMappingL.Get(27, "No.", 19) then begin
        //     CustomerSpartentoCRML.Init();
        //     CustomerSpartentoCRML."Customer No." := "Sell-to Customer No.";
        //     CustomerSpartentoCRML.validate("Item Attribute Value ID", ItemAttributeValueMappingL."Item Attribute Value ID");
        //     if NOT CustomerSpartentoCRML.Insert() then;
        // end;
    end;


    local procedure GenerateIssueLists()
    var
        ItemL: Record Item;
        IssueAdL: Record "Issue Ad";
        ExcelIssueFunctionsL: Codeunit ExcelIssueFunctions;
    begin
        if ItemL.FindSet() then
            repeat
                Clear(IssueAdL);
                IssueAdL.SetRange("Item No.", ItemL."No.");
                if IssueAdL.Count > 0 then
                    ExcelIssueFunctionsL.ExportExcelIssueList(ItemL."No.")
            until ItemL.next() = 0;

    end;

    local procedure UpdateItemDescriptions()
    var
        ItemL: Record Item;
        SharePointAddinCodeUnit_NASL: Codeunit SharePointAddinCodeUnit_NAS;
    begin
        ItemL.SetRange(ItemDescriptionUploaded, false);
        if ItemL.findset then
            repeat
                SharePointAddinCodeUnit_NASL.UpdateItemDescriptionInSharepoint(ItemL."No.");
            until ItemL.next() = 0;
    end;
}