reportextension 60702 "CC Shipment" extends "CC Sales - Shipment"
{
    dataset
    {
        add("Sales Shipment Header")
        {
            column(DocSendText; DocSendText)
            {
            }
        }
        modify("Sales Shipment Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                Cust: Record Customer;
                DocSendProfile: Record "Document Sending Profile";
            begin
                DocSendText := '';
                if Cust.get("Sales Shipment Header"."Sell-to Customer No.") then
                    if DocSendProfile.get(Cust."Document Sending Profile") then
                        DocSendText := DocSendProfile.Description;
            end;
        }
    }
    requestpage
    {
        // Add changes to the requestpage here
    }
    var
        DocSendText: Text[100];
}