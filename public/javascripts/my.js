/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


//etx/
var grid;  
var ds;  

Ext.onReady(function(){  
    init_grid();     
});  
    
function init_grid() {  
    ds = new Ext.data.Store({  
  //      proxy: new Ext.data.HttpProxy({url: '/selenium_log'}),  
             
        reader: new Ext.data.JsonReader({  
            root: 'Seleniumlogs',  
            totalProperty: 'Total',  
            id: 'id'  
        }, [  
            {name: 'title', mapping: 'title'},  
            {name: 'plot', mapping: 'plot'},  
            {name: 'release_year', mapping: 'date'},  
            {name: 'genre', mapping: 'genre'},  
            {name: 'mpaa', mapping: 'mpaa'},  
            {name: 'directed_by', mapping: 'directed_by'}  
        ]),          
        // turn on remote sorting  
        remoteSort: true      
    });  
    
    var cm = new Ext.grid.ColumnModel  
    ([{  
            id: 'title',  
            header: "Title",  
            dataIndex: 'title',  
            width: 250  
        },{  
            header: "Release Year",  
            dataIndex: 'release_year',  
            width: 75  
        },{    
            header: "MPAA Rating",  
            dataIndex: 'mpaa',  
            width: 75  
        },{    
            header: "Genre",  
            dataIndex: 'genre',  
            width: 100  
        },{    
            header: "Director",  
            dataIndex: 'directed_by',  
            width: 150  
        }]);  
           
    cm.defaultSortable = true;  
   
    grid = new Ext.grid.Grid('selenium_grid', {  
        ds: ds,  
        cm: cm,  
        selModel: new Ext.grid.RowSelectionModel({singleSelect:true}),  
        autoExpandColumn: 'title'  
    });  
   
    grid.render();      
    ds.load({params:{start:0, limit:20}});    
}  