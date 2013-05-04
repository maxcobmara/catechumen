// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
}





function showStudentStaffResidences(choice)
{
  if (choice == "1"){
    document.getElementById("restypestaff").style.display = "table-row";      
    document.getElementById("restypestudent").style.display = 'none';            
  } else if (choice == '2'){
    document.getElementById("restypestudent").style.display = "table-row";        
    document.getElementById("restypestaff").style.display = 'none';      
  }
}

function showMenuForAllocatableRooms(choice)
{
  if (choice < "3"){    
    document.getElementById("restypes").style.display = 'none';
    document.getElementById("keys1").style.display = 'none';
    document.getElementById("keys2").style.display = 'none';
    document.getElementById("keys3").style.display = 'none';
    document.getElementById("keys4").style.display = 'none';            
  } else if (choice >= '3'){
    document.getElementById("restypes").style.display = "table-row";
    document.getElementById("keys1").style.display = "table-row";
    document.getElementById("keys2").style.display = "table-row";
    document.getElementById("keys3").style.display = "table-row";
    document.getElementById("keys4").style.display = "table-row";             
  }
}

function showStaffLate(choice)
{
  if (choice > "30"){
    document.getElementById("reason").style.display = "table-row";                
  } else if (choice < "30"){
    document.getElementById("reason").style.display = "none";        
  }
}


jQuery(document).ready(function() {
 
//Dropdown Start
$j(function(){

    $("ul.dropdown li").hover(function(){
    
        $(this).addClass("hover");
        $('ul:first',this).css('visibility', 'visible');
    
    }, function(){
    
        $(this).removeClass("hover");
        $('ul:first',this).css('visibility', 'hidden');
    
    });
    
    $("ul.dropdown li ul li:has(ul)").find("a:first").append(" &raquo; ");

})//(jQuery);
//function for datepicker
$(function (){  
   $('.calendar').datepicker({
   showOn: 'both',
   buttonImage: '/images/calendar.gif',
   buttonImageOnly: true,
   changeMonth: true,
   changeYear: true,
   dateFormat:'dd-mm-yy',
   yearRange:'-72:+13',
   showAnim: 'slideDown',
   duration: 'fast'});  
});
})

