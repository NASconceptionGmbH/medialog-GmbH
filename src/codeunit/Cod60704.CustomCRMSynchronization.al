codeunit 60704 "CustomCRMSynchronization"
{
    Permissions = tabledata "Sales Invoice Header" = rimd, tabledata "Sales Header" = rimd;

    trigger OnRun()
    begin

    end;

    procedure SynchronizeCustomerTypeRelation(var CustomerTypeR: record "Customer Type"; ManualSync: Boolean)
    var
        TypeofBusinessL: Record "Type of Business";
        Customer: Record Customer;
        //   CustomerType: Record "Customer Type";
        JsonObjectL: JsonObject;
        ApiUrlL: text;
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;
        TextGuid: Text;
        ZeroGuid: Guid;
        CheckExistsAPIUrl: text;
        Filterstring: Text;
    begin
        CRMCustomSyncSetupL.Get();

        if NOT ManualSync then
            Clear(CustomerTypeR);

        CustomerTypeR.SetRange(Synced, false);
        if CustomerTypeR.FindSet() then
            repeat
                clear(JsonObjectL);
                if Customer.Get(CustomerTypeR."Customer No.") AND TypeofBusinessL.Get(CustomerTypeR."Type of Business Code") then begin
                    if (Customer."CRM GUID" <> ZeroGuid) and (TypeofBusinessL."CRM GUID" <> ZeroGuid) then begin
                        TextGuid := format(Customer."CRM GUID").Replace('{', '').Replace('}', '');
                        APIUrlL := StrSubstNo(RelationURL, CRMCustomSyncSetupL."API URL", 'accounts', TextGuid, 'cos_account_cos_typeofcustomer');
                        TextGuid := format(TypeofBusinessL."CRM GUID").Replace('{', '').Replace('}', '');
                        JsonObjectL.Add('@odata.id', CRMCustomSyncSetupL."API URL" + 'cos_typeofcustomers(' + TextGuid + ')');

                        //neue JQ checksynced attributes if actually synced and update:
                        // Filterstring := StrSubstNo('accountid eq ''%1'' and cos_typeofcustomerid eq ''%2''', format(Customer."CRM GUID").Replace('{', '').Replace('}', ''), format(TypeofBusinessL."CRM GUID").Replace('{', '').Replace('}', ''));
                        // CheckExistsAPIUrl := StrSubstNo(CheckIfExistsURL, CRMCustomSyncSetupL."API URL", 'cos_account_cos_typeofcustomerset', Filterstring);
                        // if not CheckIfExistsAPI(CheckExistsAPIUrl) then
                        if SendToCRM(JsonObjectL, APIUrlL, false) then begin
                            CustomerTypeR.Synced := true;
                            CustomerTypeR.Modify();
                        end;
                    end;
                end
            until CustomerTypeR.next() = 0;
    end;

    procedure SynchronizeCharacteristicsItemRelation(ItemNoV: Code[20]; ManualSync: Boolean)
    var
        JsonObjectL: JsonObject;
        ApiUrlL: text;
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttributeValueL: Record "Item Attribute Value";
        ItemAttributeValue2L: Record "Item Attribute Value";
        ItemL: Record Item;
        TextGuid: Text;
        ZeroGuid: Guid;
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        CRMCustomSyncSetupL.Get();

        if ManualSync then
            ItemAttributeValueMapping.SetRange("No.", ItemNoV);
        if not ManualSync then
            ItemAttributeValueMapping.SetRange(Synced, false);
        ItemAttributeValueMapping.SetRange("Table ID", 27);
        if EnvironmentInformationL.IsProduction() then
            ItemAttributeValueMapping.SetFilter("Item Attribute ID", '21|26|27|28') //live
        else
            ItemAttributeValueMapping.SetFilter("Item Attribute ID", '22|23|24'); //sandbox
        if ItemAttributeValueMapping.FindSet() then
            repeat
                clear(JsonObjectL);
                if ItemL.Get(ItemAttributeValueMapping."No.") and ItemAttributeValueL.get(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID") then begin
                    if ItemAttributeValueL.Value <> '' then begin
                        if EnvironmentInformationL.IsProduction() then
                            ItemAttributeValue2L.SetRange("Attribute ID", 21)// live
                        else
                            ItemAttributeValue2L.SetRange("Attribute ID", 22); //sandbox
                        ItemAttributeValue2L.SetRange(Value, ItemAttributeValueL.Value);
                        if ItemAttributeValue2L.FindFirst() then
                            if (ItemL."CRM GUID" <> ZeroGuid) and (ItemAttributeValue2L."CRM GUID" <> ZeroGuid) then begin
                                TextGuid := format(ItemL."CRM GUID").Replace('{', '').Replace('}', '');
                                APIUrlL := StrSubstNo(RelationURL, CRMCustomSyncSetupL."API URL", 'products', TextGuid, 'cos_product_cos_characteristic');
                                TextGuid := format(ItemAttributeValue2L."CRM GUID").Replace('{', '').Replace('}', '');
                                JsonObjectL.Add('@odata.id', CRMCustomSyncSetupL."API URL" + 'cos_characteristics(' + TextGuid + ')');

                                if SendToCRM(JsonObjectL, APIUrlL, false) then begin
                                    ItemAttributeValueMapping.Synced := true;
                                    ItemAttributeValueMapping.Modify();
                                end
                            end
                    end
                end;
            until ItemAttributeValueMapping.Next() = 0
    end;

    procedure SynchronizeSparteItemRelation(ItemNoV: Code[20]; ManualSync: Boolean)
    var
        JsonObjectL: JsonObject;
        ApiUrlL: text;
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttributeValueL: Record "Item Attribute Value";
        ItemL: Record Item;
        TextGuid: Text;
        ZeroGuid: Guid;
    begin
        CRMCustomSyncSetupL.Get();

        if ManualSync then
            ItemAttributeValueMapping.SetRange("No.", ItemNoV);
        if not ManualSync then
            ItemAttributeValueMapping.SetRange(Synced, false);
        ItemAttributeValueMapping.SetRange("Table ID", 27);
        ItemAttributeValueMapping.SetFilter("Item Attribute ID", '19');
        if ItemAttributeValueMapping.FindSet() then
            repeat
                clear(JsonObjectL);
                if ItemL.Get(ItemAttributeValueMapping."No.") and ItemAttributeValueL.get(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID") then begin
                    if (ItemL."CRM GUID" <> ZeroGuid) and (ItemAttributeValueL."CRM GUID" <> ZeroGuid) then begin
                        TextGuid := format(ItemL."CRM GUID").Replace('{', '').Replace('}', '');
                        APIUrlL := StrSubstNo(RelationURL, CRMCustomSyncSetupL."API URL", 'products', TextGuid, 'cos_product_cos_sparten');
                        TextGuid := format(ItemAttributeValueL."CRM GUID").Replace('{', '').Replace('}', '');
                        JsonObjectL.Add('@odata.id', CRMCustomSyncSetupL."API URL" + 'cos_spartens(' + TextGuid + ')');

                        if SendToCRM(JsonObjectL, ApiUrlL, false) then begin
                            ItemAttributeValueMapping.Synced := true;
                            ItemAttributeValueMapping.Modify();
                        end;
                    end;
                end;

            until ItemAttributeValueMapping.Next() = 0
    end;



    procedure SynchronizeSparteToCustomerRelation(var CustomerSpartenR: record "Customer Sparten CRM"; ManualSync: Boolean)
    var
        ItemAttributeValueL: Record "Item Attribute Value";
        Customer: Record Customer;
        //   CustomerType: Record "Customer Type";
        JsonObjectL: JsonObject;
        ApiUrlL: text;
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;
        TextGuid: Text;
        ZeroGuid: Guid;
    begin
        CRMCustomSyncSetupL.Get();

        if NOT ManualSync then
            Clear(CustomerSpartenR);

        CustomerSpartenR.SetRange(Synced, false);
        if CustomerSpartenR.FindSet() then
            repeat
                clear(JsonObjectL);
                if Customer.Get(CustomerSpartenR."Customer No.") AND ItemAttributeValueL.Get(19, CustomerSpartenR."Item Attribute Value ID") then begin
                    if (Customer."CRM GUID" <> ZeroGuid) and (ItemAttributeValueL."CRM GUID" <> ZeroGuid) then begin
                        TextGuid := format(Customer."CRM GUID").Replace('{', '').Replace('}', '');
                        APIUrlL := StrSubstNo(RelationURL, CRMCustomSyncSetupL."API URL", 'accounts', TextGuid, 'cos_account_cos_sparten');
                        TextGuid := format(ItemAttributeValueL."CRM GUID").Replace('{', '').Replace('}', '');
                        JsonObjectL.Add('@odata.id', CRMCustomSyncSetupL."API URL" + 'cos_spartens(' + TextGuid + ')');

                        if SendToCRM(JsonObjectL, APIUrlL, false) then begin
                            CustomerSpartenR.Synced := true;
                            CustomerSpartenR.Modify();
                        end;
                    end;
                end
            until CustomerSpartenR.next() = 0;
    end;

    procedure SynchronizeCharacteristicsToCustomerRelation(var CustomerCharacteristicsR: record "Customer Characteristics CRM"; ManualSync: Boolean)
    var
        ItemAttributeValueL: Record "Item Attribute Value";
        Customer: Record Customer;
        //   CustomerType: Record "Customer Type";
        JsonObjectL: JsonObject;
        ApiUrlL: text;
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;
        TextGuid: Text;
        ZeroGuid: Guid;
        AttributeIDL: Integer;
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        if EnvironmentInformationL.IsProduction() then
            AttributeIDL := 21 //live
        else
            AttributeIDL := 22; //sandbox

        CRMCustomSyncSetupL.Get();

        if NOT ManualSync then
            Clear(CustomerCharacteristicsR);

        CustomerCharacteristicsR.SetRange(Synced, false);
        if CustomerCharacteristicsR.FindSet() then
            repeat
                clear(JsonObjectL);
                if Customer.Get(CustomerCharacteristicsR."Customer No.") AND ItemAttributeValueL.Get(AttributeIDL, CustomerCharacteristicsR."Item Attribute Value ID") then begin
                    if (Customer."CRM GUID" <> ZeroGuid) and (ItemAttributeValueL."CRM GUID" <> ZeroGuid) then begin
                        TextGuid := format(Customer."CRM GUID").Replace('{', '').Replace('}', '');
                        APIUrlL := StrSubstNo(RelationURL, CRMCustomSyncSetupL."API URL", 'accounts', TextGuid, 'cos_account_cos_characteristic');
                        TextGuid := format(ItemAttributeValueL."CRM GUID").Replace('{', '').Replace('}', '');
                        JsonObjectL.Add('@odata.id', CRMCustomSyncSetupL."API URL" + 'cos_characteristics(' + TextGuid + ')');

                        if SendToCRM(JsonObjectL, APIUrlL, false) then begin
                            CustomerCharacteristicsR.Synced := true;
                            CustomerCharacteristicsR.Modify();
                        end;
                    end;
                end
            until CustomerCharacteristicsR.next() = 0;

    end;

    procedure SendToCRM(PayloadV: JsonObject; APIUrlV: Text; PatchV: boolean): Boolean
    var
        RequestL: HttpRequestMessage;
        ResponseMessageL: HttpResponseMessage;
        HttpClientL: HttpClient;
        Base64ConvertL: Codeunit "Base64 Convert";
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;

        ResponseTextL: Text;
        CredentialStringL: Text;
        JsonObjectL: JsonObject;
        JsonText: Text;
        ContentL: HttpContent;
        ContentHeaderL: HttpHeaders;

        JsonObject2: JsonObject;
        JsonText2: Text;
        JsonTokenL: JsonToken;
        JsonArrayL: JsonArray;
        ErrorMessageL: Text;
        LicenseText: Text;
        CurrentAppID: Text;
    begin

        CRMCustomSyncSetupL.Get();
        if (CurrentDateTime - CRMCustomSyncSetupL.LastTokenUpdate) > 3500000 then
            GetLoginCredentials();
        CredentialStringL := CRMCustomSyncSetupL."Access Token";


        PayloadV.WriteTo(JsonText);
        ContentL.WriteFrom(JsonText);
        ContentL.GetHeaders(ContentHeaderL);
        ContentHeaderL.Clear();
        ContentHeaderL.Add('Content-type', 'application/json');
        ContentHeaderL.Add('OData-Maxversion', '4.0');
        ContentHeaderL.Add('OData-Version', '4.0');

        RequestL.Content(ContentL);
        if not PatchV then
            RequestL.Method('POST')
        else
            RequestL.Method('PATCH');
        RequestL.SetRequestUri(APIUrlV);



        HttpClientL.DefaultRequestHeaders.add('Authorization', 'Bearer ' + CredentialStringL);

        if not HttpClientL.Send(RequestL, ResponseMessageL) then begin
            //  ErrorTextR := 'The call to the web service failed.';
            message('The call to the web service failed.');
            exit(false);
        end;
        if not ResponseMessageL.IsSuccessStatusCode then begin
            // ResponseMessageL.Content.ReadAs(ErrorMessageL);
            // Message(ErrorMessageL);
            exit(false);
        end;
        //   ResponseMessageL.Content.ReadAs(ResponseTextL);
        ResponseHeader := ResponseMessageL.Headers;
        exit(true);
    end;

    //incomplete:
    // procedure CheckIfExistsAPI(APIUrlV: Text): Boolean
    // var
    //     RequestL: HttpRequestMessage;
    //     ResponseMessageL: HttpResponseMessage;
    //     HttpClientL: HttpClient;
    //     Base64ConvertL: Codeunit "Base64 Convert";
    //     CRMCustomSyncSetupL: Record CRMCustomSyncSetup;

    //     ResponseTextL: Text;
    //     CredentialStringL: Text;
    //     JsonObjectL: JsonObject;
    //     JsonText: Text;
    //     ContentL: HttpContent;
    //     ContentHeaderL: HttpHeaders;

    //     JsonObject2: JsonObject;
    //     JsonText2: Text;
    //     JsonTokenL: JsonToken;
    //     JsonArrayL: JsonArray;
    //     ErrorMessageL: Text;
    //     LicenseText: Text;
    //     CurrentAppID: Text;
    // begin
    //     CRMCustomSyncSetupL.Get();
    //     if (CurrentDateTime - CRMCustomSyncSetupL.LastTokenUpdate) > 3500000 then
    //         GetLoginCredentials();
    //     CredentialStringL := CRMCustomSyncSetupL."Access Token";

    //     ContentL.GetHeaders(ContentHeaderL);
    //     ContentHeaderL.Clear();
    //     ContentHeaderL.Add('Content-type', 'application/json');
    //     ContentHeaderL.Add('OData-Maxversion', '4.0');
    //     ContentHeaderL.Add('OData-Version', '4.0');

    //     RequestL.Method('GET');

    //     HttpClientL.DefaultRequestHeaders.add('Authorization', 'Bearer ' + CredentialStringL);

    //     if not HttpClientL.Send(RequestL, ResponseMessageL) then begin
    //         exit(false);
    //     end;
    //     if not ResponseMessageL.IsSuccessStatusCode then begin
    //         exit(false);
    //     end;

    //     //Todo Parse return values

    //     exit(true);
    // end;

    procedure GetLoginCredentials()
    var
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;
        RequestBody: JsonObject;
        RequestBodyText: Text;
        ContentL: HttpContent;
        ContentHeaderL: HttpHeaders;
        REquestL: HttpRequestMessage;
        ResponseMessageL: HttpResponseMessage;
        HttpClientL: HttpClient;
        ErrorTextL: Text;
        ResponseTextL: Text;
        JsonObjectL: JsonObject;
    begin
        CRMCustomSyncSetupL.Get();

        /*  RequestBody.Add('grant_type', 'client_credentials');
          RequestBody.Add('client_id', CRMCustomSyncSetupL."Client ID");
          RequestBody.Add('client_secret', CRMCustomSyncSetupL."Secret ID");
          RequestBody.Add('scope', CRMCustomSyncSetupL."CRM URL" + '.default');
  */

        RequestBodyText := 'grant_type=client_credentials&' +
                            'client_id=' + CRMCustomSyncSetupL."Client ID" + '&' +
                              'scope=' + CRMCustomSyncSetupL."CRM URL" + '.default&' +
                            'client_secret=' + CRMCustomSyncSetupL."Secret ID";

        //  RequestBody.WriteTo(RequestBodyText);
        ContentL.WriteFrom(RequestBodyText);

        ContentL.GetHeaders(ContentHeaderL);
        ContentHeaderL.Clear();
        ContentHeaderL.Add('Content-type', 'application/x-www-form-urlencoded');
        // ContentHeaderL.Add('Content-type', 'application/json');

        RequestL.Content(ContentL);
        RequestL.Method('POST');
        RequestL.SetRequestUri(CRMCustomSyncSetupL."Token URL");

        if not HttpClientL.Send(RequestL, ResponseMessageL) then begin
            // ErrorTextR := 'The call to the web service failed.';
            Message('The call to the web service failed.');
        end else begin
            if not ResponseMessageL.IsSuccessStatusCode then begin
                ResponseMessageL.Content.ReadAs(ErrorTextL);
                message(ErrorTextL)
            end else begin
                ResponseMessageL.Content.ReadAs(ResponseTextL);
                JsonObjectL.ReadFrom(ResponseTextL);
                CRMCustomSyncSetupL."Access Token" := GetJsonToken(JsonObjectL, 'access_token').AsValue().AsText();
                CRMCustomSyncSetupL.LastTokenUpdate := CurrentDateTime;
                CRMCustomSyncSetupL.Modify();
                Commit();
            end;
        end;
    end;

    procedure UpdateGUIDSFromCRMIntegration()
    var
        CRMCouplingManagementL: Codeunit "CRM Coupling Management";
        CRMIntegrationRecord: Record "CRM Integration Record";
        ItemAttributeValue: Record "Item Attribute Value";
        TypeofBusiness: Record "Type of Business";
        ZeroGuid: Guid;
        CUstomerL: Record CUstomer;
        ContactL: Record Contact;
        ItemL: Record Item;
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        //  ItemAttributeValue.SetFilter("CRM GUID", '%1', ZeroGuid);
        if EnvironmentInformationL.IsProduction() then
            ItemAttributeValue.SetFilter("Attribute ID", '19|21') //live 
        else
            ItemAttributeValue.SetFilter("Attribute ID", '19|22'); //sandbox
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

        // CUstomerL.SetFilter("CRM GUID", '%1', ZeroGuid);
        if CUstomerL.FindSet() then
            repeat
                clear(CRMIntegrationRecord);
                CRMIntegrationRecord.SetRange("Table ID", 18);
                CRMIntegrationRecord.SetRange("Integration ID", CUstomerL.SystemId);
                if CRMIntegrationRecord.FindFirst() then begin
                    CUstomerL."CRM GUID" := CRMIntegrationRecord."CRM ID";
                    CUstomerL.Modify();
                end else begin
                    CUstomerL."CRM GUID" := Zeroguid;
                    CUstomerL.Modify();
                end;
            until CUstomerL.Next() = 0;

        ContactL.SetRange(Type, ContactL.Type::Person);
        ContactL.SetFilter("Company No.", '<>%1', '');
        if ContactL.FindSet() then
            repeat
                clear(CRMIntegrationRecord);
                CRMIntegrationRecord.SetRange("Table ID", Database::Contact);
                CRMIntegrationRecord.SetRange("Integration ID", ContactL.SystemId);
                if CRMIntegrationRecord.FindFirst() then begin
                    ContactL."CRM GUID" := CRMIntegrationRecord."CRM ID";
                    ContactL.Modify();
                end else begin
                    ContactL."CRM GUID" := Zeroguid;
                    ContactL.Modify();
                end;
            until ContactL.Next() = 0;

        // TypeofBusiness.Setfilter("CRM GUID", '%1', ZeroGuid);
        if TypeofBusiness.FindSet() then
            repeat
                clear(CRMIntegrationRecord);
                CRMIntegrationRecord.SetRange("Table ID", 60706);
                CRMIntegrationRecord.SetRange("Integration ID", TypeofBusiness.SystemId);
                if CRMIntegrationRecord.FindFirst() then begin
                    TypeofBusiness."CRM GUID" := CRMIntegrationRecord."CRM ID";
                    TypeofBusiness.Modify();
                end;
            until TypeofBusiness.Next() = 0;

        itemL.Reset;
        if ItemL.FindSet() then
            repeat
                clear(CRMIntegrationRecord);
                CRMIntegrationRecord.SetRange("Table ID", 27);
                CRMIntegrationRecord.SetRange("Integration ID", ItemL.SystemId);
                if CRMIntegrationRecord.FindFirst() then
                    ItemL."CRM GUID" := CRMIntegrationRecord."CRM ID"
                else
                    ItemL."CRM GUID" := ZeroGuid;
                ItemL.Modify();
            until itemL.next() = 0;

        // RemoveCRMIDsFromUncoupledItems();
    end;


    procedure SendOrderConfirmationPDFtoCRM(DocNoV: code[20]): boolean
    var
        RelativeDocLocationL: Text;
        CustomerL: Record Customer;
        CustomerShipToL: Record Customer;
        SalesHeaderL: Record "Sales Header";
    begin
        // SalesHeaderL.Get(SalesHeaderL."Document Type"::Order, DocNoV);
        SalesHeaderL.Get(SalesHeaderL."Document Type"::Quote, DocNoV);
        //    salesheaderL."Is Handled" := true;


        CustomerL.Get(SalesHeaderL."Sell-to Customer No.");
        if NOT IsNullGuid(CustomerL."CRM GUID") then begin
            RelativeDocLocationL := DoesCRMDocLocationExist(SalesHeaderL."Sell-to Customer No.");
            if RelativeDocLocationL <> '' then begin
                GenerateConfirmationPDFAndSend(DocNoV, RelativeDocLocationL)
            end else begin
                RelativeDocLocationL := GetVaildSharePointName(CUstomerL.Name) + '_' + format(CustomerL."CRM GUID").Replace('{', '').replace('}', '');
                GenerateConfirmationPDFAndSend(DocNoV, RelativeDocLocationL);
                CreateDocumentLocation(SalesHeaderL."Sell-to Customer No.", RelativeDocLocationL);
            end;
        end;

        RelativeDocLocationL := '';
        IF CustomerShipToL.Get(SalesHeaderL."Ship-To Customer No.") then begin
            if NOT IsNullGuid(CustomerShipToL."CRM GUID") then begin
                RelativeDocLocationL := DoesCRMDocLocationExist(SalesHeaderL."Ship-To Customer No.");
                if RelativeDocLocationL <> '' then begin
                    GenerateConfirmationPDFAndSend(DocNoV, RelativeDocLocationL)
                end else begin
                    RelativeDocLocationL := GetVaildSharePointName(CustomerShipToL.Name) + '_' + format(CustomerShipToL."CRM GUID").Replace('{', '').replace('}', '');
                    GenerateConfirmationPDFAndSend(DocNoV, RelativeDocLocationL);
                    CreateDocumentLocation(SalesHeaderL."Ship-To Customer No.", RelativeDocLocationL);
                end;
            end;
        end;

    end;

    local procedure DoesCRMDocLocationExist(CustomerNoV: Code[20]): text;
    var
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;
        RequestL: HttpRequestMessage;
        ResponseMEssageL: HttpResponseMessage;
        CredentialStringL: Text;
        HttpClientL: HttpClient;
        APIUrlL: Text;
        TextGuidL: Text;
        CustomerL: Record Customer;
        ErrorMEssageL: Text;
        JsonObjectL: JsonObject;
        ResponseTextL: Text;
        JsonTokenL: JsonToken;
        JsonArrayL: JsonArray;
        JsonText: Text;
        ResultJsonObject: JsonObject;
        RelativeUrl: Text;
        ZeroDateTime: DateTime;
    begin
        CRMCustomSyncSetupL.Get();
        if CRMCustomSyncSetupL.LastTokenUpdate = ZeroDateTime then
            GetLoginCredentials()
        else
            if (CurrentDateTime - CRMCustomSyncSetupL.LastTokenUpdate) > 3500000 then
                GetLoginCredentials();

        CRMCustomSyncSetupL.Get();
        CredentialStringL := CRMCustomSyncSetupL."Access Token";

        CustomerL.GET(CustomerNoV);
        TextGuidL := format(CustomerL."CRM GUID").Replace('{', '').Replace('}', '');
        APIUrlL := CRMCustomSyncSetupL."API URL" + 'sharepointdocumentlocations?$filter=_regardingobjectid_value eq ''' + TextGuidL + '''';

        RequestL.Method('GET');
        RequestL.SetRequestUri(APIUrlL);

        HttpClientL.DefaultRequestHeaders.add('Authorization', 'Bearer ' + CredentialStringL);

        if not HttpClientL.Send(RequestL, ResponseMessageL) then begin
            //  ErrorTextR := 'The call to the web service failed.';
            Error('The call to the web service failed.');
            // exit(false);
        end;

        if not ResponseMessageL.IsSuccessStatusCode then begin
            ResponseMessageL.Content.ReadAs(ErrorMessageL);
            Error(ErrorMessageL);
            // exit(false);
        end;

        ResponseMessageL.Content.ReadAs(ResponseTextL);
        JsonObjectL.ReadFrom(ResponseTextL);
        JsonTokenL := GetJsonToken(JsonObjectL, 'value');
        JsonArrayL := JsonTokenL.AsArray();
        if JsonArrayL.Count > 0 then begin
            JsonArrayL.WriteTo(JsonText);
            JsonTokenL.ReadFrom(JsonText);
            if JsonArrayL.Get(0, JsonTokenL) then
                ResultJsonObject := JsonTokenL.AsObject;

            RelativeUrl := GetJsonToken(ResultJsonObject, 'relativeurl').AsValue().AsText();

            exit(RelativeUrl);
        end;

        exit('');
    end;

    local procedure CreateDocumentLocation(CustomerNoV: Code[20]; RelativeUrlV: text)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        JsonObjectL: JsonObject;

        APIUrlL: Text;
        CRMCustomSyncSetup: Record CRMCustomSyncSetup;
        TextArray: Array[1] of Text;
        CRMGUIDL: Text;
        CUstomerL: Record Customer;
        RelativeUrlL: Text;
    begin
        CRMCustomSyncSetup.Get();
        CustomerL.Get(CustomerNoV);

        JsonObjectL.add('regardingobjectid_account@odata.bind', '/accounts(' + format(CustomerL."CRM GUID").Replace('{', '').replace('}', '') + ')');
        JsonObjectL.add('name', CUstomerL.Name + ' Dokumente');

        JsonObjectL.add('relativeurl', RelativeUrlV);
        JsonObjectL.Add('parentsiteorlocation_sharepointdocumentlocation@odata.bind', '/sharepointdocumentlocations(' + format(CRMCustomSyncSetup."Sharepoint Doc Location GUID").Replace('{', '').replace('}', '') + ')');

        APIUrlL := CRMCustomSyncSetup."API URL" + 'sharepointdocumentlocations';

        if SendToCRM(JsonObjectL, APIUrlL, false) then begin
        end;

    end;

    local procedure GenerateConfirmationPDFAndSend(DocNoV: Code[20]; RelativeURL: Text)
    var
        ReportSelectionsL: Record "Report Selections";
        ReportNoL: Integer;
        SalesHeaderL: Record "Sales Header";
        FileNameL: Text;
        FolderNameL: Text;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        OutStreamL: OutStream;
        InstreamL: InStream;
        SharePointSetupL: Record "SharePoint Setup";
        UrlL: Text;
        CRMCustomSyncSetup: Record CRMCustomSyncSetup;
    begin
        CRMCustomSyncSetup.Get();
        // ReportSelectionsL.SetRange(Usage, ReportSelectionsL.Usage::"S.Order");
        ReportSelectionsL.SetRange(Usage, ReportSelectionsL.Usage::"S.Quote");
        if ReportSelectionsL.FindFirst() then
            ReportNoL := ReportSelectionsL."Report ID"
        else
            // ReportNoL := 1305;
            ReportNoL := 1304;

        SalesHeaderL.SetRange("Document Type", SalesHeaderL."Document Type"::Quote);
        SalesHeaderL.SetRange("No.", DocNoV);
        SalesHeaderL.FindFirst();

        FileNameL := 'Angebot ' + SalesHeaderL."No." + '.pdf';
        FolderNameL := RelativeURL;


        RecRef.GetTable(SalesHeaderL);
        TempBlob.CreateOutStream(OutStreamL);
        Report.SaveAs(ReportNoL, '', ReportFormat::Pdf, OutStreamL, RecRef);
        TempBlob.CreateInStream(InStreamL);


        SharePointSetupL.Get();
        UrlL := 'https://graph.microsoft.com/v1.0/sites/' + SharePointSetupL."SiteID 1" + '/drives/' + CRMCustomSyncSetup.DriveID + '/items/root:/' + FolderNameL + '/' + FileNameL + ':/content';
        SendConfirmationToSP(InstreamL, FileNameL, UrlL, SharePointSetupL."SiteID 1", FolderNameL)
    end;

    local procedure SendConfirmationToSP(var InstreamR: InStream; FileNameV: Text[250]; UrlV: Text; SiteIDV: Text[250]; FolderNameV: Text[250])
    var
        AccesTokenL: Text;
        ContentL: HttpContent;

        ContentHeaderL: HttpHeaders;
        RequestL: HttpRequestMessage;
        Request2L: HttpRequestMessage;
        ResponseMessageL: HttpResponseMessage;
        HttpClientL: HttpClient;

        ReturnMessageL: Text;

        JsonText: Text;
    begin
        AccesTokenL := GetToken();

        ContentL.WriteFrom(InstreamR);
        ContentL.GetHeaders(ContentHeaderL);
        ContentHeaderL.Clear();
        ContentHeaderL.Add('Content-type', 'application/json');
        ContentHeaderL.Add('name', FileNameV);
        ContentHeaderL.Add('Content-Encoding', 'base64');

        RequestL.Content(ContentL);
        RequestL.SetRequestUri(UrlV);
        RequestL.Method('PUT');

        HttpClientL.DefaultRequestHeaders.add('Authorization', 'Bearer ' + AccesTokenL);
        if not HttpClientL.Send(RequestL, ResponseMessageL) then begin
            Message('call to webservice failed');
        end;

        if not ResponseMessageL.IsSuccessStatusCode then begin
            ResponseMessageL.Content.ReadAs(ReturnMessageL);
            Message(ReturnMessageL);
        end;
    end;

    local procedure GetToken(): Text;
    var
        JsonObjectL: JsonObject;
        SharePointAddinCodeUnit_NASL: Codeunit SharePointAddinCodeUnit_NAS;
        SharepointSetupL: Record "SharePoint Setup";
        JsonTokenL: JsonToken;
        JsonText: Text;
        CutText: Text;
    begin
        SharepointSetupL.get;
        JsonObjectL := SharePointAddinCodeUnit_NASL.Connect('https://login.microsoftonline.com/' + SharepointSetupL.TenantID + '/oauth2/token');

        if JsonObjectL.Get('access_token', JsonTokenL) then begin
            JsonTokenL.WriteTo(JsonText);
            CutText := CopyStr(JsonText, 2, StrLen(JsonText) - 2);
            exit(CutText);
        end;
    end;


    /*local procedure RemoveCRMIDsFromUncoupledItems()
    var
        ItemL: Record Item;
        CRMCouplingManagementL: Codeunit "CRM Coupling Management";
        CRMIntegrationRecord: Record "CRM Integration Record";
        ZeroGuid: Guid;
    begin
        itemL.SetFilter("CRM GUID", '<>%1', ZeroGuid);
        ItemL.SetRange("No.", '56276');
        if ItemL.FindSet() then
            repeat
                clear(CRMIntegrationRecord);
                CRMIntegrationRecord.SetRange("Table ID", 27);
                CRMIntegrationRecord.SetRange("Integration ID", ItemL.SystemId);
                if CRMIntegrationRecord.FindFirst() then begin
                    if CRMCouplingManagementL.IsRecordCoupledToCRM(ItemL.RecordId) then
                        ItemL."CRM GUID" := CRMIntegrationRecord."CRM ID"
                    else
                        ItemL."CRM GUID" := ZeroGuid;

                end;

            until itemL.next() = 0;
    end;
*/

    // procedure ExportSaleOrder(SalesHeaderNoV: Code[20]): boolean
    // var
    //     SalesHeader: Record "Sales Header";
    //     CustomerL: Record Customer;
    //     JsonObjectL: JsonObject;

    //     APIUrlL: Text;
    //     CRMCustomSyncSetup: Record CRMCustomSyncSetup;
    //     TextArray: Array[1] of Text;
    //     CRMGUIDL: Text;

    //     CRMIntegrationRecordL: Record "CRM Integration Record";
    //     CRMIntegrationManagement: Codeunit "CRM Integration Management";
    //     ZeroGuid: Guid;
    // begin
    //     SalesHeader.Get(Salesheader."Document Type"::Order, SalesHeaderNoV);
    //     if SalesHeader."CRM Order ID" = ZeroGuid then
    //         if NOT CRMIntegrationRecordL.Get(SalesHeader."CRM Order ID", SalesHeader.SystemId) then begin
    //             CRMCustomSyncSetup.Get();
    //             clear(ResponseHeader);

    //             JsonObjectL.Add('name', SalesHeader."No.");
    //             JsonObjectL.Add('ordernumber', SalesHeader."No.");
    //             JsonObjectL.Add('customerid_account@odata.bind', '/accounts(' + format(SalesHeader."Customer CRM GUID").Replace('{', '').replace('}', '') + ')');
    //             //  JsonObjectL.add('pricelevelid@odata.bind', '/pricelevels(b0f4ca9b-ed11-ea11-a811-000d3ab9bc3d)');
    //             //PriceLevelId

    //             APIUrlL := CRMCustomSyncSetup."API URL" + 'salesorders';

    //             if SendToCRM(JsonObjectL, APIUrlL, false) then begin
    //                 if ResponseHeader.Contains('Location') then begin
    //                     ResponseHeader.GetValues('Location', TextArray);
    //                     CRmguidL := TextArray[1].Replace(APIUrlL, '').Replace('(', '').Replace(')', '');
    //                     SalesHeader."CRM Order ID" := CRMGUIDL;
    //                     SalesHeader.Modify();
    //                     CRMIntegrationRecordL.InsertRecord(CRMGUIDL, salesheader.SystemId, 36);
    //                     Commit();

    //                     if CustomerL.Get(salesheader."Ship-To Customer No.") then
    //                         PatchSalesOrderAddress(SalesHeader."CRM Order ID", CustomerL."CRM GUID");

    //                     ExportSalesOrderLines(SalesHeader."No.");
    //                 end;
    //             end else
    //                 exit(false);
    //         end;


    //     //CRMIntegrationManagement.UpdateOneNow(SalesHeader.RecordId);
    // end;

    // procedure PatchSalesOrderAddress(OrderID: Guid; ShipToCustGuid: guid)
    // var
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     JsonObjectL: JsonObject;

    //     APIUrlL: Text;
    //     CRMCustomSyncSetup: Record CRMCustomSyncSetup;
    //     TextArray: Array[1] of Text;
    //     CRMGUIDL: Text;
    // begin
    //     CRMCustomSyncSetup.Get();

    //     JsonObjectL.add('cos_deliverytocustomer_account@odata.bind', '/accounts(' + format(ShipToCustGuid).Replace('{', '').replace('}', '') + ')');

    //     APIUrlL := CRMCustomSyncSetup."API URL" + 'salesorders(' + format(OrderID).Replace('{', '').Replace('}', '') + ')';

    //     if SendToCRM(JsonObjectL, APIUrlL, true) then begin
    //     end;
    // end;

    // procedure ExportSalesOrderLines(SalesHeaderNoV: Code[20])
    // var
    //     SalesHeader: Record "Sales Header";
    //     SalesLine: Record "Sales Line";
    //     JsonObjectL: JsonObject;
    //     ItemL: Record Item;

    //     APIUrlL: Text;
    //     CRMCustomSyncSetup: Record CRMCustomSyncSetup;
    //     TextArray: Array[1] of Text;
    //     CRMGUIDL: Text;
    // begin
    //     CRMCustomSyncSetup.Get();
    //     SalesHeader.Get(SalesHeader."Document Type"::Order, SalesHeaderNoV);

    //     clear(ResponseHeader);

    //     SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
    //     SalesLine.SetRange("Document No.", SalesHeaderNoV);
    //     SalesLine.SetRange(Type, SalesLine.Type::Item);
    //     if SalesLine.findfirst() then begin
    //         ItemL.Get(SalesLine."No.");
    //         JsonObjectL.Add('salesorderid@odata.bind', '/salesorders(' + format(SalesHeader."CRM Order ID").Replace('{', '').replace('}', '') + ')');
    //         JsonObjectL.Add('productid@odata.bind', '/products(' + format(ItemL."CRM GUID").Replace('{', '').replace('}', '') + ')');
    //         JsonObjectL.add('uomid@odata.bind', '/uoms(3b1a339b-ed11-ea11-a811-000d3ab9b226)');
    //         JsonObjectL.add('priceperunit', SalesLine."Unit Price");
    //         JsonObjectL.add('quantity', SalesLine.Quantity);
    //     end;

    //     APIUrlL := CRMCustomSyncSetup."API URL" + 'salesorderdetails';

    //     if SendToCRM(JsonObjectL, APIUrlL, false) then begin
    //         // if ResponseHeader.Contains('Location') then begin
    //         //     ResponseHeader.GetValues('Location', TextArray);
    //         //     CRmguidL := TextArray[1].Replace(APIUrlL, '').Replace('(', '').Replace(')', '');
    //         //     SalesInvoiceHeader."CRM Guid" := CRMGUIDL;
    //         // end;
    //         // SalesInvoiceHeader."CRM Invoice Synced" := true;
    //         // SalesInvoiceHeader.Modify();

    //         // LinkCRMInvoices(SalesInvoiceHeader."No.");
    //         // CreateInvoiceLinesCRM(SalesInvoiceHeader."No.")
    //     end else
    //         message('zeilen wollten nicht');

    // end;


    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then Error('Could not find a token with key %1', TokenKey);
    end;


    var
        RelationURL: Label '%1%2(%3)/%4/$ref', Locked = true; //CRM APIURL , Entity1 Name, Entity ID, Entity 2 Name
        //https://vulkanverlaggmbh.api.crm4.dynamics.com/api/data/v9.2/ 
        CheckIfExistsURL: Label '%1%?$filter=%3', locked = true; //CRM API Url, RelationSetName,Filter
        NoOf: Option ,Scheduled,Failed,Skipped,Total;
        ResponseHeader: HttpHeaders;


    local procedure GetVaildSharePointName(CustomerNameV: Text[100]): Text[100]
    var
    // v: Codeunit Regex;
    begin
        //Chars that ar not allowd in SharePoint  ~ " # % & * : < > ? / \ { | }.

        if CustomerNameV.Contains('~') then
            CustomerNameV := CustomerNameV.Replace('~', '');
        if CustomerNameV.Contains('"') then
            CustomerNameV := CustomerNameV.Replace('"', '');
        if CustomerNameV.Contains('#') then
            CustomerNameV := CustomerNameV.Replace('#', '');
        if CustomerNameV.Contains('%') then
            CustomerNameV := CustomerNameV.Replace('%', '');
        if CustomerNameV.Contains('&') then
            CustomerNameV := CustomerNameV.Replace('&', '_');
        if CustomerNameV.Contains('*') then
            CustomerNameV := CustomerNameV.Replace('*', '');
        if CustomerNameV.Contains(':') then
            CustomerNameV := CustomerNameV.Replace(':', '');
        if CustomerNameV.Contains('<') then
            CustomerNameV := CustomerNameV.Replace('<', '');
        if CustomerNameV.Contains('>') then
            CustomerNameV := CustomerNameV.Replace('>', '');
        if CustomerNameV.Contains('?') then
            CustomerNameV := CustomerNameV.Replace('?', '');
        if CustomerNameV.Contains('/') then
            CustomerNameV := CustomerNameV.Replace('/', '');
        if CustomerNameV.Contains('\') then
            CustomerNameV := CustomerNameV.Replace('\', '');
        if CustomerNameV.Contains('{') then
            CustomerNameV := CustomerNameV.Replace('{', '');
        if CustomerNameV.Contains('|') then
            CustomerNameV := CustomerNameV.Replace('|', '_');
        if CustomerNameV.Contains('}') then
            CustomerNameV := CustomerNameV.Replace('}', '');
        if CustomerNameV.Contains('.') then
            CustomerNameV := CustomerNameV.Replace('.', '');

        exit(CustomerNameV);

    end;


    procedure SynchronizeCharacteristicsToContactRelation(var ContactCharacteristicsR: record "Contact Characteristics CRM"; ManualSync: Boolean)
    var
        ItemAttributeValueL: Record "Item Attribute Value";
        Contact: Record Contact;
        //   CustomerType: Record "Customer Type";
        JsonObjectL: JsonObject;
        ApiUrlL: text;
        CRMCustomSyncSetupL: Record CRMCustomSyncSetup;
        TextGuid: Text;
        ZeroGuid: Guid;
        AttributeIDL: Integer;
        EnvironmentInformationL: Codeunit "Environment Information";
    begin
        if EnvironmentInformationL.IsProduction() then
            AttributeIDL := 21 //live
        else
            AttributeIDL := 22; //sandbox

        CRMCustomSyncSetupL.Get();

        if NOT ManualSync then
            Clear(ContactCharacteristicsR);

        ContactCharacteristicsR.SetRange(Synced, false);
        if ContactCharacteristicsR.FindSet() then
            repeat
                clear(JsonObjectL);
                if Contact.Get(ContactCharacteristicsR."Contact No.") AND ItemAttributeValueL.Get(AttributeIDL, ContactCharacteristicsR."Item Attribute Value ID") then begin
                    if (Contact."CRM GUID" <> ZeroGuid) and (ItemAttributeValueL."CRM GUID" <> ZeroGuid) then begin
                        TextGuid := format(Contact."CRM GUID").Replace('{', '').Replace('}', '');
                        APIUrlL := StrSubstNo(RelationURL, CRMCustomSyncSetupL."API URL", 'contacts', TextGuid, 'cos_contact_cos_characteristic');
                        TextGuid := format(ItemAttributeValueL."CRM GUID").Replace('{', '').Replace('}', '');
                        JsonObjectL.Add('@odata.id', CRMCustomSyncSetupL."API URL" + 'cos_characteristics(' + TextGuid + ')');

                        if SendToCRM(JsonObjectL, APIUrlL, false) then begin
                            ContactCharacteristicsR.Synced := true;
                            ContactCharacteristicsR.Modify();
                        end;
                    end;
                end
            until ContactCharacteristicsR.next() = 0;

    end;
}

