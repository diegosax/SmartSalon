/*
 * MoonCake v1.1 - DataTables Demo JS
 *
 * This file is part of MoonCake, an Admin template build for sale at ThemeForest.
 * For questions, suggestions or support request, please mail me at maimairel@yahoo.com
 *
 * Development Started:
 * July 28, 2012
 * Last Update:
 * October xx, 2012
 *
 */

 ;(function( $, window, document, undefined ) {

 	var demos = {

 		dtTableTools: function( target ) {

 			if( $.fn.dataTable ) {

 				target.dataTable({
 					"sDom": "<'dt_header'<'row-fluid'<'span6'l><'span6'T>>r>t<'dt_footer'<'row-fluid'<'span6'i><'span6'p>>>",
 					"oTableTools": {
 						"sSwfPath": "plugins/datatables/TableTools/swf/copy_csv_xls_pdf.swf", 
 						"aButtons": [
 						{
 							"sExtends": "copy", 
 							"sButtonText": '<i class="icol-clipboard-text"></i> Copy'
 						}, 
 						{
 							"sExtends": "csv", 
 							"sButtonText": '<i class="icol-doc-excel-csv"></i> CSV'
 						}, 
 						{
 							"sExtends": "xls", 
 							"sButtonText": '<i class="icol-doc-excel-table"></i> Excel'
 						}, 							
 						{
 							"sExtends": "pdf", 
 							"sButtonText": '<i class="icol-doc-pdf"></i> PDF'
 						}, 
 						{
 							"sExtends": "print", 
 							"sButtonText": '<i class="icol-printer"></i> Print'
 						}
 						]
 					}
 				});
 			}
 		}

 	};

 	$(window).load(function() { });

 	$(document).ready(function() { 		
 		


 		if($.fn.dataTable) {			
 			$('table#professionals_list').dataTable({
 				"oLanguage": {
 					"sUrl": "/assets/mooncake/pt-BR.txt"
 				},
 				"aoColumns": [
 				null,
 				null,
 				{ "bSortable": false },
 				{ "bSortable": false },
 				{ "bSortable": false }
 				]
 			}).columnFilter({
 				aoColumns: [ 
 				{ type: "text" },
 				{ type: "text" },
 				{ type: "text" },
 				{ type: "text" },
 				null             
 				]
 			});
 			
 			$('table#services_list').dataTable({
 				"oLanguage": {
 					"sUrl": "/assets/mooncake/pt-BR.txt"
 				},
 				"aoColumns": [
	 				null,
	 				null,
	 				{ "bSortable": false },
	 				{ "bSortable": false }
 				]
 			}).columnFilter({
 				aoColumns: [ 
	 				{ type: "text" },
	 				{ type: "text" },
	 				{ type: "text" },
	 				null
 				]
 			});

 			$('table#events_list').dataTable({
 				"oLanguage": {
 					"sUrl": "/assets/mooncake/pt-BR.txt"
 				},
 				"aoColumns": [ 				
 				null,
 				null,
 				null,
 				null,
 				null,
 				null,
 				{ "bSortable": false },
 				{ "bSortable": false }
 				],
 				"aaSorting": [[ 4, "asc" ]], 				
 				"fnDrawCallback": function( oSettings ) {
 					$(".dt_header > .row-fluid > .span6:first-child").addClass("span8").removeClass("span6");
 					$(".dt_header > .row-fluid > .span6:last-child").addClass("span4").removeClass("span6")
 					var filters = $("#additional_filters");
 					$("#events_list_length").append(filters); 					
 				}

 			}).columnFilter({
 				aoColumns: [ 
 				{ type: "text" },				    
 				{ type: "text" },
 				{ type: "text" },
 				{ type: "text" },
 				{ type: "text" },
 				{ type: "text" },
 				{ type: "text" },
 				null  
 				]
 			});
 		} 	

 	});

}) (jQuery, window, document);