page 60704 "Install Sharepoint Connect"
{
    PageType = NavigatePage;
    SourceTable = "SharePoint Setup";
    // ApplicationArea = All;
    // UsageCategory = Administration;
    Caption = 'Install NC365 SharePoint Connect';
    layout
    {
        area(Content)
        {
            group("Step1")
            {
                Visible = CurrentStep = 1;
                group("Welcome")
                {
                    InstructionalText = 'Enter Sharepoint sitename', comment = 'DEU="Sharepoint Seitennamen angeben"';
                    field("SiteID 1"; Rec."SiteID 1")
                    {
                        ApplicationArea = All;
                        Caption = 'Sitename', comment = 'DEU="Seitenname 1"';
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            Rec.InBearbeitung := true;
                        end;
                    }
                    field(TenantID; Rec.TenantID)
                    {
                        ApplicationArea = All;
                        Caption = 'Tenant ID';
                        trigger OnValidate()
                        begin
                            Rec.Modify();
                        end;
                    }
                }
            }
            group("Step2")
            {
                Visible = CurrentStep = 2;
                group("CreateLinks")
                {
                    Caption = 'App options', comment = 'DEU="App Optionen"';
                    InstructionalText = 'Create sharepoint links';

                    field("CreateLink"; Rec."CreateLinkEnabled")
                    {
                        ApplicationArea = All;
                        Caption = 'Create links';
                        ToolTip = 'If disabled, clicking on files will only download them. If possible however, it will show the item within the Browser';
                    }
                }
                group("MaximalTiefe")
                {
                    Caption = 'Max. folderdepth', comment = 'DEU="maximale Ordnertiefe"';
                    InstructionalText = 'How many subfolders are shown within each folder';
                    field("MaxTiefe"; Rec."MaximalTiefe")
                    {
                        ApplicationArea = All;
                        Caption = 'Subfolders';
                        ToolTip = 'The more depth you choose, the longer the loading time. Not a Problem if you dont have dozen of folders within each contact.';
                    }
                }
                /* group("Columnames")
                 {
                     Caption = 'Sharepoint Columnames', comment = 'DEU="Sharepoint Spaltennamen"';
                     InstructionalText = 'Define the names of the Sharepointlist columns';
                     field(ColumnDocumentNo; ColumnDocumentNo)
                     {
                         ApplicationArea = All;
                     }
                     field(ColumnDocumenttype; ColumnDocumenttype)
                     {
                         ApplicationArea = All;
                     }
                     field(ColumnContactNo; ColumnContactNo)
                     {
                         ApplicationArea = all;
                     }
                     field(ColumnContactName; ColumnContactName)
                     {
                         ApplicationArea = all;
                     }
                     field(ColumnDateName; ColumnDateName)
                     {
                         ApplicationArea = All;
                     }
                 }*/
            }
            /* group("Step3")
             {
                 Visible = CurrentStep = 3;
                 group("EnableDocuments")
                 {
                     Caption = 'Document Types', comment = 'DEU="Dokumententypen"';
                     InstructionalText = 'Choose which Document Types you want to enable for NC365 Sharepoint Connect';
                     part(DocumentTypes; SharepointPages)
                     {
                         Caption = 'Pages & Documents available for Sharepoint exports';
                         ApplicationArea = All;
                     }
                 }
             }*/
            group("Step3")
            {
                Visible = CurrentStep = 3;
                group("Folder")
                {
                    Caption = 'Path', comment = 'DEU="Pfad"';
                    visible = true;
                    InstructionalText = '"Path/.../MyFolder" - OR - Leave it empty = RootFolder of the Site';
                    field("HighestFolder"; Rec."HighestFolder")
                    {
                        ApplicationArea = All;
                        Caption = 'Root folder';
                        ToolTip = 'Path within your Site. In this folder, I will create the three subfolders, but this one here has to exist';

                        trigger OnValidate()
                        begin
                            Rec.InBearbeitung := true;
                        end;
                    }
                }
                /* group("AutoExport")
                 {
                     Caption = 'Auto Export Documents';
                     field(AutoSaveDocuments; AutoSaveDocuments)
                     {
                         ApplicationArea = all;
                         ToolTip = 'Enable this if you want to automatically export documents to Sharepoint when processing a report.';
                         trigger OnValidate()
                         begin
                             InBearbeitung := true;
                         end;
                     }
                     field(EnableCustomDocumentSelec; EnableCustomDocumentSelec)
                     {
                         ApplicationArea = all;
                         ToolTip = 'Enable this if you want to choose custom document types for Drag&Drop file Uploads';
                         trigger OnValidate()
                         begin
                             InBearbeitung := true;
                         end;
                     }
                 }*/
                group("UploadTo")
                {
                    Caption = 'Upload into', comment = 'DEU="Hochladen in"';
                    InstructionalText = 'Each document group will obtain a folder in the Sharepoints root directory. Set their names in the following';

                    field(ItemIssue; Rec.SalesLine)
                    {
                        Caption = 'Sales Line Folder:';
                        ApplicationArea = All;
                        ShowMandatory = true;

                        trigger OnValidate()
                        begin
                            Rec.InBearbeitung := true;
                        end;
                    }
                }
            }
            group("Step4")
            {
                Visible = CurrentStep = 4;
                group("Adminconsent")
                {
                    Caption = 'Permissions', comment = 'DEU="Zugriffsrechte"';
                    InstructionalText = 'Did you give the App all required permissions? Click on the Button to do so.', comment = 'DEU="Button klicken um Business Central die Rechte von Sharepoint zuzuweisen."';
                    field("adminrechte"; "Adminrechte")
                    {
                        ApplicationArea = All;
                        Caption = 'Permissions are set', comment = 'DEU="Rechte sind erteilt"';
                        trigger OnValidate()
                        begin
                            SetControls();
                        end;
                    }
                    usercontrol(SharePointInstall; SharePointInstall_ControlAddin_NAS)
                    {
                        ApplicationArea = All;
                        trigger getLang()
                        begin
                            CurrPage.SharePointInstall.gotLang(GlobalLanguage(), 'https://login.microsoftonline.com/common/adminconsent?client_id=9fe85c29-0d4b-4927-a113-ffcb2573a8f2&redirect_uri=');
                        end;
                    }
                }
            }
            group("Step5")
            {
                Visible = CurrentStep = 5;
                group("AllDone")
                {
                    Caption = 'Status';
                    group("SiteStatus")
                    {
                        Visible = true;
                        Caption = '', locked = true;

                        field("SiteIDStatus"; "SiteStatus")
                        {
                            ApplicationArea = All;
                            Editable = false;
                            Caption = 'Site', comment = 'DEU="Seite"';
                        }
                    }

                    group("ItemIssue2")
                    {
                        Visible = true;
                        Caption = '', locked = true;
                        field(Folder1; Folder1)
                        {
                            ApplicationArea = All;
                            Editable = false;
                            Caption = 'Sales Order Line';
                        }
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("GetTenantID")
            {
                ApplicationArea = All;
                Caption = 'Pull Tenant ID', comment = 'DEU="Tenant ID holen"';
                InFooterBar = true;
                Visible = CurrentStep = 1;
                Enabled = CurrentStep = 1;

                trigger OnAction()
                var
                    EnvironmentInformationL: Codeunit "Environment Information";
                    AzureADTenantL: Codeunit "Azure AD Tenant";
                begin
                    if EnvironmentInformationL.IsSaaS() then
                        Rec.TenantID := AzureADTenantL.GetAadTenantId();
                end;
            }
            action("ActionBack")
            {
                ApplicationArea = All;
                Caption = 'Back', comment = 'DEU="Zurück"';
                InFooterBar = true;
                Enabled = ActionBackAllowed;
                trigger OnAction()
                var
                begin
                    TakeStep(-1);
                end;
            }
            action("ActionNext")
            {
                ApplicationArea = All;
                Caption = 'Next', comment = 'DEU="Weiter"';
                InFooterBar = true;
                Enabled = ActionNextAllowed;
                Visible = CurrentStep < 6;
                trigger OnAction()
                var
                    Test: Codeunit InstallationSharePointCU_NAS;
                begin
                    TakeStep(1);
                end;
            }
            action("ActionFinal")
            {
                ApplicationArea = All;
                Caption = 'Close', comment = 'DEU="Schließen"';
                InFooterBar = true;
                Enabled = ActionFinalAllowed;
                Visible = ActionFinalAllowed;
                trigger OnAction()
                var
                begin
                    CurrPage.Close();
                end;
            }
            action("ActionDone")
            {
                ApplicationArea = All;
                Caption = 'Run';
                InFooterBar = true;
                Enabled = ActionDoneAllowed;
                Visible = ActionDoneAllowed;
                trigger OnAction()
                var
                    JsonToken: JsonToken;
                    TokenasNumber: array[1] of Integer; //TODO für Neuen SP Ordner
                    OptionRec: Record "SharePoint Setup";
                    iL: Integer;
                    JsonObjectL: JsonObject;
                    ActualColumnNameL: Text;
                begin
                    if OptionRec.FindFirst() then begin
                        Successfull := false;

                        ResponseCodes := InstallCodeUnit.Connect();


                        if ResponseCodes.Get('Sales Line Folder', JsonToken) then
                            IF Evaluate(TokenasNumber[1], JsonToken.AsValue().AsText()) then
                                Folder1 := CheckStatus(TokenasNumber[1]);


                        ResponseCodes.Get('Site ID', JsonToken);

                        SiteStatus := JsonToken.AsValue().AsText();


                        IF ((TokenasNumber[1] = 201) OR (TokenasNumber[1] = 409)) then begin
                            if OptionRec.FindFirst() then begin
                                OptionRec.InBearbeitung := false;
                                Successfull := true;
                                OptionRec.Modify();
                            end;
                        end;



                        OptionRec.DocumentsLanguage := InstallCodeUnit.SetSPDocumentsLanguage();
                        OptionRec.Modify();

                        TakeStep(1);
                    end;

                end;
            }
        }
    }

    local procedure CheckStatus(StatusCode: Integer) RetText: Text
    var
        Lab400: Label 'Directory settings faulty', comment = 'DEU="Verzeichnis Einstellungen falsch"';
        Lab401: Label 'Tokenproblem - are the permissons configured?', comment = 'DEU="Tokenfehler, Erlaubnis erteilt?"';
        Lab403: Label 'You have not given adminconsent', comment = 'DEU="Keine Adminrechte erteilt"';
        Lab404: Label 'Rootdirectory not found', comment = 'DEU="Wurzelverzeichnis nicht gefunden"';
        Lab408: Label 'Connection Timeout', comment = 'DEU="Verbindungszeitüberschreitung"';
        Lab409: Label 'Found folder', comment = 'DEU="Ordner gefunden"';
        Lab200: Label 'Folder created successfully', comment = 'DEU="Ordner erfolgreich erstellt"';
        Lab201: Label 'Folder created successfully', comment = 'DEU="Ordner erfolgreich erstellt"';
        LabElse: Label 'Unknown Error: ', comment = 'DEU="unbekannter Fehler"';
    begin
        case StatusCode of
            400:
                RetText := Lab400;
            401:
                RetText := Lab401;
            403:
                RetText := Lab403;
            404:
                RetText := Lab404;
            408:
                RetText := Lab408;
            409:
                RetText := Lab409;
            200:
                RetText := Lab200;
            201:
                RetText := Lab201;
            else
                RetText := LabElse + FORMAT(StatusCode);
        end;
        Exit(RetText);
    end;



    local procedure SetControls()
    var
        OptionRec: Record "SharePoint Setup";
    begin
        ActionBackAllowed := CurrentStep > 1;
        ActionNextAllowed := CurrentStep < 4;
        ActionDoneAllowed := false;
        if (CurrentStep = 4) AND OptionRec.FindFirst() then
            if (OptionRec.MaximalTiefe >= 0) AND NOT (OptionRec."SiteID 1" = '') AND (Adminrechte = true) then begin
                ActionDoneAllowed := true;
            end;
        ActionFinalAllowed := (CurrentStep = 5) AND Successfull;

    end;

    local procedure TakeStep(Step: Integer)
    begin
        CurrentStep += Step;
        SetControls;
    end;

    trigger OnOpenPage()
    var
        OptionRec: Record "SharePoint Setup";
    begin

        CurrentStep := 0;
        TakeStep(1);
        if NOT OptionRec.FindFirst() Then begin
            OptionRec.Init();
            OptionRec.Insert();
        end;
    end;


    var
        Successfull: Boolean;
        Folder1: Text;//TODO für neuen SP Ordner

        SiteStatus: Text;
        ResponseCodes: JsonObject;
        CurrentStep: Integer;
        ActionBackAllowed: Boolean;
        ActionNextAllowed: Boolean;
        ActionDoneAllowed: Boolean;
        ActionFinalAllowed: Boolean;
        Adminrechte: Boolean;
        InstallCodeUnit: Codeunit InstallationSharePointCU_NAS;
}