
// history
function mk_history_link() {
    var target = ($(this).attr("href"));
    //return false;

    $.ajax({
        url: target,
        success: function(result) {
            $("#content").html(result);
        }
    });
    return false;

};
//}



google.setOnLoadCallback(function() {
    $('.alink').each(function (){
        $(this).bind("click", mk_history_link);
        //mk_functs($(this));
        //if(! $(this).find('.user_small div').hasClass('r') )
        //  $(this).rounder("dyn_sh"); //corner("round 15px");
        //$(this).find('.uimage').bind('click', show_ud);
    });

});
