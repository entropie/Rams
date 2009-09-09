
// history
function mk_history_link() {
  var target = $(this);
  $.ajax({
    url: target.attr("href"),
    success: function(result) {
      $("#content").html(result);
      history_append(target);
      return false;
    }
  });
      $.ajax({
        url: "/gsidebar" + target.attr("href"),
        success: function(result) {

          $("#sidebar").html(result);
          return false;
        }
      });

  return false;
}

historysize = 6;
function history_append(ele){
    var target = $('#history_inc');
    var href = $(ele).attr("href");
    var dups = $(target).find("a[href='" + href + "']");
    var html = '<li class="column"><a class="alink" href="' + ele.attr("href") +'" title="'+ ele.attr("title") +'">' + ele.attr("title") +'</a></li>';

    target.prepend(html);

    $(target).find("a:first").bind("click", mk_history_link);
    if($(target).find("li").length > historysize){
        $(target).find("li:gt(" + historysize + ")").fadeOut();
    }

    if(dups.length > 0){
        $(dups).each(function() {
            $(this).parent().fadeOut();
        });

    }
}

function mk_hsitory_links(ele){
    $(ele).find('.alink').each(function (){
        $(this).bind("click", mk_history_link);
    });
}


google.setOnLoadCallback(function() {
  mk_hsitory_links($("#top"));
});
