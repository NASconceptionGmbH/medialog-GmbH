codeunit 60701 "SharePointAddinCodeUnit_NAS"
{
    procedure Connect(POSTURL: Text): JsonObject;
    var
        SharePointSetupL: Record "SharePoint Setup";
        Content: HttpContent;
        Parameters: Text;
        ContentHeaders: HttpHeaders;
        reqHeaders: HttpHeaders;
        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        JArray: JsonObject;
        StatusCode: Integer;
        Error1L: Label 'No communication', comment = 'DEU="Keine Verbindung"';
        Error2L: Label ' Invalid Response from Microsoft Server', comment = 'DEU="Fehlerhafte Rückmeldung von Microsoft Service"';
    begin
        SharePointSetupL.Get();
        if SharePointSetupL."Client ID" = '' then
            Parameters := 'grant_type=client_credentials&client_id=9fe85c29-0d4b-4927-a113-ffcb2573a8f2&client_secret=L%5DC0F%5E%2Bzo7%3EN%3A%5E5%2Bl_%23&resource=https%3A%2F%2Fgraph.microsoft.com&undefined='
        else
            Parameters := 'grant_type=client_credentials&client_id=' + SharePointSetupL."Client ID" + '&client_secret=' + SharePointSetupL."Client Secret" + '&resource=https%3A%2F%2Fgraph.microsoft.com&undefined=';
        Content.WriteFrom(Parameters);

        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Remove('content-type');
        ContentHeaders.Add('content-type', 'application/x-www-form-urlencoded');

        HttpRequest.Content := Content;
        HttpRequest.SetRequestUri(POSTURL);
        HttpRequest.Method('POST');

        If Not HttpClient.Send(HttpRequest, ResponseMessage) THEN
            Error(Error1L);
        ResponseMessage.Content().ReadAs(ResponseText);
        if not JArray.ReadFrom(ResponseText) then begin
            Error(Error2L);
        end;
        StatusCode := ResponseMessage.HttpStatusCode();
        JArray.Add('Code', StatusCode);
        Exit(JArray);
    end;

    procedure GetOptions(): JsonObject;
    var
        Options: Record "SharePoint Setup";
        JObject: JsonObject;
        MyModule: ModuleInfo;
        Cfailed: Label 'The app has to be installed first', comment = 'DEU="Die App muss zuerst installiert werden."';
        Pfailed: Label 'Installation not yet completed', comment = 'DEU="Die Installation ist noch nicht vollständig abgeschlossen."';

        SiteIDL: Text[250];
    begin


        if Options.get() then begin

            SiteIDL := Options."SiteID 1";

            if NOT Options.InBearbeitung = true then begin
                JObject.Add('TenantID', Options.TenantID);
                JObject.Add('SiteID', SiteIDL);
                JObject.Add('HighestFolder', Options.HighestFolder);
                JObject.Add('MaximalTiefe', Options.MaximalTiefe);
                JObject.Add('CreateLinkEnabled', Options.CreateLinkEnabled);
                JObject.Add('SalesLine', Options.SalesLine);
            end else begin
                JObject.Add('failed', Pfailed);
            end;
        end else begin
            JObject.Add('failed', Cfailed);
        end;
        // NavApp.GetCurrentModuleInfo(MyModule);
        // Message('ID: %1 / Name: %2', MyModule.Id(), MyModule.Name());
        Exit(JObject);
    end;



    procedure UpdateItemDescriptionInSharepoint(ItemNoV: Code[20])
    var
        ContentL: HttpContent;
        HttpClientL: HttpClient;
        ContentHeaderL: HttpHeaders;
        Request2L: HttpRequestMessage;
        ResponseMessageL: HttpResponseMessage;
        URL: Text;

        MetaDataJsonL: JsonObject;
        JsonText: Text;
        ReturnMessageL: Text;

        AccesTokenL: Text;
        SharepointSetupL: Record "SharePoint Setup";
        InstallationSharePointCU_NAS: Codeunit InstallationSharePointCU_NAS;

        SiteIDL: Text[250];
        ItemL: Record Item;
        YearL: Integer;
        Magtype: Text;

        MagazineType: Record "Magazine Type";

        JsonObjectL: JsonObject;
    begin

        SharepointSetupL.get;

        SiteIDL := SharepointSetupL."SiteID 1";

        AccesTokenL := InstallationSharePointCU_NAS.GetToken();

        ContentL.Clear();
        HttpClientL.Clear();
        ContentHeaderL.Clear();

        if ItemL.Get(ItemNoV) then begin
            if ItemL."Publication Date" <> 0D then
                YearL := Date2DMY(ItemL."Publication Date", 3)
            else
                YearL := 0;
            if MagazineType.Get(ItemL."Magazine Type") then
                MagType := MagazineType.Description
            else
                Magtype := 'NoType';

            URL := 'https://graph.microsoft.com/v1.0/sites/' + SiteIDL + '/drive/items/root:/' + SharePointSetupL.HighestFolder + '/' + SharePointSetupL.SalesLine + '/' + MagType + '/' + format(YearL) + '/' + ItemNoV + ':/listItem/fields';

            JsonObjectL.Add(SharepointSetupL.ColumnDescription, ItemL.Description);
            JsonObjectL.WriteTo(JsonText);

            ContentL.WriteFrom(JsonText);
            ContentL.GetHeaders(ContentHeaderL);
            ContentHeaderL.Clear();
            ContentHeaderL.Add('Content-type', 'application/json');

            Request2L.Content(ContentL);
            Request2L.SetRequestUri(URL);
            Request2L.Method('PATCH');

            HttpClientL.DefaultRequestHeaders.add('Authorization', 'Bearer ' + AccesTokenL);
            if not HttpClientL.Send(Request2L, ResponseMessageL) then begin
                //  Message('call to webservice failed');
            end;

            if not ResponseMessageL.IsSuccessStatusCode then begin
                // ResponseMessageL.Content.ReadAs(ReturnMessageL);
                // Message(ReturnMessageL);
            end else begin
                ItemL.ItemDescriptionUploaded := true;
                ItemL.Modify();
            end;
        end;
    end;

}