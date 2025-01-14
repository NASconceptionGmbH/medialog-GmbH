codeunit 60702 "InstallationSharePointCU_NAS"
{
    var
        SharePointAddinCodeUnit: Codeunit SharePointAddinCodeUnit_NAS;
        Options: Record "SharePoint Setup";
        JToken: JsonToken;


    procedure Connect(): JsonObject
    var
        JsonRet: JsonObject;
        JObject: JsonObject;
        MyModule: ModuleInfo;
        Denied: Label 'Denied access from Server, permissionerror', comment = 'DEU="Zugriff vom Server verweigert, Zugriffsrechte Problem"';
    begin

        if Options.get() then begin
            JObject := SharePointAddinCodeUnit.Connect('https://login.microsoftonline.com/' + Options.TenantID + '/oauth2/token');
            if NOT JObject.Get('access_token', JToken) then begin
                JsonRet.Add('Sales Line Folder', 401);
                JsonRet.Add('Site ID', 'Denied access from Server, Permissionerror');
                Exit(JsonRet);
            end;

            JsonRet.Add('Site ID', GetSideID());
            JsonRet.Add('Sales Line Folder', CreateFolder(Options.SalesLine));

            Exit(JsonRet);
        end;
    end;

    procedure GetSideID() SiteIDR: Text
    var
        Parameter: Text;
        JObject: JsonObject;
        JGetToken: JsonToken;
        JGetArray: JsonArray;
        StatusCode: Integer;
        URL: text;
        Token: Text;
        Found: Label 'Site found', comment = 'DEU="Seite gefunden"';
        NotFound: Label 'Site not found', comment = 'DEU="Seite nicht gefunden"';
        CurrentSiteL: TExt[250];
    begin
        CurrentSiteL := Options."SiteID 1";
        URL := 'https://graph.microsoft.com/v1.0/sites?search={' + CurrentSiteL + '}';
        JObject.ReadFrom(Send(URL, 'Get'));
        if JObject.Get('value', JGetToken) then begin
            JGetToken.WriteTo(Token);
            JGetArray.ReadFrom(Token);
            if NOT JGetArray.Get(0, JGetToken) then begin
                URL := 'https://graph.microsoft.com/v1.0/sites/' + CurrentSiteL;
                JObject.ReadFrom(Send(URL, 'Get'));
                if JObject.Get('error', JGetToken) then begin
                    SiteIDR := NotFound;
                end else
                    if NOT JObject.Get('id', JGetToken) then begin
                        SiteIDR := NotFound;
                    end else begin
                        SiteIDR := Found;
                    end;

                exit;
            end;
            JGetToken.AsObject().Get('id', JGetToken);

            Options."SiteID 1" := JGetToken.AsValue().AsText();

            Options.Modify();
            Commit();
            SiteIDR := Found;
        end;
    end;

    procedure Send(URL: Text; Method: Text) Ret: Text
    var
        Client: HttpClient;
        RespondMessage: HttpResponseMessage;
        RespondMessage2: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        RequestMessageCopy: HttpRequestMessage;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        RequestHeaders: HttpHeaders;
        Token: Text;
        ErrorMsg: Label 'Error when trying to find the Site', comment = 'DEU="Fehler beim suchen der Seite"';
    begin
        RequestMessage.Method(Method);
        RequestMessage.SetRequestUri(URL);
        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Clear();
        Token := 'Bearer ' + JToken.AsValue().AsText();
        RequestHeaders.Add('authorization', Token);
        RequestMessageCopy := RequestMessage;
        if not Client.Send(RequestMessage, RespondMessage) then
            Error(ErrorMsg);
        RespondMessage.Content().ReadAs(Ret);
    end;

    procedure CreateFolder(Name: Text): Integer
    var
        Parameter: Text;
        JsonRequest: JsonObject;
        RequestToken: JsonToken;
        Client: HttpClient;
        RespondMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        RequestHeaders: HttpHeaders;
        StatusCode: Integer;
        URL: text;
        Token: Text;
        ErrorMsg: Label 'Could not connect to Microsoft services', comment = 'DEU="Verbindung zu Microsoft Service konnte nicht hergestellt werden."';
        SiteIDL: Text[250];
    begin

        SiteIDL := Options."SiteID 1";

        RequestToken.ReadFrom('{  }');
        JsonRequest.Add('folder', RequestToken);
        JsonRequest.Add('name', Name);
        JsonRequest.Add('@microsoft.graph.conflictBehavior', 'fail');
        JsonRequest.WriteTo(Parameter);
        Content.WriteFrom(Parameter);

        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Remove('content-type');
        ContentHeaders.Add('content-type', 'application/json');

        RequestMessage.Content := Content;
        RequestMessage.Method('POST');

        if NOT (Options.HighestFolder = '') then begin
            URL := 'https://graph.microsoft.com/v1.0/sites/' + SiteIDL + '/drive/root:/' + Options.HighestFolder + ':/children';

        end
        else begin
            URL := 'https://graph.microsoft.com/v1.0/sites/' + SiteIDL + '/drive/root/children';
        end;

        RequestMessage.SetRequestUri(URL);
        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Clear();
        Token := 'Bearer ' + JToken.AsValue().AsText();
        RequestHeaders.Add('authorization', Token);

        if not Client.Send(RequestMessage, RespondMessage) then
            Error(ErrorMsg);

        StatusCode := RespondMessage.HttpStatusCode();
        EXIT(StatusCode);
    end;

    /*  procedure CreateSharepointColumns(JsonPayload: JsonObject; var ActualColumnNameR: Text): Boolean
      var
          ContentL: HttpContent;
          HttpClientL: HttpClient;
          ContentHeaderL: HttpHeaders;
          ResponseMessageL: HttpResponseMessage;
          RequestL: HttpRequestMessage;
          URL: Text;

          ColumnJsonL: JsonObject;
          JsonText: Text;
          ReturnMessageL: Text;

          AccesTokenL: Text;
          SharepointSetupL: Record "SharePoint Setup";

          SiteIDL: Text[250];
          DocumentsToSharepointL: Codeunit DocumentsToSharepoint;

          ResponseTextL: Text;
          JsonObjectL: JsonObject;
      begin

          SharepointSetupL.get;

          SiteIDL := SharepointSetupL."SiteID 1";




          case SharepointSetupL.DocumentsLanguage of
              1://ENG
                  URL := 'https://graph.microsoft.com/v1.0/sites/' + SiteIDL + '/lists/Documents/columns';
              2://GER
                  URL := 'https://graph.microsoft.com/v1.0/sites/' + SiteIDL + '/lists/Dokumente/columns';
              else
                  exit(false)
          end;

          AccesTokenL := DocumentsToSharepointL.GetToken();

          JsonPayload.WriteTo(JsonText);

          ContentL.WriteFrom(JsonText);
          ContentL.GetHeaders(ContentHeaderL);
          ContentHeaderL.Clear();
          ContentHeaderL.Add('Content-type', 'application/json');

          RequestL.Content(ContentL);
          RequestL.SetRequestUri(URL);
          RequestL.Method('POST');

          HttpClientL.DefaultRequestHeaders.add('Authorization', 'Bearer ' + AccesTokenL);
          if not HttpClientL.Send(RequestL, ResponseMessageL) then begin
              exit(false);
          end;

          if not ResponseMessageL.IsSuccessStatusCode then begin
              exit(false);
          end else begin
              ResponseMessageL.Content.Readas(ResponseTextL);
              JsonObjectL.ReadFrom(ResponseTextL);
              ActualColumnNameR := GetJsonToken(JsonObjectL, 'name').AsValue().AsText();
          end;
          exit(true);

      end;
      */

    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then Error('Could not find a token with key %1', TokenKey);
    end;


    procedure SetSPDocumentsLanguage(): Integer;
    var
        SharepointSetupL: Record "SharePoint Setup";
        UrlL: Text;
    begin
        SharepointSetupL.Get();
        //ENG:
        UrlL := 'https://graph.microsoft.com/v1.0/sites/' + SharepointSetupL."SiteID 1" + '/lists/Documents/columns';
        if TryGetSharepointDocuments(UrlL) then
            Exit(1);
        //GER:
        UrlL := 'https://graph.microsoft.com/v1.0/sites/' + SharepointSetupL."SiteID 1" + '/lists/Dokumente/columns';
        if TryGetSharepointDocuments(UrlL) then
            Exit(2);
        //ELSE
        EXIT(99);
    end;

    local procedure TryGetSharepointDocuments(UrlV: Text): boolean
    var

        // DocumentsToSharepointL: Codeunit DocumentsToSharepoint;
        ContentL: HttpContent;
        ContentHeaderL: HttpHeaders;
        RequestL: HttpRequestMessage;
        ResponseMessageL: HttpResponseMessage;
        HttpClientL: HttpClient;
        AccesTokenL: Text;
    begin
        AccesTokenL := GetToken();

        /* ContentL.GetHeaders(ContentHeaderL);
         ContentHeaderL.Clear();
         ContentHeaderL.Add('Content-type', 'application/json');

         RequestL.Content(ContentL);
         */
        RequestL.SetRequestUri(UrlV);
        RequestL.Method('GET');

        HttpClientL.DefaultRequestHeaders.add('Authorization', 'Bearer ' + AccesTokenL);
        if not HttpClientL.Send(RequestL, ResponseMessageL) then begin
            exit(false);
        end;

        if not ResponseMessageL.IsSuccessStatusCode then begin
            exit(false);
        end;
        exit(true);

    end;



    procedure CreateColumnJson(ColumnnameV: Text[100]; DateFieldV: Boolean): JsonObject
    var
        JsonObjectL: JsonObject;
        JsonObject2L: JsonObject;
        JsonArrayL: JsonArray;
        JsonTextL: Text;
        SharePointSetupL: Record "SharePoint Setup";
    begin
        //Text Column
        SharePointSetupL.Get();

        if NOT DateFieldV then begin
            JsonObject2L.Add('allowMultipleLines', false);
            JsonObject2L.Add('appendChangesToExistingText', false);
            JsonObject2L.Add('linesForEditing', 0);
            JsonObject2L.Add('maxLength', 255);

            JsonObjectL.Add('columnGroup', 'NC365 Sharepoint Connect');
            JsonObjectL.Add('displayName', ColumnnameV);
            JsonObjectL.Add('enforceUniqueValues', false);
            JsonObjectL.Add('hidden', false);
            JsonObjectL.Add('indexed', false);
            JsonObjectL.Add('name', ColumnnameV);
            JsonObjectL.Add('readOnly', false);
            JsonObjectL.Add('required', false);
            JsonObjectL.Add('text', JsonObject2L);
        end else begin

            //Date column
            JsonObject2L.Add('displayAs', 'standard');
            JsonObject2L.Add('format', 'dateOnly');

            JsonObjectL.Add('columnGroup', 'NC365 Sharepoint Connect');
            JsonObjectL.Add('displayName', ColumnnameV);
            JsonObjectL.Add('enforceUniqueValues', false);
            JsonObjectL.Add('hidden', false);
            JsonObjectL.Add('indexed', false);
            JsonObjectL.Add('name', ColumnnameV);
            JsonObjectL.Add('readOnly', false);
            JsonObjectL.Add('required', false);
            JsonObjectL.Add('dateTime', JsonObject2L);

        end;
        exit(JsonObjectL)
    end;


    procedure GetToken(): Text;
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
}
