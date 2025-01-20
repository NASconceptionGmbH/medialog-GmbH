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
                field(Picture; Rec.Picture)
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
            }
        }
    }
    actions
    {

        area(Processing)
        {

            fileuploadaction(ImportMultipleItemPictures)
            {
                ApplicationArea = All;
                Caption = 'Import Multiple Item Pictures';
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
                            MagazineTypeL.Picture.ImportStream(InStr, 'Upload Item for Magazin Type: ' + Format(MagazineTypeL.Description));
                            MagazineTypeL."Has Picture" := true;
                            MagazineTypeL.Modify(true);
                        end;
                    end;
                end;
            }

            action(DeletePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delete';
                Image = Delete;
                ToolTip = 'Delete the record.';

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