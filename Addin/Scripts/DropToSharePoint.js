// --Einstellbare--//

var HighestFolder;
var SiteID;
var TenantID;
var MaximaleTiefe;
var CreateLinkEnabled;
var Vendor;
var Debitor;
var Contact;
var Item;

//-- Dynamische--//

var labels = {};
var Root;
var disableInteraction = true;
var LicenceStatus = 2;

var GetDatas = 0;

var fileamount = 0;
var fehleramout = 0;
var fehlerfiles = [];
var currentString;

var CurrentFolderChoice;
var CurrentFolderChoiceTotal;
var ChangeFolderTo;

var CurrentContactName = "";
var CurrentContactGUID = "";
var CurrentContactPosition;
var CurrentContact = "";
var topdropzone;

var UploadInFolder;
var CurrentAccessToken;
var Response;

var BackgroundColorOrdner = "#6C90A6";
var ColorOrdnertiefe = "#ff6666";
var NodeOrFolder;

var AktuellesQuerry;
var AktuelleRechte;

var Folders = [];
var Files = [];
var Tree = [];
var StatusEinsicht;
var gettingFile = false;


var Filename;
var DoneBlobFile;
var Alle = [];

var CreateFAnimation = 500;

var TreeViewInstance;

var FileLength;

var EmptyVariant = true;

