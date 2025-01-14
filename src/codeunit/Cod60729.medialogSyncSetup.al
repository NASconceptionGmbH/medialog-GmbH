codeunit 60729 "medialog Sync Setup"
{

    local procedure InsertIntegrationTableMapping(var IntegrationTableMapping: Record "Integration Table Mapping"; MappingName: Code[20]; TableNo: Integer; IntegrationTableNo: Integer; IntegrationTableUIDFieldNo: Integer; IntegrationTableModifiedFieldNo: Integer; TableConfigTemplateCode: Code[10]; IntegrationTableConfigTemplateCode: Code[10]; SynchOnlyCoupledRecords: Boolean)
    begin
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::ToIntegrationTable, 'CDS');
    end;

    procedure InsertIntegrationFieldMapping(IntegrationTableMappingName: Code[20]; TableFieldNo: Integer; IntegrationTableFieldNo: Integer; SynchDirection: Option; ConstValue: Text; ValidateField: Boolean; ValidateIntegrationTableField: Boolean)
    var
        IntegrationFieldMapping: Record "Integration Field Mapping";
    begin
        IntegrationFieldMapping.CreateRecord(IntegrationTableMappingName, TableFieldNo, IntegrationTableFieldNo, SynchDirection,
            ConstValue, ValidateField, ValidateIntegrationTableField);
    end;



    procedure AddAllMappings()
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";

        ContactL: Record Contact;
        CRMContactL: Record "CRM Contact";

    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");

        // InsertIntegrationFieldMapping('CONTACT', 50760, CRMContactL.FieldNo(EMailAddress1), IntegrationFieldMapping.Direction::ToIntegrationTable, '', false, false);
    end;

    procedure UpdateMapping()
    var
        CRMContactL: Record "CRM Contact";
        IntegrationFieldMapping: Record "Integration Field Mapping";

    begin
        // InsertIntegrationFieldMapping('CONTACT', 50760, CRMContactL.FieldNo(EMailAddress1), IntegrationFieldMapping.Direction::ToIntegrationTable, '', false, false);
    end;





}