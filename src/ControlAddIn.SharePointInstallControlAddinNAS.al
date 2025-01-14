controladdin "SharePointInstall_ControlAddin_NAS"
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
    // StartupScript = 'Addin/Scripts/Adminconsent.js';
    Scripts = 'https://code.jquery.com/jquery-3.2.1.min.js',
    'Addin/Scripts/Adminconsent.js',
    'https://secure.aadcdn.microsoftonline-p.com/lib/0.2.3/js/msal.js';
    Images = 'Addin/images/NC365_l.png';
    StyleSheets = 'Addin/Styles/bootstrap-treeview.css',
    'Addin/Styles/index.css',
    'https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css';
    event getLang();

    procedure gotLang(Lang: Integer; URL: Text[250]);
}