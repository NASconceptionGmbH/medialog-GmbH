codeunit 60708 "ExcelIssueFunctions"
{
    trigger OnRun()
    begin
        UpdateIssues()
    end;

    local procedure UpdateIssues()
    var
        ItemL: Record Item;
        IssueAdL: Record "Issue Ad";
    begin
        ItemL.SetRange("Marked for Update IssueList", true);
        if ItemL.FindSet() then
            repeat
                IssueAdL.SetRange("Item No.", ItemL."No.");
                if IssueAdL.Count > 0 then
                    ExportExcelIssueList(ItemL."No.")
                else begin
                    itemL."Marked for Update IssueList" := false;
                    itemL.Modify();
                end;
            until ItemL.next() = 0;
    end;

    procedure ExportExcelIssueList(ItemNoV: Code[20])
    var
        ExcelBufferL: Record "Excel Buffer" temporary;
        SharePointSetupL: Record "SharePoint Setup";
        FileNameL: text;
        TempBlobL: Codeunit "Temp Blob";
        OutStreamL: OutStream;
        InstreamL: InStream;
        URL: Text;
        SiteIDL: Text;
        ItemL: Record Item;
        YearL: Integer;
        MagType: Text[50];
        MagazineType: Record "Magazine Type";

        SharePointAddinCodeUnit_NASL: Codeunit SharePointAddinCodeUnit_NAS;

    begin
        if ItemL.Get(ItemNoV) then begin
            if ItemL."Publication Date" <> 0D then
                YearL := Date2DMY(ItemL."Publication Date", 3)
            else
                YearL := 0;
            if MagazineType.Get(ItemL."Magazine Type") then
                MagType := MagazineType.Description
            else
                Magtype := 'NoType';


            SharePointSetupL.Get();
            FileNameL := 'Dispoliste ' + ItemNoV + '.xlsx';
            SiteIDL := SharePointSetupL."SiteID 1";
            //CurrentContact += MagType + "/" + (Year != 0 ? Year + "/"  : ""  ) + CurrentContactGUID ;
            URL := 'https://graph.microsoft.com/v1.0/sites/' + SiteIDL + '/drive/items/root:/' + SharePointSetupL.HighestFolder + '/' + SharePointSetupL.SalesLine + '/' + MagType + '/' + format(YearL) + '/' + ItemNoV + '/' + FileNameL;


            FillExcelBuffer(ItemNoV, ExcelBufferL, false);

            // if not ExcelBufferL.IsEmpty then begin
            TempBlobL.CreateOutStream(OutStreamL);
            ExcelBufferL.SaveToStream(OutStreamL, true);
            TempBlobL.CreateInStream(InstreamL);

            if SendFileToSharepoint(InstreamL, FileNameL, URL + ':/content') then begin
                ItemL."Marked for Update IssueList" := false;
                ItemL.ItemDescriptionUploaded := false;
                ItemL.Modify();

                if NOT ItemL.ItemDescriptionUploaded then
                    SharePointAddinCodeUnit_NASL.UpdateItemDescriptionInSharepoint(ItemL."No.");
            end;
            // end;
        end
    end;




    procedure DownloadExcelBufferFile(ItemNoV: Code[20])
    var
        TempBlobL: Codeunit "Temp Blob";
        OutstreamL: OutStream;
        InstreamL: InStream;
        FileNameL: Text;
        ExcelBufferL: Record "Excel Buffer" temporary;
    begin
        FillExcelBuffer(ItemNoV, ExcelBufferL, false);

        TempBlobL.CreateOutStream(OutStreamL);
        ExcelBufferL.SaveToStream(OutStreamL, true);
        TempBlobL.CreateInStream(InstreamL);
        FileNameL := 'Dispoliste ' + ItemNoV + '.xlsx';
        DownloadFromStream(InstreamL, '', 'Export', 'All Files (*.*)|*.*', FileNameL);
    end;

    local procedure FillExcelBuffer(ItemNoV: Code[20]; var ExcelBufferR: Record "Excel Buffer" temporary; ExportCustomerInfos: Boolean)
    var
        IssueAdL: Record "Issue Ad";
        TempBlobL: Codeunit "Temp Blob";
        InstreamL: InStream;
        OutstreamL: OutStream;
        FileNameL: Text;
        CustomerL: Record Customer;
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
    begin
        if ExportCustomerInfos then begin
            IssueAdL.SetRange("Item No.", ItemNoV);
            if IssueAdL.FindSet() then begin
                ExcelBufferR.CreateNewBook('Debitorinformationen');
                ExcelBufferR.NewRow();
                ExcelBufferR.AddColumn('Verkauf an Debitor Nr.', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkauf an Name', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkauf an Name 2', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkauf an Adresse', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkauf an Adresse 2', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkauf an Ort', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkauf an PLZ', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkauf an Länder-/Regionscode', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkauf an Mail', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkauf an Kontakt', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);

                ExcelBufferR.AddColumn('Lief. an Debitor Nr.', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Lief. an Name', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Lief. an Name 2', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Lief. an Adresse', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Lief. an Adresse 2', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Lief. an Ort', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Lief. an PLZ', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Lief. an Länder-/Regionscode', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Lief. an Mail', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Lief. an Kontakt', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                repeat
                    if SalesInvoiceHeaderL.Get(IssueAdL."Invoice No.") then begin
                        ExcelBufferR.NewRow();
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Sell-To Customer No.", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Sell-to Customer Name", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Sell-to Customer Name 2", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Sell-to Address", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Sell-to Address 2", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Sell-to City", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Sell-to Post Code", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Sell-to Country/Region Code", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Sell-to E-Mail", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Sell-to Contact", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);

                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Ship-To Customer No.", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Ship-to Name", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Ship-to Name 2", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Ship-to Address", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Ship-to Address 2", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Ship-to City", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Ship-to Post Code", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Ship-to Country/Region Code", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        if CustomerL.get(SalesInvoiceHeaderL."Ship-To Customer No.") then
                            ExcelBufferR.AddColumn(CustomerL."E-Mail", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text)
                        else
                            ExcelBufferR.AddColumn('', false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                        ExcelBufferR.AddColumn(SalesInvoiceHeaderL."Ship-to Contact", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    end;
                until IssueAdL.Next() = 0;


                ExcelBufferR.WriteSheet('Debitorinformationen', CompanyName, UserId);
                ExcelBufferR.CloseBook();
            end;
        end else begin
            IssueAdL.SetRange("Item No.", ItemNoV);
            if IssueAdL.FindSet() then begin
                ExcelBufferR.CreateNewBook('Dispoliste');
                ExcelBufferR.NewRow();
                ExcelBufferR.AddColumn('Variante', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Status', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkauf an Debitor Nr.', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkauf an Debitorname', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Rechnung an Debitor Nr.', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Rechnung an Debitor Name.', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Lieferung an Debitor Nr.', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Lieferung an Debitor Nname.', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkäufercode', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Sachbearbeiter', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Format', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Motiv', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Platzierung', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Druckunterlagen', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Anzeigen Schlussdatum', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkaufspreis', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Zeilenbetrag ohne MwSt.', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Bestätigungsdatum', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Erstellungsdatum', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Buchungsdatum', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Rechnungsnummer', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Verkaufsauftragnummer', false, '', true, false, true, '', ExcelBufferR."Cell Type"::Text);
                ExcelBufferR.AddColumn('Startdatum', false, '', false, false, false, '', ExcelBufferR."Cell Type"::Date);
                ExcelBufferR.AddColumn('Enddatum', false, '', false, false, false, '', ExcelBufferR."Cell Type"::Date);
                repeat
                    ExcelBufferR.NewRow();
                    ExcelBufferR.AddColumn(IssueAdL."Variant Code", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL.Status, false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL."Sell-to Customer No.", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    IssueAdL.CalcFields("Sell-to Customer Name");
                    ExcelBufferR.AddColumn(IssueAdL."Sell-to Customer Name", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL."Bill-to Customer No.", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    if NOT CustomerL.Get(IssueAdL."Bill-to Customer No.") then clear(CustomerL);
                    ExcelBufferR.AddColumn(CustomerL.Name, false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL."Ship-to Customer No.", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    Clear(CustomerL);
                    if NOT CustomerL.Get(IssueAdL."Ship-to Customer No.") then Clear(CustomerL);
                    ExcelBufferR.AddColumn(CustomerL.Name, false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL."Sales Person Code", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL.Clerk, false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL.Format, false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL.Motive, false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL.Placement, false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL."Print Documents", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL."Print Documents Enddate", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Date);
                    ExcelBufferR.AddColumn(IssueAdL."Unit Price", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Number);
                    ExcelBufferR.AddColumn(IssueAdL."Line Amount Excl. VAT", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Number);
                    ExcelBufferR.AddColumn(IssueAdL."Confirmation Date", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Date);
                    ExcelBufferR.AddColumn(IssueAdL."Created Date", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Date);
                    ExcelBufferR.AddColumn(IssueAdL."Invoice Date", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Date);
                    ExcelBufferR.AddColumn(IssueAdL."Invoice No.", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL."Sales Order No.", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Text);
                    ExcelBufferR.AddColumn(IssueAdL."Start Date", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Date);
                    ExcelBufferR.AddColumn(IssueAdL."End Date", false, '', false, false, false, '', ExcelBufferR."Cell Type"::Date);
                until IssueAdL.Next() = 0;

                ExcelBufferR.WriteSheet('Dispoliste', CompanyName, UserId);
                ExcelBufferR.CloseBook();
            end;
        end
    end;




    local procedure SendFileToSharepoint(var InstreamR: InStream; FileNameV: Text[250]; UrlV: Text): Boolean
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

        InstallationSharePointCU_NAS: Codeunit InstallationSharePointCU_NAS;
    begin
        AccesTokenL := InstallationSharePointCU_NAS.GetToken();

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
            if GuiAllowed then
                Message('call to webservice failed');
            exit(false);
        end;

        if not ResponseMessageL.IsSuccessStatusCode then begin
            ResponseMessageL.Content.ReadAs(ReturnMessageL);
            if GuiAllowed then
                Message(ReturnMessageL);
            exit(false);
        end;
        exit(true);
    end;



    procedure DownloadCustomerInformations(ItemNoV: Code[20])
    var
        TempBlobL: Codeunit "Temp Blob";
        OutstreamL: OutStream;
        InstreamL: InStream;
        FileNameL: Text;
        ExcelBufferL: Record "Excel Buffer" temporary;
    begin
        FillExcelBuffer(ItemNoV, ExcelBufferL, true);

        TempBlobL.CreateOutStream(OutStreamL);
        ExcelBufferL.SaveToStream(OutStreamL, true);
        TempBlobL.CreateInStream(InstreamL);
        FileNameL := 'Debitorinformationen ' + ItemNoV + '.xlsx';
        DownloadFromStream(InstreamL, '', 'Export', 'All Files (*.*)|*.*', FileNameL);
    end;

}