codeunit 60718 "CDS Subscriptions"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnGetCDSTableNo', '', false, false)]
    local procedure GetCDSTableNo(BCTableNo: Integer; var CDSTableNo: Integer; var handled: Boolean)
    begin
        if BCTableNo = database::Subscriptions then begin
            CDSTableNo := Database::"CDS cos_abonnement";
            handled := true;
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', true, true)]
    local procedure HandleOnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean)
    begin
        if CRMTableID = Database::"CDS cos_abonnement" then
            Handled := LookupCDScosAbonnement(SavedCRMId, CRMId, IntTableFilter);
    end;

    local procedure LookupCDScosAbonnement(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CDScosabonnement: Record "CDS cos_abonnement";
        OriginalCDScosabonnement: Record "CDS cos_abonnement";
        OriginalCDScosabonnementList: Page "CDS Abonnement List";
    begin
        if not IsNullGuid(CRMId) then begin
            if CDScosabonnement.Get(CRMId) then
                OriginalCDScosabonnementList.SetRecord(CDScosabonnement);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCDScosabonnement.Get(SavedCRMId) then
                    OriginalCDScosabonnementList.SetCurrentlyCoupledCDScosabonnement(OriginalCDScosabonnement);
        end;

        CDScosabonnement.SetView(IntTableFilter);
        OriginalCDScosabonnementList.SetTableView(CDScosabonnement);
        OriginalCDScosabonnementList.LookupMode(true);
        if OriginalCDScosabonnementList.RunModal = ACTION::LookupOK then begin
            OriginalCDScosabonnementList.GetRecord(CDScosabonnement);
            CRMId := CDScosabonnement.cos_abonnementId;
            exit(true);
        end;
        exit(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', true, true)]
    local procedure HandleOnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer" temporary);
    begin
        AddEntityTableMapping('cos_abonnement', DATABASE::"CDS cos_abonnement", TempNameValueBuffer);
        AddEntityTableMapping('cos_abonnement', DATABASE::Subscriptions, TempNameValueBuffer);
    end;

    local procedure AddEntityTableMapping(CRMEntityTypeName: Text; TableID: Integer; var TempNameValueBuffer: Record "Name/Value Buffer" temporary)
    begin
        TempNameValueBuffer.Init();
        TempNameValueBuffer.ID := TempNameValueBuffer.Count + 1;
        TempNameValueBuffer.Name := CopyStr(CRMEntityTypeName, 1, MaxStrLen(TempNameValueBuffer.Name));
        TempNameValueBuffer.Value := Format(TableID);
        TempNameValueBuffer.Insert();
    end;

    local procedure InsertIntegrationTableMapping(var IntegrationTableMapping: Record "Integration Table Mapping"; MappingName: Code[20]; TableNo: Integer; IntegrationTableNo: Integer; IntegrationTableUIDFieldNo: Integer; IntegrationTableModifiedFieldNo: Integer; TableConfigTemplateCode: Code[10]; IntegrationTableConfigTemplateCode: Code[10]; SynchOnlyCoupledRecords: Boolean)
    begin
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::FromIntegrationTable, 'CDS');
    end;

    procedure InsertIntegrationFieldMapping(IntegrationTableMappingName: Code[20]; TableFieldNo: Integer; IntegrationTableFieldNo: Integer; SynchDirection: Option; ConstValue: Text; ValidateField: Boolean; ValidateIntegrationTableField: Boolean)
    var
        IntegrationFieldMapping: Record "Integration Field Mapping";
    begin
        IntegrationFieldMapping.CreateRecord(IntegrationTableMappingName, TableFieldNo, IntegrationTableFieldNo, SynchDirection,
            ConstValue, ValidateField, ValidateIntegrationTableField);
    end;


    procedure AddAllSubscriptionMappings()
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CDScosabonnement: Record "CDS cos_abonnement";
        Subscriptions: Record Subscriptions;
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
        InsertIntegrationTableMapping(
            IntegrationTableMapping, 'abo',
            DATABASE::"Subscriptions", DATABASE::"CDS cos_abonnement", CDScosabonnement.FieldNo(cos_abonnementId), CDScosabonnement.FieldNo(ModifiedOn), '', '', false);

        InsertIntegrationFieldMapping('abo', 1, 1, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 24, 24, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 26, 26, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 33, 33, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 34, 34, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 35, 35, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 36, 36, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 38, 38, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 40, 40, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 41, 41, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 42, 42, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 43, 43, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 44, 44, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 45, 45, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 46, 46, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 47, 47, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 48, 48, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 49, 49, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 50, 50, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 51, 51, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 52, 52, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 53, 53, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 54, 54, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 55, 55, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 57, 57, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 58, 58, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 59, 59, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 60, 60, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 61, 61, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 62, 62, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 63, 63, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 65, 65, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 70, 70, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 71, 71, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 72, 72, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 77, 77, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 78, 78, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 79, 79, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 82, 82, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 83, 83, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 84, 84, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 85, 85, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 88, 88, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 91, 91, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 94, 94, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 95, 95, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 96, 96, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 97, 97, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 99, 99, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 100, 100, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 101, 101, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 102, 102, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 103, 103, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 104, 104, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 106, 106, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 107, 107, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 111, 111, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 113, 113, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 114, 114, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 115, 115, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 116, 116, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 117, 117, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 124, 124, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 125, 125, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 128, 128, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 130, 130, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 133, 133, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 134, 134, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 136, 136, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 137, 137, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 138, 138, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        InsertIntegrationFieldMapping('abo', 139, 139, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60700, 60700, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60701, 60701, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60702, 60702, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60703, 60703, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60704, 60704, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60705, 60705, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60706, 60706, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60707, 60707, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60708, 60708, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60709, 60709, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60710, 60710, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60711, 60711, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60712, 60712, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60713, 60713, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60714, 60714, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60715, 60715, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);
        // InsertIntegrationFieldMapping('abo', 60716, 60716, IntegrationFieldMapping.Direction::FromIntegrationTable, '', true, false);


    end;
}