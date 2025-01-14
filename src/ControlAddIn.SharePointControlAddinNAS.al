controladdin "SharePoint_ControlAddin_NAS"
{
    RequestedHeight = 200;
    MinimumHeight = 200;
    MaximumHeight = 700;
    RequestedWidth = 335;
    MinimumWidth = 300;
    MaximumWidth = 600;
    VerticalStretch = true;
    VerticalShrink = false;
    HorizontalStretch = true;
    HorizontalShrink = false;
    StartupScript = 'Addin/Scripts/startup.js';
    Scripts = 'Addin/Scripts/Dependencies/dropzone.js',
    'Addin/Scripts/Dependencies/bootstrap-treeview.js',
    'Addin/Scripts/DropToSharePoint.js',
    'https://code.jquery.com/jquery-3.2.1.min.js',
    'https://cdnjs.cloudflare.com/ajax/libs/bluebird/3.3.4/bluebird.min.js',
    'https://secure.aadcdn.microsoftonline-p.com/lib/0.2.3/js/msal.js';
    Images = 'Addin/images/NC365_l.png';
    StyleSheets = 'Addin/Styles/bootstrap-treeview.css',
    'Addin/Styles/dropzone.css',
    'Addin/Styles/index.css',
    'https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css';


    event OnControlReady();
    event GiveMeAToken(URL: Text);

    event OnAfterDragAndUpload(Path: Text; Filename: Text; Position: Text)

    // event FileAmountOnAfterGet(FileAmount: integer)
    // event OnBeforeUploadFile();
    //procedure SetVariantEmpty(VariantEmpty: boolean)

    procedure GetFolderName(ID: Text; Name: Text; Origin: Code[2]; jObject: JsonObject; Lang: Integer; MagType: Text; Year: integer);
    procedure GotToken(JObject: JsonObject; LicenceState: Integer);
}