/**
 * @class Sch.plugin.ExcelExport
 * @extends Object
 * Plugin for exporting grid data to Excel without involving the server. Based on Animals plugin: http://www.extjs.com/forum/showthread.php?t=32400
 */

Ext.define("banggo.util.ExcelDownLoad", {
    
    dateFormat : 'Y-m-d g:i',
    
    title : 'Exported events',
    
    windowTitle : 'Choose fields to Export',
    
    resourceGridHeader : 'Resource fields',
    
    resourcePrefix : 'Resource - ',
    
    eventPrefix : 'Event - ',
    
    eventGridHeader : 'Event fields',
    
    exportToExcel : function() {
        this.showFieldSelectionWindow();
    },
    
    defaultColumnWidth : 100,
    
    showFieldSelectionWindow : function() {
        if (!this.window) {
            var data = [];
            
            Ext.each(this.grid.store.model.prototype.fields.keys, function(field) {
                data.push([this.resourcePrefix + field]);
            }, this);
            
            Ext.each(this.grid.eventStore.model.prototype.fields.keys, function(field) {
                data.push([this.eventPrefix + field]);
            }, this);
            
            var store = new Ext.data.ArrayStore({ fields : ['text'], data : data});

            var selector = new Ext.ux.form.ItemSelector({
                imagePath: 'http://cdn.sencha.io/ext-4.0.2a/examples/ux/images/',
                store: store,
                displayField: 'text',
                valueField: 'text',
                allowBlank: false
            });
           
            this.window = Ext.create("Ext.Window", {
                height : 300,
                width : 400,
                bodyStyle : 'padding:10px;background:#FFF',
                title : this.windowTitle,
                closeAction : 'hide',
                layout : 'fit',
                items : [
                    selector
                ],
                
                buttons : [
                    {
                        text : 'Export',
                        scope : this,
                        handler : function() {
                            var selectedFields = selector.getValue(),
                                resourceFields = [],
                                eventFields = [];
                            
                            Ext.each(selectedFields, function(f) {
                                if (f.match(this.resourcePrefix)) {
                                    resourceFields.push(f.substring(this.resourcePrefix.length));
                                } else {
                                    eventFields.push(f.substring(this.eventPrefix.length));
                                }
                            }, this);
                            
                            if (Ext.isIE) {
                                this.ieToExcel(resourceFields, eventFields);
                            } else {
                                var xml = this.getExcelXml(resourceFields, eventFields);
                                window.location = 'data:application/vnd.ms-excel;base64,' + xml;
                            }
                        }
                    },
                    {
                        text : 'Cancel',
                        handler : function() {
                            this.window.hide();
                        }, 
                        scope : this
                    }
                ]
            });
        }
        
        this.window.show();
    },
    
    /**
    *
    *  Base64 encode / decode
    *  http://www.webtoolkit.info/
    *
    **/
    base64 : function() {

        // private property
        var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

        // private method for UTF-8 encoding
        function utf8Encode(string) {
            string = string.replace(/\r\n/g,"\n");
            var utftext = "";
            for (var n = 0; n < string.length; n++) {
                var c = string.charCodeAt(n);
                if (c < 128) {
                    utftext += String.fromCharCode(c);
                }
                else if((c > 127) && (c < 2048)) {
                    utftext += String.fromCharCode((c >> 6) | 192);
                    utftext += String.fromCharCode((c & 63) | 128);
                }
                else {
                    utftext += String.fromCharCode((c >> 12) | 224);
                    utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                    utftext += String.fromCharCode((c & 63) | 128);
                }
            }
            return utftext;
        }

        // public method for encoding
        return {
            encode : (typeof btoa == 'function') ? function(input) { return btoa(input); } : function (input) {
                var output = "";
                var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
                var i = 0;
                input = utf8Encode(input);
                while (i < input.length) {
                    chr1 = input.charCodeAt(i++);
                    chr2 = input.charCodeAt(i++);
                    chr3 = input.charCodeAt(i++);
                    enc1 = chr1 >> 2;
                    enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
                    enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
                    enc4 = chr3 & 63;
                    if (isNaN(chr2)) {
                        enc3 = enc4 = 64;
                    } else if (isNaN(chr3)) {
                        enc4 = 64;
                    }
                    output = output +
                    keyStr.charAt(enc1) + keyStr.charAt(enc2) +
                    keyStr.charAt(enc3) + keyStr.charAt(enc4);
                }
                return output;
            }
        };
    }(),
    
    init : function(grid) {
        this.grid = grid;
        
         Ext.apply(grid, {
            exportToExcel : Ext.Function.bind(this.exportToExcel, this)
        });
    },
    
    getExcelXml : function(resourceFields, eventFields) {
        var worksheet = this.createWorksheet(resourceFields, eventFields);
        return this.base64.encode('<?xml version="1.0" encoding="utf-8"?>' +
            '<ss:Workbook xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:o="urn:schemas-microsoft-com:office:office">' +
            '<o:DocumentProperties><o:Title>' + (this.title || '') + '</o:Title></o:DocumentProperties>' +
            '<ss:ExcelWorkbook>' +
                '<ss:WindowHeight>' + worksheet.height + '</ss:WindowHeight>' +
                '<ss:WindowWidth>' + worksheet.width + '</ss:WindowWidth>' +
                '<ss:ProtectStructure>False</ss:ProtectStructure>' +
                '<ss:ProtectWindows>False</ss:ProtectWindows>' +
            '</ss:ExcelWorkbook>' +
            '<ss:Styles>' +
                '<ss:Style ss:ID="Default">' +
                    '<ss:Alignment ss:Vertical="Top" ss:WrapText="1" />' +
                    '<ss:Font ss:FontName="arial" ss:Size="10" />' +
                    '<ss:Borders>' +
                        '<ss:Border ss:Color="#e4e4e4" ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Top" />' +
                        '<ss:Border ss:Color="#e4e4e4" ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Bottom" />' +
                        '<ss:Border ss:Color="#e4e4e4" ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Left" />' +
                        '<ss:Border ss:Color="#e4e4e4" ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Right" />' +
                    '</ss:Borders>' +
                    '<ss:Interior />' +
                    '<ss:NumberFormat />' +
                    '<ss:Protection />' +
                '</ss:Style>' +
                '<ss:Style ss:ID="title">' +
                    '<ss:Borders />' +
                    '<ss:Font />' +
                    '<ss:Alignment ss:WrapText="1" ss:Vertical="Center" ss:Horizontal="Center" />' +
                    '<ss:NumberFormat ss:Format="@" />' +
                '</ss:Style>' +
                '<ss:Style ss:ID="headercell">' +
                    '<ss:Font ss:Bold="1" ss:Size="10" />' +
                    '<ss:Alignment ss:WrapText="1" ss:Horizontal="Center" />' +
                    '<ss:Interior ss:Pattern="Solid" ss:Color="#A3C9F1" />' +
                '</ss:Style>' +
                '<ss:Style ss:ID="even">' +
                    '<ss:Interior ss:Pattern="Solid" ss:Color="#CCFFFF" />' +
                '</ss:Style>' +
                '<ss:Style ss:Parent="even" ss:ID="evendate">' +
                    '<ss:NumberFormat ss:Format="[ENG][$-409]dd\-mmm\-yyyy;@" />' +
                '</ss:Style>' +
                '<ss:Style ss:Parent="even" ss:ID="evenint">' +
                    '<ss:NumberFormat ss:Format="0" />' +
                '</ss:Style>' +
                '<ss:Style ss:Parent="even" ss:ID="evenfloat">' +
                    '<ss:NumberFormat ss:Format="0.00" />' +
                '</ss:Style>' +
                '<ss:Style ss:ID="odd">' +
                    '<ss:Interior ss:Pattern="Solid" ss:Color="#CCCCFF" />' +
                '</ss:Style>' +
                '<ss:Style ss:Parent="odd" ss:ID="odddate">' +
                    '<ss:NumberFormat ss:Format="[ENG][$-409]dd\-mmm\-yyyy;@" />' +
                '</ss:Style>' +
                '<ss:Style ss:Parent="odd" ss:ID="oddint">' +
                    '<ss:NumberFormat ss:Format="0" />' +
                '</ss:Style>' +
                '<ss:Style ss:Parent="odd" ss:ID="oddfloat">' +
                    '<ss:NumberFormat ss:Format="0.00" />' +
                '</ss:Style>' +
            '</ss:Styles>' +
            worksheet.xml +
            '</ss:Workbook>');
    },
    
    
    createWorksheet: function(resourceFields, eventFields) {

        // Calculate cell data types and extra class names which affect formatting
        var cellType = [],
            cellTypeClass = [],
            header,
            totalWidthInPixels = 0,
            colXml = '',
            headerXml = '',
            nbrFields = resourceFields.length + eventFields.length;

        for (var i = 0; i < nbrFields; i++) {
            var field = i < resourceFields.length ? this.grid.store.model.prototype.fields.get(resourceFields[i]) : 
                                                    this.grid.eventStore.model.prototype.fields.get(eventFields[i - resourceFields.length]),
                header = this.grid.child('gridcolumn[dataIndex=' + field.name + ']'),
                w = header ? header.getWidth() : this.defaultColumnWidth,
                header = header ? header.text : field.name;
                
            totalWidthInPixels += w;
            colXml += '<ss:Column ss:AutoFitWidth="1" ss:Width="' + w + '" />';
            headerXml += '<ss:Cell ss:StyleID="headercell">' +
                '<ss:Data ss:Type="String">' + header + '</ss:Data>' +
                '<ss:NamedCell ss:Name="Print_Titles" /></ss:Cell>';
            switch(field.type) {
                case "int":
                    cellType.push("Number");
                    cellTypeClass.push("int");
                    break;
                case "float":
                    cellType.push("Number");
                    cellTypeClass.push("float");
                    break;
                case "bool":
                case "boolean":
                    cellType.push("String");
                    cellTypeClass.push("");
                    break;
                case "date":
                    cellType.push("DateTime");
                    cellTypeClass.push("date");
                    break;
                default:
                    cellType.push("String");
                    cellTypeClass.push("");
                    break;
            }
        }
        var visibleColumnCount = cellType.length;

        var result = {
            height: 9000,
            width: Math.floor(totalWidthInPixels * 30) + 50
        };

//      Generate worksheet header details.
        var t = '<ss:Worksheet ss:Name="' + this.title + '">' +
            '<ss:Names>' +
                '<ss:NamedRange ss:Name="Print_Titles" ss:RefersTo="=\'' + this.title + '\'!R1:R2" />' +
            '</ss:Names>' +
            '<ss:Table x:FullRows="1" x:FullColumns="1"' +
                ' ss:ExpandedColumnCount="' + visibleColumnCount +
                '" ss:ExpandedRowCount="' + (this.grid.eventStore.getCount() + 2) + '">' +
                colXml +
                '<ss:Row ss:Height="38">' +
                    '<ss:Cell ss:StyleID="title" ss:MergeAcross="' + (visibleColumnCount - 1) + '">' +
                      '<ss:Data xmlns:html="http://www.w3.org/TR/REC-html40" ss:Type="String">' +
                        '<html:B><html:U><html:Font html:Size="15">' + (this.title || '') +
                        '</html:Font></html:U></html:B></ss:Data><ss:NamedCell ss:Name="Print_Titles" />' +
                    '</ss:Cell>' +
                '</ss:Row>' +
                '<ss:Row ss:AutoFitHeight="1">' +
                headerXml + 
                '</ss:Row>';

//      Generate the data rows from the data in the Store
        t += this.getGridData(cellType, cellTypeClass, resourceFields, eventFields);

        result.xml = t + '</ss:Table>' +
            '<x:WorksheetOptions>' +
                '<x:PageSetup>' +
                    '<x:Layout x:CenterHorizontal="1" x:Orientation="Landscape" />' +
                    '<x:Footer x:Data="Page &amp;P of &amp;N" x:Margin="0.5" />' +
                    '<x:PageMargins x:Top="0.5" x:Right="0.5" x:Left="0.5" x:Bottom="0.8" />' +
                '</x:PageSetup>' +
                '<x:FitToPage />' +
                '<x:Print>' +
                    '<x:PrintErrors>Blank</x:PrintErrors>' +
                    '<x:FitWidth>1</x:FitWidth>' +
                    '<x:FitHeight>32767</x:FitHeight>' +
                    '<x:ValidPrinterInfo />' +
                    '<x:VerticalResolution>600</x:VerticalResolution>' +
                '</x:Print>' +
                '<x:Selected />' +
                '<x:DoNotDisplayGridlines />' +
                '<x:ProtectObjects>False</x:ProtectObjects>' +
                '<x:ProtectScenarios>False</x:ProtectScenarios>' +
            '</x:WorksheetOptions>' +
        '</ss:Worksheet>';
        return result;
    },
    
    getGridData : function(cellType, cellTypeClass, resourceFields, eventFields) {
        var eventData,
            resourceData,
            data = '',
            cellClass,
            resourceItems = this.grid.store.data.items,
            eventItems = this.grid.eventStore.data.items,
            nbrFields = resourceFields.length + eventFields.length;
         
        for (var i = 0, l = eventItems.length; i < l; i++) {
            data += '<ss:Row>';
            cellClass = (i & 1) ? 'odd' : 'even';
            eventData = eventItems[i].data;
            resourceData = eventItems[i].getResource().data;
            
            for (var j = 0; j < nbrFields; j++) {
                var v;
                
                if (j < resourceFields.length) {
                    v = resourceData[resourceFields[j]];
                } else {
                    v = eventData[eventFields [j - resourceFields.length]];
                }
                data += '<ss:Cell ss:StyleID="' + cellClass + cellTypeClass[j] + '"><ss:Data ss:Type="' + (cellType[j] == 'DateTime' ? 'String' : cellType[j]) + '">';
                    if (cellType[j] == 'DateTime') {
                        data += v.format(this.dateFormat);
                    } else {
                        data += v;
                    }
                data +='</ss:Data></ss:Cell>';
            }
            data += '</ss:Row>';
        }
        
        return data;
    },
    
    ieGetGridData : function(resourceFields, eventFields, sheet) {
        var eventData,
            resourceData,
            data = '',
            resourceItems = this.grid.store.data.items,
            eventItems = this.grid.eventStore.data.items,
            cm = this.grid.getColumnModel(),
            nbrFields = resourceFields.length + eventFields.length;
        

        for (var i = 0; i < nbrFields; i++) {
            var field = i < resourceFields.length ? this.grid.store.recordType.prototype.fields.get(resourceFields[i]) : 
                                                    this.grid.eventStore.recordType.prototype.fields.get(eventFields[i - resourceFields.length]),
                colInd = cm.findColumnIndex(field.name),
                w = colInd > 0 ? cm.getColumnWidth(colInd) : this.defaultColumnWidth,
                header = colInd > 0 ? cm.getColumnHeader(colInd) : field.name;
                
            sheet.cells(1,i + 1).value = header;
        }
        
                
        for (var i = 0, l = eventItems.length; i < l; i++) {
            eventData = eventItems[i].data;
            resourceData = eventItems[i].getResource().data;
            
            for (var j = 0; j < nbrFields; j++) {
                var v;
                
                if (j < resourceFields.length) {
                    v = resourceData[resourceFields[j]];
                } else {
                    v = eventData[eventFields [j - resourceFields.length]];
                }
                if (v instanceof Date) {
                    sheet.cells(i + 2,j + 1).value = v.format(this.dateFormat);
                } else {
                    sheet.cells(i + 2,j + 1).value = v;
                }
            }
        }
        
        return data;
    },
    
    ieToExcel : function (resourceFields, eventFields){
        if (window.ActiveXObject){
            var  xlApp, xlBook;
            try {
                xlApp = new ActiveXObject("Excel.Application"); 
                xlBook = xlApp.Workbooks.Add();
            } catch (e) {
                Ext.Msg.alert('Error', 'For the export to work in IE, you have to enable a security setting called "Initialize and script ActiveX control not marked as safe."');
                return;
            }


            xlBook.worksheets("Sheet1").activate;
            var XlSheet = xlBook.activeSheet;
            xlApp.visible = true; 
           
           this.ieGetGridData(resourceFields, eventFields, XlSheet);
           XlSheet.columns.autofit; 
        }
    }
});

