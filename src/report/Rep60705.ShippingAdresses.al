Report 60705 "Shipping Adresses"
{
	WordLayout = '.\Layouts\Shipping Adresses.docx'; DefaultLayout = Word;

	dataset
	{
		dataitem(Header;"Sales Invoice Header")
		{
			RequestFilterFields = "No.","Order No.";
			column(ReportForNavId_2; 2) {} // Autogenerated by ForNav - Do not delete
			column(ReportForNav_Header; ReportForNavWriteDataItem('Header',Header)) {}
			dataitem(ShippingAddresses;"Shipping Addresses")
			{
				DataItemLinkReference = Header;
				DataItemLink = "Sales Order No." = FIELD("Order No.");
				DataItemTableView = sorting("Line No.");
				column(ReportForNavId_3; 3) {} // Autogenerated by ForNav - Do not delete
				column(ReportForNav_ShippingAddresses; ReportForNavWriteDataItem('ShippingAddresses',ShippingAddresses)) {}
				dataitem("Country/Region";"Country/Region")
				{
					DataItemLinkReference = ShippingAddresses;
					DataItemLink = Code=field("Country/Region");
					column(ReportForNavId_4; 4) {} // Autogenerated by ForNav - Do not delete
					column(ReportForNav_Country_Region; ReportForNavWriteDataItem('Country_Region',"Country/Region")) {}
					trigger OnPreDataItem();
					begin
						ReportForNav.OnPreDataItem('Country_Region',"Country/Region");
					end;
					
				}
				trigger OnPreDataItem();
				begin
					ReportForNav.OnPreDataItem('ShippingAddresses',ShippingAddresses);
				end;
				
			}
			trigger OnPreDataItem();
			begin
				ReportForNav.OnPreDataItem('Header',Header);
			end;
			
		}
	}

	requestpage
	{

		SaveValues = false;	  layout
		{
			area(content)
			{
				group(Options)
				{
					Caption = 'Options';
					field(ForNavOpenDesigner;ReportForNavOpenDesigner)
					{
						ApplicationArea = Basic;
						Caption = 'Design';
						Visible = ReportForNavAllowDesign;
						trigger OnValidate()
						begin
							ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
							CurrReport.RequestOptionsPage.Close();
						end;

					}
				}
			}
		}

		actions
		{
		}
		trigger OnOpenPage()
		begin
			ReportForNavOpenDesigner := false;
		end;
	}

	trigger OnInitReport()
	begin
		;ReportsForNavInit;

	end;

	trigger OnPostReport()
	begin







	end;

	trigger OnPreReport()
	begin
		;ReportsForNavPre;
	end;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var
		ReportForNavInitialized : Boolean;
		ReportForNavShowOutput : Boolean;
		ReportForNavTotalsCausedBy : Integer;
		ReportForNavOpenDesigner : Boolean;
		[InDataSet]
		ReportForNavAllowDesign : Boolean;
		ReportForNav : Codeunit "ForNAV Report Management";

	local procedure ReportsForNavInit() var id: Integer; begin Evaluate(id, CopyStr(CurrReport.ObjectId(false), StrPos(CurrReport.ObjectId(false), ' ') + 1)); ReportForNav.OnInit(id, ReportForNavAllowDesign); end;
	local procedure ReportsForNavPre() begin if ReportForNav.LaunchDesigner(ReportForNavOpenDesigner) then CurrReport.Quit(); end;
	local procedure ReportForNavSetTotalsCausedBy(value : Integer) begin ReportForNavTotalsCausedBy := value; end;
	local procedure ReportForNavSetShowOutput(value : Boolean) begin ReportForNavShowOutput := value; end;
	local procedure ReportForNavInit(jsonObject : JsonObject) begin ReportForNav.Init(jsonObject, CurrReport.ObjectId); end;
	local procedure ReportForNavWriteDataItem(dataItemId: Text; rec : Variant) : Text
	var
		values: Text;
		jsonObject: JsonObject;
		currLanguage: Integer;
	begin
		if not ReportForNavInitialized then begin
			ReportForNavInit(jsonObject);
			ReportForNavInitialized := true;
		end;

		case (dataItemId) of
			'Header':
				begin
					currLanguage := GlobalLanguage; GlobalLanguage := 1033; jsonObject.Add('DataItem$Header$CurrentKey$Text',Header.CurrentKey); GlobalLanguage := currLanguage;
				end;
			'Country_Region':
				begin
					currLanguage := GlobalLanguage; GlobalLanguage := 1033; jsonObject.Add('DataItem$Country_Region$CurrentKey$Text',"Country/Region".CurrentKey); GlobalLanguage := currLanguage;
				end;
		end;
		ReportForNav.AddDataItemValues(jsonObject,dataItemId,rec);
		jsonObject.WriteTo(values);
		exit(values);
	end;
	// Reports ForNAV Autogenerated code - do not delete or modify -->
}
