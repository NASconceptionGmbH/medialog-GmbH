page 60705 "Sharepoint Connect VV"
{
    PageType = CardPart;
    SourceTable = "Item";
    layout
    {
        area(content)
        {
            usercontrol(NavAddin_NAS; SharePoint_ControlAddin_NAS)
            {
                ApplicationArea = All;
                trigger OnControlReady();
                var
                begin
                    Loaded := true;
                    Gogo();
                end;

                trigger GiveMeAToken(URL: Text);
                var

                    LicenceState: Integer;
                begin
                    LicenceState := 2;
                    CurrPage.NavAddin_NAS.GotToken(SharePointCodeUnit.Connect(URL), LicenceState);
                end;

                /*    trigger OnBeforeUploadFile()
                    begin

                        Rec.TestField("Variant Code");
                    end;
    */

                trigger OnAfterDragAndUpload(Path: Text; Filename: Text; Position: Text)
                var
                    SharePointAddinCodeUnit_NASL: Codeunit SharePointAddinCodeUnit_NAS;
                begin
                    if NOT Rec.ItemDescriptionUploaded then
                        SharePointAddinCodeUnit_NASL.UpdateItemDescriptionInSharepoint(Rec."No.");
                end;

            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        if Loaded then
            Gogo();
    end;

    trigger OnInit();
    begin
        Loaded := false;
    end;

    var
        SharePointCodeUnit: Codeunit SharePointAddinCodeUnit_NAS;
        Loaded: Boolean;
        DocumentType: Text[50];

    procedure Gogo()
    var
        YearL: Integer;
        MagType: Text[50];
        MagazineType: Record "Magazine Type";
    begin
        if Rec.FindFirst() then begin
            if Rec."Publication Date" <> 0D then
                YearL := Date2DMY(Rec."Publication Date", 3)
            else
                YearL := 0;
            if MagazineType.Get(Rec."Magazine Type") then
                MagType := MagazineType.Description
            else
                Magtype := 'NoType';

            CurrPage.NavAddin_NAS.GetFolderName(Rec."No.", Rec."No.", '0', SharePointCodeUnit.GetOptions(), GlobalLanguage(), MagType, YearL); //TODO getoptions param
        end;
    end;
}