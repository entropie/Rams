
// history
function mk_history_link() {
  var target = $(this);
  $.ajax({
    url: target.attr("href"),
    success: function(result) {
      $("#content").html(result);
      history_append(target);
      mk_history_links($("#content"));
      mk_corners($("#content"));
      load_sidebar(target.attr("href"));
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

function clearForm(form) {
  // iterate over all of the inputs for the form
  // element that was passed in
  $(':input', form).each(function() {
 var type = this.type;
 var tag = this.tagName.toLowerCase(); // normalize case
 // it's ok to reset the value attr of text inputs,
 // password inputs, and textareas
 if (type == 'text' || type == 'password' || tag == 'textarea')
   this.value = "";
 // checkboxes and radios need to have their checked state cleared
 // but should *not* have their 'value' changed
 else if (type == 'checkbox' || type == 'radio')
   this.checked = false;
 // select elements need to have their 'selectedIndex' property set to -1
 // (this works for both single and multiple select elements)
 else if (tag == 'select')
   this.selectedIndex = -1;
  });
};

function form_srlz(frm){
  var target = $(frm);
  var vars = target.serialize();
  $(target).block();
  $.post(target.attr('action'), vars, function(data){
    switch(data){
      case "1\n":
        clearForm($(target));
      break;
      default:
    }
    $(target).unblock();

  });
  return false;
}

function mk_corners(ele){
    $(ele).find('.corner').each(function (){
        $(this).corner();
    });
}

function mk_history_links(ele){
    $(ele).find('.alink').each(function (){
        $(this).bind("click", mk_history_link);
    });
}

function load_sidebar(href){
  $.ajax({
    url: "/gsidebar" + href,
    success: function(result) {
      $("#sidebar_content").html(result);
      mk_history_links($("#sidebar_content"));
      return false;
    }
  });
}



google.setOnLoadCallback(function() {
  load_sidebar("/dashboard");
  mk_history_links($("#top"));
  $("#sidebar").corner();
});
