page 60703 "Magazine Type Setup"
{
    Caption = 'Magazin Typ Einrichtung';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Magazine Type";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(Magazin; "Magazine Type Picture")
            {
                ApplicationArea = All;
                Caption = 'Logo';
                SubPageLink = code = field(Code);
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(ImportMultipleItemPictures_promoted; ImportMultipleItemPictures)
            {

            }
            actionref(DeletePicture_promoted; DeletePicture)
            {

            }
        }

        area(Processing)
        {

            fileuploadaction(ImportMultipleItemPictures)
            {
                ApplicationArea = All;
                Caption = 'Logo hochladen';
                Image = Import;
                AllowMultipleFiles = false;

                trigger OnAction(files: List of [FileUpload])
                var
                    CurrentFile: FileUpload;
                    InStr: InStream;
                    FileName: Text;
                    FileMgt: Codeunit "File Management";
                    MagazineTypeL: Record "Magazine Type";
                begin
                    FileName := '';
                    foreach CurrentFile in Files do begin
                        CurrentFile.CreateInStream(InStr, TextEncoding::MSDos);
                        FileName := FileMgt.GetFileNameWithoutExtension(CurrentFile.FileName);
                        if MagazineTypeL.Get(Rec.Code) then begin
                            Clear(MagazineTypeL.Picture);
                            MagazineTypeL.Picture.ImportStream(InStr, 'Logo hochladen für Magazintyp: ' + Format(MagazineTypeL.Code));
                            MagazineTypeL."Has Picture" := true;
                            MagazineTypeL.Modify(true);
                        end;
                    end;
                end;
            }

            action(DeletePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Logo löschen';
                Image = Delete;

                trigger OnAction()
                begin
                    Clear(Rec.Picture);
                    REc."Has Picture" := false;
                    Rec.Modify(true);
                end;
            }
        }
    }



}