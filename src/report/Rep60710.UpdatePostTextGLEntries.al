report 60710 "UpdatePostTextGLEntries"
{
    Caption = 'Update Posting Text GL Entries';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData 17 = rimd;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            trigger OnPreDataItem()
            var
            begin
                SetRange("Posting Date", 20210801D, 20211231D);
            end;

            trigger OnAfterGetRecord()
            var
                ExtPos: Integer;
                PostText: Text[100];
            begin
                if "External Document No." <> '' then begin
                    ExtPos := StrPos(Description, ' Ext.');
                    if ExtPos = 0 then begin
                        Description := Description + ' Ext. ' + "External Document No.";
                        Modify();
                    end;
                end;
            end;
        }
        dataitem("Sales Header"; "Sales Header")
        {
            trigger OnPreDataItem()
            var
            begin
                SetRange("Posting Date", 20210801D, 20211231D);
            end;

            trigger OnAfterGetRecord()
            var
                ExtPos: Integer;
                PostText: Text[100];
            begin
                if "External Document No." <> '' then begin
                    ExtPos := StrPos("Posting Description", ' Ext.');
                    if ExtPos = 0 then begin
                        "Posting Description" := "Posting Description" + ' Ext. ' + "External Document No.";
                        Modify();
                    end;
                end;
            end;
            /*
            var
                ExtPos: Integer;
                PostText: Text[100];

            begin
                ExtPos := StrPos("Posting Description", ' Ext.');
                if ExtPos > 0 then
                    "Posting Description" := DelStr("Posting Description", ExtPos);
                "Posting Description" := "Posting Description" + ' Ext. ' + "External Document No.";
                Modify();
            end;
            */
        }

    }

    var

}