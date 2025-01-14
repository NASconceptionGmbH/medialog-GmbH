tableextension 60713 "Standard Sales Code" extends "Standard Sales Code"
{
    fields
    {
        field(60700; "Automate Sales Order"; Boolean)
        {
            Caption = 'Automate Sales Order';
            DataClassification = ToBeClassified;
        }
        field(60701; "Magazine Type"; Code[20])
        {
            TableRelation = "Magazine Type";
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                StandardCustomerSalesCodeL: Record "Standard Customer Sales Code";
            begin
                StandardCustomerSalesCodeL.SetRange(Code, Code);
                If StandardCustomerSalesCodeL.FindSet() then
                    repeat
                        StandardCustomerSalesCodeL."Magazine Type" := "Magazine Type";
                        StandardCustomerSalesCodeL.Modify();
                    until StandardCustomerSalesCodeL.Next() = 0;
            end;
        }
        field(60702; "Salesperson Code"; code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Verkäufer';
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                StandardCustomerSalesCodeL: Record "Standard Customer Sales Code";
                SalespersonPurchaserL: Record "Salesperson/Purchaser";
            begin

                StandardCustomerSalesCodeL.SetRange(Code, Code);
                If StandardCustomerSalesCodeL.FindSet() then
                    repeat
                        StandardCustomerSalesCodeL."Salesperson Code" := "Salesperson Code";
                        IF SalespersonPurchaserL.Get("Salesperson Code") then
                            StandardCustomerSalesCodeL.Commission := Commission
                        else
                            StandardCustomerSalesCodeL.Commission := 0;
                        StandardCustomerSalesCodeL.Modify();
                    until StandardCustomerSalesCodeL.Next() = 0;
            end;
        }
        field(60703; "Commission"; Decimal)
        {
            Caption = 'Provision';
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                StandardCustomerSalesCodeL: Record "Standard Customer Sales Code";
                SalespersonPurchaserL: Record "Salesperson/Purchaser";
            begin

                StandardCustomerSalesCodeL.SetRange(Code, Code);
                If StandardCustomerSalesCodeL.FindSet() then
                    repeat
                        StandardCustomerSalesCodeL.Commission := Commission;
                        StandardCustomerSalesCodeL.Modify();
                    until StandardCustomerSalesCodeL.Next() = 0;
            end;
        }
        field(60704; "Salesperson Code 2"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Verkäufer 2';
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                StandardCustomerSalesCodeL: Record "Standard Customer Sales Code";
                SalespersonPurchaserL: Record "Salesperson/Purchaser";
            begin

                StandardCustomerSalesCodeL.SetRange(Code, Code);
                If StandardCustomerSalesCodeL.FindSet() then
                    repeat
                        StandardCustomerSalesCodeL."Salesperson Code" := "Salesperson Code";
                        IF SalespersonPurchaserL.Get("Salesperson Code 2") then
                            StandardCustomerSalesCodeL."Commission 2" := "Commission 2"
                        else
                            StandardCustomerSalesCodeL."Commission 2" := 0;
                        StandardCustomerSalesCodeL.Modify();
                    until StandardCustomerSalesCodeL.Next() = 0;
            end;
        }
        field(60705; "Commission 2"; Decimal)
        {
            Caption = 'Provision 2';
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                StandardCustomerSalesCodeL: Record "Standard Customer Sales Code";
                SalespersonPurchaserL: Record "Salesperson/Purchaser";
            begin

                StandardCustomerSalesCodeL.SetRange(Code, Code);
                If StandardCustomerSalesCodeL.FindSet() then
                    repeat
                        StandardCustomerSalesCodeL."Commission 2" := "Commission 2";
                        StandardCustomerSalesCodeL.Modify();
                    until StandardCustomerSalesCodeL.Next() = 0;
            end;
        }
        field(60706; "Global Dimension 1 Code"; Code[20]) // CR-920
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            var
                StandardCustomerSalesCodeL: Record "Standard Customer Sales Code";
            begin
                StandardCustomerSalesCodeL.SetRange(Code, Code);
                If StandardCustomerSalesCodeL.FindSet() then
                    repeat
                        StandardCustomerSalesCodeL."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        StandardCustomerSalesCodeL.Modify();
                    until StandardCustomerSalesCodeL.Next() = 0;
            end;
        }
        field(60707; "First Item No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Standard Sales Line"."No." where("Standard Sales Code" = field(Code)));
        }
        field(60708; "Line Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Standard Sales Line".Description where("Standard Sales Code" = field(Code)));
        }
        field(60710; "Unit Price"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Standard Sales Line"."Unit Price" where("Standard Sales Code" = field(Code)));
        }
        field(60711; "Line Discount %"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Standard Sales Line"."Line Discount %" where("Standard Sales Code" = field(Code)));
        }
        field(60712; "Customer No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Standard Customer Sales Code"."Customer No." where(Code = field(Code)));
        }
    }
}
