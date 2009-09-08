
// history
function mk_history_link() {

    var target = $(this);
    alert(target);
    $.ajax({
        url: target.attr("href"),
        success: function(result) {
            $("#content").html(result);
            history_append(target);
            return false;
        }
    });
    return false;

};
function history_append(ele){
    var target = $('#history_inc');
    var html = '<li class="column"><a return false;" class="alink" href="' + ele.attr("href") +'" title="'+ ele.attr("title") +'">' + ele.attr("title") +'</a></li>';
    target.append(html);
    $(target).find("a:last").bind("click", mk_history_link);
}



google.setOnLoadCallback(function() {
    $('.alink').each(function (){
        $(this).bind("click", mk_history_link);
        //mk_functs($(this));
        //if(! $(this).find('.user_small div').hasClass('r') )
        //  $(this).rounder("dyn_sh"); //corner("round 15px");
        //$(this).find('.uimage').bind('click', show_ud);
    });

});