// ---------- Document Rdy ------------//
$(document).ready(function () {
    UploadInFolder = HighestFolder;
    Dropzone.autoDiscover = false;
});
async function InitializeDropingScript() {
    var iframe = window.frameElement;
    iframe.parentElement.style.display = 'flex';
    iframe.parentElement.style.flexDirection = 'colum';
    iframe.parentElement.style.flexGrow = '1';
    iframe.style.removeProperty('max-height');
    iframe.style.flexGrow = '1';
    iframe.style.flexShrink = '1';
    iframe.style.flexBasis = 'auto';
    iframe.style.height = '550px';
    await createElement("App", "controlAddIn", "div", null, null);
    window.addEventListener("drop", function (e) {
        e = e || event;
        e.preventDefault();
    }, false);
    window.addEventListener("dragover", function (e) {
        e = e || event;
        e.preventDefault();
    }, false)
    await createElement("LogoAndDiv", "App", "div", null, null);
    createElement("drop", "LogoAndDiv", "div", { onclick: "GoToSharePoint()" }, null);
    topdropzone = $("div#drop").dropzone({
        url: "www.google.de",
        dictDefaultMessage: "Drag files in here",
        createImageThumbnails: false,
        autoProcessQueue: false,
        maxFiles: 10,
        clickable: false,
        addedfile: function (file) {
            if (!disableInteraction) {
                this.removeFile(file);
                fileupload(file, Root);
            }
            else {
                this.removeAllFiles();
            }
        }
    });
    await createElement("FolderButtons", "App", "div", null, null);
    createElement("Scrolable", "App", "div", null, null);
    await createElement("InfoDiv", "App", "div", null, null);
    setTimeout(async function () {
        createElement("LoadingText", "InfoDiv", "pre", { class: "unhidd" }, "...");
        StatusEinsicht = document.getElementById("LoadingText");
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnControlReady', null);
        $("#App").on("SelectFolder", function () {
            var InOrdner = document.getElementById("preNewFolder");
            if (InOrdner) {
                InOrdner.innerText = CurrentFolderChoice;
            }
        });
    }, 2100);
}
async function CreateSubFolder() {
    if (LicenceStatus >= 2) {
        CurrentFolderChoiceTotal = UploadInFolder;
        ControlAddInHeightChange(false);
    } else if (LicenceStatus == 1)
        Status(labels.Licence2req, true);
    else if (LicenceStatus == 0)
        Status(labels.LicenceAt0, true);
}
async function ControlAddInHeightChange(remove, StillNotInRoot = false) {
    var iframe = window.frameElement;
    if (!remove) {
        iframe.style.height = '680px';
        removeElement("CreateSubFolder");
        createElement("divNewFolder", "App", "div", { "class": "unhidd" }, labels.FolderPath);
        setTimeout(function () {
            createElement("preNewFolder", "divNewFolder", "pre", null, "Root");
            createElement("inputNewFolder", "divNewFolder", "input", {
                value: labels.Foldername
            }, null);
            createElement("SubmitNewFolder", "divNewFolder", "button", {
                class: "NewFolder",
                onclick: "SubmitSubFolder()"
            }, labels.Create);
            createElement("AbortNewFolder", "divNewFolder", "button", {
                class: "NewFolder",
                onclick: "AbortSubFolder()"
            }, labels.abort);
            document.getElementById("Scrolable").setAttribute("max-height", 200);
        }, CreateFAnimation);
        var div = document.getElementById("Scrolable");
        var Indiv = document.getElementById("InfoDiv");
        var newFdiv = document.getElementById("divNewFolder");
        Indiv.classList.add("godown");
        div.classList.add("godown");
    } else if (remove) {
        var newF = document.getElementById("divNewFolder");
        if (newF) {
            newF.classList.remove("unhidd");
            newF.classList.add("hidd");
            var div = document.getElementById("Scrolable");
            var Indiv = document.getElementById("InfoDiv");
            div.classList.add("goUp");
            Indiv.classList.add("goUp");
            setTimeout(function () {
                iframe.style.height = '550px';
                removeElement("divNewFolder");
                div.classList.remove("godown");
                Indiv.classList.remove("godown");
                div.classList.remove("goUp");
                Indiv.classList.remove("goUp");
            }, CreateFAnimation);
        }
        if (!StillNotInRoot) removeElement("BacktoRoot");
        removeElement("CreateSubFolder");
        removeElement("CreateFolder");
    }
}
async function SubmitSubFolder() {
    var Ordnername = document.getElementById("inputNewFolder");
    if (Ordnername) {
        if (CurrentFolderChoiceTotal != null)
            UploadInFolder = CurrentFolderChoiceTotal;
        $.when(CreateFolder(Ordnername.value)).then(function () {
            ControlAddInHeightChange(true);
        }, function () {
            ControlAddInHeightChange(false);
        });
    }
}
async function AbortSubFolder() {
    ControlAddInHeightChange(true, true);
    createElement("CreateSubFolder", "FolderButtons", "button", { onclick: "CreateSubFolder()", class: "FolderCreating" }, "Erstelle Ordner");
}
function OpenNewWindow(URL) {
    window.open(URL);
}
async function removeElement(ElementID) {
    var Element = document.getElementById(ElementID);
    if (Element) {
        var HTMLElement = document.getElementById(ElementID);
        HTMLElement.parentNode.removeChild(HTMLElement);
    }
}
async function createElement(ElementID, ElementParentID, ElementTag, ElementAttr, InnerText) {
    var Prom = jQuery.Deferred();
    var ParentElement = document.getElementById(ElementParentID);
    if (ParentElement && !document.getElementById(ElementID)) {
        var NewElement = document.createElement(ElementTag);
        NewElement.setAttribute('id', ElementID);
        if (ElementAttr != null)
            Object.keys(ElementAttr).forEach(function (key) {
                NewElement.setAttribute(key, ElementAttr[key]);
            });
        if (InnerText != null)
            NewElement.appendChild(document.createTextNode(InnerText));
        ParentElement.appendChild(NewElement);
        Prom.resolve(NewElement);
    }
    else {
        Prom.reject();
    }
    return Prom.promise();

}
async function WriteLabels(Lang) {
    labels = {};
    switch (Lang) {
        case 1031: { //DE-DE
            labels.CreateFolder = "Erstelle Ordner";
            labels.AppNotInstalled = "Sie müssen die App erst installieren";
            labels.FolderNotThere = "Order noch nicht vorhanden";
            labels.Ready = "Bereit";
            labels.Loading = "Lade neu";
            labels.InFolder = "In Ordner";
            labels.InFolderfor = "In Ordner für ";
            labels.insert = " einfügen";
            labels.FilesToUpload = "Daten empfangen: ";
            labels.FilesLeft = " Dateien übrig";
            labels.LastFile = "Letzte Datei: ";
            labels.RegExpired = "Anmeldung abgelaufen";
            labels.logginIn = "Verbinde mich mit SharePoint...";
            labels.FolderCreated = "Ordner erstellt, aktualisiere...";
            labels.FolderCFailed = "Konnte Ordner nicht erstellen, Fehlercode: ";
            labels.RootF = "Root Verzeichnis";
            labels.Folder = "Ordner: ";
            labels.Reloading = "aktualisiere...";
            labels.Retry = "Versuche es erneut";
            labels.CLink = "Erstelle Link...";
            labels.FLink = "Konnte Link nicht erstellen";
            labels.FData = "Bei folgenden Dateien traten Fehler auf:";
            labels.ErrorC = "Fehlercode: ";
            labels.ReturnMe = "Ignorieren";
            labels.ErrorMostCommon = "Die häufigsten Fehler beim Upload: ";
            labels.Error409 = "<b>409</b>: Eine Datei mit dem selben Namen wird gleichzeitig hochgeladen oder bearbeitet";
            labels.Error413 = "<b>413</b>: Datei zu groß, die max. Größe ist 4 MB";
            labels.Error429 = "<b>429</b>: Zu viel Datenverkehr auf der SharePoint Seite";
            labels.Error500 = "<b>500</b>: SharePoint Error, Serverseitig";
            labels.ErrorHtml = "Für mehr Infos, hier klicken";
            labels.Licence2req = "Funktion bei der Trial-Version deaktiviert";
            labels.LicenceAt0 = "Ihre Lizenz ist abgelaufen.";
            labels.Foldername = "Ordnername";
            labels.Create = "Erstellen";
            labels.abort = "Abbrechen";
            labels.FolderPath = "Ordner Pfad:";
            labels.FolderCFolderExists = "Ordner existiert bereits";
            break;
        }
        case 1033: //EN-US
        case 2057: //EN-UK
        default:
            //BUTTONS
            labels.CreateFolder = "Create Folder";
            // Statusfeld
            labels.AppNotInstalled = "App is not fully configured";
            labels.FolderNotThere = "Folder not yet created";
            labels.Ready = "Ready";
            labels.Loading = "Loading";
            labels.InFolder = "Insert into folder";
            labels.InFolderfor = "Insert into ";
            labels.insert = "";
            labels.FilesToUpload = "Files received: ";
            labels.FilesLeft = " files left to upload";
            labels.LastFile = "Last file was: ";
            labels.RegExpired = "Registration expired";
            labels.logginIn = "Connection to SharePoint";
            labels.FolderCreated = "Folder created, reloading...";
            labels.FolderCFailed = "Couldn't create folder, code: ";
            labels.RootF = "Root folder";
            labels.Folder = "Folder: ";
            labels.Reloading = "reloading...";
            labels.Retry = "Retry";
            labels.CLink = "Creating Link...";
            labels.FLink = "Couldn't create link";
            labels.FData = "The following files run into errors:";
            labels.ErrorC = "Error code: ";
            labels.ReturnMe = "Ignore";
            labels.ErrorMostCommon = "Most common Errors: ";
            labels.Error409 = "<b>409</b>: The file has been changed on the server side, while uploading it. <br> Most likely you are uploading the same file(-name) multiple times";
            labels.Error413 = "<b>413</b>: The file is to big, max. 4 MB";
            labels.Error429 = "<b>429</b>: Your SharePoint has too many connections at once";
            labels.Error500 = "<b>500</b>: SharePoint-sided server-error";
            labels.ErrorHtml = "For more information, click here";
            labels.Licence2req = "Disabled in the Trial Version";
            labels.LicenceAt0 = "Your Licence has run out";
            labels.Foldername = "Foldername";
            labels.Create = "Create";
            labels.abort = "Abort";
            labels.FolderPath = "Folderpath: "
            labels.FolderCFolderExists = "Folder already exists";
            break;
    }
}
async function GetFolderName(ID, Name, Position, Settings, Lang,MagType,Year) { // ICH SUCHE IMMER DAS HIER
    ChangeFolderTo = null;
    WriteLabels(Lang);
    if (Settings.failed == null) {
        TenantID = Settings.TenantID;
        SiteID = Settings.SiteID;
        if (Settings.HighestFolder != "")
            HighestFolder = "/" + Settings.HighestFolder;
        else
            HighestFolder = "";
        MaximaleTiefe = Settings.MaximalTiefe;
        CreateLinkEnabled = Settings.CreateLinkEnabled;
        CurrentContact = "";
        CurrentContactName = Name.replace(/[^a-zA-Z0-9üäÜÄß _-]/g, '');
        CurrentContactGUID = ID;
        if (CurrentContactPosition == null) {
            switch (Position) { //TODO erweitern

                case "0":
                    CurrentContactPosition = Settings.SalesLine;
                    break;
                default:
                    break;
            }
        }

       // EmptyVariant = EmptyVariantL;
        HighestFolder += "/" + CurrentContactPosition;
        UploadInFolder = HighestFolder + "/";
        if (CurrentContactName != null && CurrentContactName != "" && CurrentContactName != " ") {
            //CurrentContact += CurrentContactGUID + " " + CurrentContactName.trim();
            //   if (MultiOrdner == true)
            //      CurrentContact += CurrentContactName.trim() + "/" + CurrentContactGUID
            //else
           // CurrentContact += CurrentContactGUID + "/" + CurrentContactName + " " + VariantCode.trim();
           CurrentContact += MagType + "/" + (Year != 0 ? Year + "/"  : ""  ) + CurrentContactGUID ;
        }
        else
            CurrentContact += CurrentContactGUID;

           

        UploadInFolder += CurrentContact;
        Root = UploadInFolder;
        if (document.getElementById("Scrolable")) {
            ControlAddInHeightChange(true);
            if (CurrentAccessToken == null) {
                disableInteraction = true;
                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('GiveMeAToken', ['https://login.microsoftonline.com/' + TenantID + '/oauth2/token']);
            }
            else if (!gettingFile) {
                GetNewData();
                disableInteraction = false;
            }
        }

    } else {
        Status(Settings.failed, true);
        disableInteraction = true;
    }
}
async function CreateFolder(Folder) {
    var ret = jQuery.Deferred();
    if (Folder == null) {
        // UploadInFolder += "/" + CurrentContact;
        var FolderData = '{ "name" : "' + CurrentContact + '", "folder" : { }, "@microsoft.graph.conflictBehavior": "fail"}';
        AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/items/root:" + HighestFolder + ":/children";
    }
    else {
        Folder = Folder.replace(/[^a-zA-Z0-9üäöÜÄßÖ _-]/g, '');
        var FolderData = '{ "name" : "' + Folder + '", "folder" : { }, "@microsoft.graph.conflictBehavior": "fail"}';
        AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/items/root:" + UploadInFolder + ":/children";
    }
    $.when(QueryPOST((FolderData), "POST")).always(function () {
    }).done(function () {
        removeElement("CreateFolder");
        UploadInFolder = HighestFolder + "/" + CurrentContact;
        if (ChangeFolderTo != null) {
            UploadInFolder += ChangeFolderTo;
        }
        // console.log(ChangeFolderTo);
        GetNewData();
        Status(labels.FolderCreated, false);
        ret.resolve();
    }).fail(function (e) {
        switch (e) {
            case 409:
                Status(labels.FolderCFolderExists, true);
                break;
            default:
                // console.log(AktuellesQuerry);
                Status(labels.FolderCFailed + e, true);
                break;
        }
        ret.reject();
    });
    return ret.promise();

}
async function CreateFolderThenSub() {
    if (LicenceStatus >= 2) {
        $.when(CreateFolder()).done(function () {
            CreateSubFolder();
        }).fail(null);
    } else if (LicenceStatus == 1)
        Status(labels.Licence2req, true);
    else if (LicenceStatus == 0)
        Status(labels.LicenceAt0, true);


}
// ----------------------------------
async function GotToken(JToken, LicenceState = 0) {
    var Prom = jQuery.Deferred();
    if (JToken.access_token != null) {
        CurrentAccessToken = JToken.access_token;
        disableInteraction = false;
    }
    GetNewData();
    LicenceStatus = LicenceState;
    Prom.resolve(CurrentAccessToken);
    return Prom.promise();
}

//TTU
function QueryPOST(file, Todo) {
    var prm = jQuery.Deferred();
    var parameter = [];
    if (Todo == "GET") {
        parameter = {

            beforeSend: function (request) {
                request.setRequestHeader("Authorization", 'Bearer ' + CurrentAccessToken);
            },
            method: Todo,
            async: true,
            url: encodeURI(AktuellesQuerry)
        };
    }
    else if (Todo == "PUT") {
        parameter = {
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", 'Bearer ' + CurrentAccessToken);
                request.setRequestHeader("Content-Type", "application/json");
                request.setRequestHeader("name", Filename);
                request.setRequestHeader("Content-Encoding", "base64");
            },
            method: Todo,
            async: true,
            url: encodeURI(AktuellesQuerry),
            data: file,
            processData: false,
        }
    }
    else if (Todo == "POST") {
        parameter = {
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", 'Bearer ' + CurrentAccessToken);
                request.setRequestHeader("Content-Type", "application/json");
            },
            method: Todo,
            async: true,
            url: encodeURI(AktuellesQuerry),
            data: file,
            processData: false,
        }
    }
    else if (Todo == "CREATESESSION") {
        parameter = {
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", 'Bearer ' + CurrentAccessToken);
                request.setRequestHeader("Content-Type", "application/json");
                request.setRequestHeader("name", Filename);
            },
            method: "POST",
            async: true,
            url: encodeURI(AktuellesQuerry),
            //data: file,
            processData: false,
        }
    }//UPLOADBIGFILE
    else if (Todo == "UPLOADBIGFILE") {
        parameter = {
            beforeSend: function (request) {
                // request.setRequestHeader("Content-Type", 'application/pdf');
                request.setRequestHeader("Content-Length", FileLength);
                request.setRequestHeader("Content-Range", "bytes 0-" + (FileLength - 1) + "/" + FileLength);
            },
            method: "PUT",
            async: true,
            url: AktuellesQuerry,
            data: file,
            processData: false,
        }
    }
    $.ajax(parameter).done(function (data, textStatus, jqXHR) {
        var bisher = data.value;
        if (typeof (data["@odata.nextLink"]) != "undefined") {
            AktuellesQuerry = decodeURI(data["@odata.nextLink"]);
            $.when(QueryPOST(null, "GET")).done(function (a, b, ret) {
                bisher.push.apply(bisher, ret);
                Response = bisher;
                prm.resolve(textStatus, data, bisher);
            }).fail(null);
        } else {
            Response = bisher;
            prm.resolve(textStatus, data, bisher);
        }
    }).fail(function (jqXHR) {
        prm.reject(jqXHR.status, jqXHR);
    });
    return prm.promise();
}
//---------------------------------------
async function GetNewData() {
    GetDatas++;
    removeElement("previews");
    createElement("LoadingText", "InfoDiv", "pre", null, null);
    removeElement("CreateFolder");
    removeElement("CreateSubFolder");
    StatusEinsicht = document.getElementById("LoadingText");
    Status(labels.Loading);
    if (UploadInFolder != "")
        AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/root:/" + UploadInFolder + ":/children/";
    else
        AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/root/children/";
    Files = [];
    // console.log(AktuellesQuerry);
    $.when(QueryPOST(null, "GET", null)).done(function (retString) {
        // console.log("GetDatas: " + GetDatas);
        if (!gettingFile && GetDatas <= 1) {
            createElement("previews", "Scrolable", "div", null, null);
            removeElement("Fehler");
            for (var i = 0; i < Response.length; i++) {
                Files.push({ File: Response[i] });
            }
            FillinTable();
            if (LicenceStatus >= 1)
                createElement("CreateSubFolder", "FolderButtons", "button", { onclick: "CreateSubFolder()", class: "FolderCreating" }, labels.CreateFolder);
            else
                Statuslabels(LicenceAt0, true);
        }
    }).fail(function (retString) {
        if (!gettingFile && GetDatas <= 1) {
            if (retString == 404) {
                createElement("CreateFolder", "FolderButtons", "button", { onclick: "CreateFolderThenSub()", class: "FolderCreating" }, labels.CreateFolder);
                createElement("previews", "Scrolable", "div", null, null);
                FillinTable();
                removeElement("Fehler");
            }
            else if (retString == 401) {
                Status(labels.RegExpired, true);
            }
        }
    }).always(function (ret) {
        GetDatas--;
        // Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('FileAmountOnAfterGet', [Files.length]);
    });
}
//---------------------------------------
async function FillinTable() {
    // console.log(AktuellesQuerry);
    Tree = [];
    await FillinTabelleAddon();
    await createTreeView();
    createDropzones();
    if (LicenceStatus >= 1)
        Status(labels.Ready);
    else
        Status(labels.LicenceAt0, true);
    if (UploadInFolder != HighestFolder + "/" + CurrentContact) {
        createElement("BacktoRoot", "FolderButtons", "button", { class: "FolderCreating", onclick: "BacktoRoot()" }, labels.RootF);
    }
    else {
        removeElement("BacktoRoot");
    }
}
//---------------------------------------
async function FillinTabelleAddon() {
    var def = jQuery.Deferred();
    var Ordneranzahl = 0;
    var ThereisaFile = false;
    var FilesSpeicher = Files;
    for (var i = 0; i < FilesSpeicher.length; i++) {
        var Meta;
        if (!CreateLinkEnabled)
            Meta = FilesSpeicher[i].File.webUrl;
        else
            Meta = FilesSpeicher[i].File.id;

        if (FilesSpeicher[i].File.folder != null) {
            Ordneranzahl++;
            var TB = await Fillinnodes(null, FilesSpeicher[i].File);

            Tree.push({ text: FilesSpeicher[i].File.name, nodes: TB, backColor: BackgroundColorOrdner });
            Ordneranzahl--;
            if (Ordneranzahl == 0) {
                def.resolve();
            }
        } else {
            Tree.push({ text: FilesSpeicher[i].File.name, custom: Meta });
            ThereisaFile = true;
        }
    };
    if (Ordneranzahl == 0) {
        if (!ThereisaFile) {
            if (CurrentContactName != null && CurrentContactName != "") {
                Tree.push({ text: labels.InFolderfor + CurrentContactName + labels.insert });
            }
            else
                Tree.push({ text: labels.InFolder + labels.insert });
        }
        def.resolve();
    }
    return def.promise();
}
//--------------------------------
async function Fillinnodes(Querrybisher, Node, DoQuerry = true) {
    if (DoQuerry) {
        if (Querrybisher == null) {
            AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/root:/" + UploadInFolder + "/" + Node.name + ":/children/";
            Querrybisher = "";
        } else
            AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/root:/" + UploadInFolder + "/" + Querrybisher + Node.name + ":/children/";
        Querrybisher += Node.name + "/";

        await QueryPOST(null, "GET", null);
    }
    var res = Response;
    var tempArray = [];
    var pro = jQuery.Deferred();
    var das = await FillinnodesAddon(res, tempArray, Querrybisher, Node);
    pro.resolve(das);
    return pro.promise();
}
//---------------------------------------
async function FillinnodesAddon(res, tempArray, Querrybisher, Node) {
    var kk = jQuery.Deferred();
    var Fileslength = res.length;
    var isThereaFile = false;
    for (var i = 0; i < Fileslength && !isThereaFile; i++) {
        if (typeof (res[i].folder) == "undefined") isThereaFile = true;
    }
    if (typeof (res[0]) == "undefined") {
        tempArray.push({ text: labels.InFolder + " " + Node.name + labels.insert });
    }
    for (var i = 0; i < res.length; i++) {
        var Meta;
        if (!CreateLinkEnabled)
            Meta = res[i].webUrl;
        else
            Meta = res[i].id;
        if (res[i].folder != null) {
            if (MaximaleTiefe > 0) {
                if (Querrybisher != "")
                    Status(labels.Folder + Querrybisher);
                else
                    Status(labels.Folder + "root/");
                MaximaleTiefe--;
                var lookup = await Fillinnodes(Querrybisher, res[i]);
                MaximaleTiefe++;
                tempArray.push({ text: res[i].name, nodes: lookup, backColor: BackgroundColorOrdner });
            } else {
                tempArray.push({ text: res[i].name, color: ColorOrdnertiefe, backColor: BackgroundColorOrdner });
            }
            Fileslength--;
            if (Fileslength == 0) {
                kk.resolve(tempArray);
            }
        } else {
            Fileslength--;
            tempArray.push({ text: res[i].name, custom: Meta });
        }
    }
    if (Fileslength == 0) {
        kk.resolve(tempArray);
    }
    return kk.promise();
}
//---------------------------------------
async function createDropzones() {
    var ExpandedNodes;
    var AllNodes;
    try {
        ExpandedNodes = TreeViewInstance.treeview(true).getExpanded()
        AllNodes = TreeViewInstance.treeview(true).getEnabled().filter(obj => {
            if (obj.parentId == null || ExpandedNodes.some(expanded => expanded.nodeId === obj.parentId)) {
                return obj;
            }
        });

        var Blub = 1;
        Alle = TreeViewInstance.treeview(true).getEnabled();
        await createDropzoneshasNodes(AllNodes);
    } catch (error) {
        // console.log("ERROR");
    }
}
async function createDropzoneshasNodes(Obj) {
    var fertig = jQuery.Deferred();
    var NochZuMachen = 0;
    for (var i = 0; i < Obj.length; i++) {
        NochZuMachen++;
        var string = UploadInFolder + await createDropzonesGetPathString(Obj[i]);
        if (Obj[i].nodes != null) {
            $.when(createDropzonesCreateLink(string, Obj[i])).done(function (dropArray) { //Create Zone
                NochZuMachen--;
                if (NochZuMachen == 0)
                    fertig.resolve(string, dropArray);
            });
        }
        else {
            $.when(createDropzonesCreateLink(string, Obj[i])).done(function (dropArray) { ////Create Zone
                NochZuMachen--;
                if (NochZuMachen == 0)
                    fertig.resolve(string, dropArray);
            });

        }
    };

    return fertig.promise();
}
// --------------------------------------
async function createDropzonesGetPathString(Obj) {
    var fertig = jQuery.Deferred();
    var retString = "";
    var ArrayofObj = [];
    ArrayofObj.push(Obj);
    if (ArrayofObj[0].parentId != null) {
        var dasElement = await Alle.filter(element => {
            if (element.nodeId == ArrayofObj[0].parentId) {
                return element;
            }
        });
        $.when(createDropzonesGetPathString(dasElement[0])).done(function (antwort) {
            retString = antwort;
            if (ArrayofObj[0].nodes != null || ArrayofObj[0].color == ColorOrdnertiefe) {
                retString += "/" + ArrayofObj[0].text;
            }
            fertig.resolve(retString);
        });
    } else {
        if (ArrayofObj[0].nodes != null)
            retString = "/" + ArrayofObj[0].text;
        fertig.resolve(retString);
    }
    return fertig.promise();
}
//---------------------------------------
async function createDropzonesCreateLink(string, Obj) {
    var fertig = jQuery.Deferred();
    var element = await document.querySelectorAll("[data-nodeid='" + Obj.nodeId + "'");
    if (element) {
        var ret = new Dropzone("[data-nodeid='" + Obj.nodeId + "'", {
            url: "www.google.de",
            dictDefaultMessage: "Drag files in here",
            createImageThumbnails: false,
            autoProcessQueue: false,
            maxFiles: 10,
            clickable: false,
            addedfile: function (file) {
                this.removeFile(file);
                fileupload(file, string);
            }
        });

    }
    fertig.resolve(ret);
    return fertig.promise();
}
async function fileupload(file, string) {
 //   Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnBeforeUploadFile');
   // if (!EmptyVariant) {
        if (!disableInteraction && LicenceStatus >= 1) {
            ControlAddInHeightChange(true);
            fileamount++;
            Status(labels.FilesToUpload + fileamount);
            gettingFile = true;
            var GetBuffer = getFileBuffer(file);
            GetBuffer.done(function (arrayBuffer) {
                FileLength = file.size;
                DoneBlobFile = arrayBuffer;
                if (string != "")
                    if (UploadInFolder == "" || null) {
                        AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/items/root" + ":" + string + "/" + file.name + ":/content";
                    }
                    else {
                        AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/items/root" + ":" + string + "/" + file.name + ":/content";
                    }
                else
                    AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/items/root" + ":/" + file.name + ":/content";

                console.log(FileLength);


                if (FileLength > 3145728) {
                    AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/items/root" + ":" + string + "/" + file.name + ":/createUploadSession";
                    $.when(QueryPOST(DoneBlobFile, "CREATESESSION")).done(function (a, b, c) {
                        if (a = "success") {
                            AktuellesQuerry = b.uploadUrl;
                            $.when(QueryPOST(DoneBlobFile, "UPLOADBIGFILE")).done(function (a, b, c) {
                            }).fail(function (e, i) {
                                currentString = string;

                                // fileamount--;
                                if (fehleramout == 0) {
                                    removeElement("previews");
                                    createElement("Fehler", "InfoDiv", "pre", null, null);
                                    var tempo = document.getElementById("Fehler");
                                    tempo.innerHTML = labels.ErrorMostCommon + "<br>";
                                    tempo.innerHTML += labels.Error409 + "<br>";
                                    tempo.innerHTML += labels.Error413 + "<br>";
                                    tempo.innerHTML += labels.Error429 + "<br>";
                                    tempo.innerHTML += labels.Error500 + "<br>";
                                    tempo.innerHTML += "<ins id='TESTING'>" + labels.ErrorHtml + "</ins><br><br>";
                                    tempo.innerHTML += labels.FData;
                                }
                                fehleramout++;
                                fehlerfiles.push(file);
                                document.getElementById("Fehler").innerHTML += "<br>" + file.fullPath + "<br>" + labels.ErrorC + e;
                            }).always(function () {
                                fileamount--;
                                Status(fileamount + labels.FilesLeft);
                                StatusEinsicht.innerHTML += "<br>";
                                StatusEinsicht.innerText += labels.LastFile + file.upload.filename;
                                if (fileamount == 0 && fehleramout != 0) {
                                    createElement("Retry", "InfoDiv", "button", { "onclick": "ProbiereErneut()", "class": "Errors" }, labels.Retry);
                                    createElement("Return", "InfoDiv", "button", { "onclick": "Return()", "class": "Errors" }, labels.ReturnMe);
                                    removeElement("LoadingText");
                                    disableInteraction = true;
                                }
                                if (fileamount == 0 && fehleramout == 0) {
                                    Status(labels.Ready);
                                    GetNewData();
                                    gettingFile = false;
                                     Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnAfterDragAndUpload', [string, file.name, CurrentContactPosition]);
                                }
                            });
                        }
                    })
                } else {

                    //MCL
                    $.when(QueryPOST(DoneBlobFile, "PUT")).fail(function (e, i) {
                        currentString = string;

                        // fileamount--;
                        if (fehleramout == 0) {
                            removeElement("previews");
                            createElement("Fehler", "InfoDiv", "pre", null, null);
                            var tempo = document.getElementById("Fehler");
                            tempo.innerHTML = labels.ErrorMostCommon + "<br>";
                            tempo.innerHTML += labels.Error409 + "<br>";
                            tempo.innerHTML += labels.Error413 + "<br>";
                            tempo.innerHTML += labels.Error429 + "<br>";
                            tempo.innerHTML += labels.Error500 + "<br>";
                            tempo.innerHTML += "<ins id='TESTING'>" + labels.ErrorHtml + "</ins><br><br>";
                            tempo.innerHTML += labels.FData;
                        }
                        fehleramout++;
                        fehlerfiles.push(file);
                        document.getElementById("Fehler").innerHTML += "<br>" + file.fullPath + "<br>" + labels.ErrorC + e;
                    }).always(function () {
                        fileamount--;
                        Status(fileamount + labels.FilesLeft);
                        StatusEinsicht.innerHTML += "<br>";
                        StatusEinsicht.innerText += labels.LastFile + file.upload.filename;
                        if (fileamount == 0 && fehleramout != 0) {
                            createElement("Retry", "InfoDiv", "button", { "onclick": "ProbiereErneut()", "class": "Errors" }, labels.Retry);
                            createElement("Return", "InfoDiv", "button", { "onclick": "Return()", "class": "Errors" }, labels.ReturnMe);
                            removeElement("LoadingText");
                            disableInteraction = true;
                        }
                        if (fileamount == 0 && fehleramout == 0) {
                            Status(labels.Ready);
                            GetNewData();
                            gettingFile = false;
                            //  Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnAfterDragAndUpload', [string, file.name, CurrentContactPosition]);
                        }
                    });
                }
            });
        } else if (LicenceStatus == 0) {
            Status(labels.LicenceAt0, true);
        }
    //}
}
async function Return() {
    disableInteraction = false;
    fehleramout = 0;
    fehlerfiles = [];
    removeElement("Fehler");
    removeElement("Retry");
    removeElement("Return");
    fileamount = 0;
    GetNewData();
    gettingFile = false;
}
async function ProbiereErneut() {
    disableInteraction = false;
    fehleramout = 0;
    createElement("LoadingText", "InfoDiv", "pre", null, null);
    StatusEinsicht = document.getElementById("LoadingText");
    removeElement("Fehler");
    removeElement("Retry");
    removeElement("Return");
    var ff = fehlerfiles;
    fehlerfiles = [];
    for (var i = 0; i < ff.length; i++) {
        fileupload(ff[i], currentString);
    }
}
//---------------------------------------
function createTreeView() {
    var pro = jQuery.Deferred();

    TreeViewInstance = $('#previews').treeview({
        levels: 1,
        highlightSelected: true,
        showBorder: true,
        multiSelect: false,
        data: Tree,
        onNodeSelected: async function (event, data) {
            setTimeout(function () {
                NodeSelect(data, true);
            }, 0);
        },
        // onNodeUnselected: async function (event, data) {
        //     NodeSelect(data,false);
        // }

    });
    // document.getElementById("previews").setAttribute("ondblclick","dblclicked()");
    // console.log($("#previews"));
    // console.log(document.getElementById("previews"));
    pro.resolve();
    return pro.promise();
}
//---------------------------------------
async function NodeSelect(data, NodeSelect) {
    // document.querySelectorAll("[data-nodeid='" + data.nodeId + "'").setAttribute("ondblclick","dblclicked()");
    // console.log(data);
    NodewasClicked = false;
    // if (NodeSelect) {
    if (typeof (data.nodes) == "undefined") {
        if (data.custom != null) {
            NodewasClicked = true;
            if (LicenceStatus >= 1) {
                if (!CreateLinkEnabled) {
                    OpenNewWindow(data.custom);
                } else {
                    Status(labels.CLink);
                    var jsonObj = '{"type":"view", "scope":"organization"}';
                    AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/items/" + data.custom + "/createLink";
                    $.when(QueryPOST(jsonObj, "POST")).done(function (e, url) {
                        OpenNewWindow(url.link.webUrl);
                        Status(labels.Ready);
                    }).fail(function (e, i) {
                        Status(labels.FLink + e, true);
                    });
                }
            }
        } else if (LicenceStatus == 0)
            Status(labels.LicenceAt0, true);
        if (data.color == "#ff6666") {
            ControlAddInHeightChange(true);
            ChangeFolderTo = await createDropzonesGetPathString(data);
            UploadInFolder += ChangeFolderTo;
            GetNewData();
        }
    }
    else if (data.backColor == "#6C90A6") {
        CurrentFolderChoice = data.text;
        CurrentFolderChoiceTotal = UploadInFolder + await createDropzonesGetPathString(data);
        $("#App").trigger("SelectFolder", CurrentFolderChoiceTotal);
        if (data.state.selected == true) {
            // $('#previews').treeview('expandNode', [data.nodeId, {silent: true}]);
            $('#previews').treeview('toggleNodeExpanded', [data.nodeId, { silent: true }]);
        }
    }
    setTimeout(async function () {
        var element = await document.querySelectorAll("[data-nodeid='" + data.nodeId + "'");
        if (typeof (element[0]) != "undefined")
            $('#previews').treeview('unselectNode', [data.nodeId, { silent: true }]);
        createDropzones(); // Zeichnet die bei jedem Klick neu, leider
    }, 500);
}
async function GoToSharePoint() {
    Status(labels.CLink, false);
    AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/items/root:" + Root + ":/?$filter=startswith(givenName,'Folder')";
    $.when(QueryPOST(null, "GET"))
        .done(function (e, url) {
            OpenNewWindow(url.webUrl);
            Status(labels.Ready, false);
        }).fail(function (e, i) {
            $.when(CreateFolder())
                .done(function () {
                    AktuellesQuerry = "https://graph.microsoft.com/v1.0/sites/" + SiteID + "/drive/items/root:" + Root + ":/?$filter=startswith(givenName,'Folder')";
                    $.when(QueryPOST(null, "GET")).done(function (e, url) {
                        OpenNewWindow(url.webUrl);
                        GetNewData();
                    }).fail(function () {
                        Status(labels.FLink + e, true);
                        console.log(AktuellesQuerry);
                    });
                }).fail(null);
        });
}
function Status(Text, error = false) { // WIP 
    StatusEinsicht.innerText = Text;
    if (error)
        StatusEinsicht.classList.add("ErrorMsg");
    else
        StatusEinsicht.classList.remove("ErrorMsg");

}
function BacktoRoot() {
    UploadInFolder = Root;
    GetNewData();
    removeElement("BacktoRoot");
}
//---------------------------------------
function getFileBuffer(file) {
    Filename = file.name;
    var deferred = jQuery.Deferred();
    var reader = new FileReader();
    reader.onloadend = function (e) {
        deferred.resolve(e.target.result);
    }
    reader.onerror = function (e) {
        deferred.reject(e.target.error);
    }
    reader.readAsArrayBuffer(file);
    return deferred.promise();
}