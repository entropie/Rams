
// history
function mk_history_link() {
  var target = $(this);
  $.ajax({
    url: target.attr("href"),
    success: function(result) {
      $("#content").html(result);

      if(target.attr("class").substring(0, 6) != "nohist")
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

function mk_history_links(ele){
    $(ele).find('.alink').each(function (){
        $(this).bind("click", mk_history_link);
    });
}


function clearForm(form) {
  $(':input', form).each(function() {
    var type = this.type;
    var tag = this.tagName.toLowerCase(); // normalize case
    if (type == 'text' || type == 'password' || tag == 'textarea')
      this.value = "";
    else if (type == 'checkbox' || type == 'radio')
      this.checked = false;
    else if (tag == 'select')
      this.selectedIndex = -1;
  });
};

function form_srlz(frm, history){
  var target = $(frm);
  var vars = target.serialize();
  var uid = $(target).find("#uid").attr("value");
  var text = $(target).find("option[value='"+uid+"']").text();
  $.get(target.attr('action'), vars, function(data){
    $(target).block();
    $("#content").html(data);
    mk_history_links($("#content"));
    mk_corners($("#content"));
    var a = "<a href='" + target.attr("action") + "?" + vars + "' title='" + $(target).find(".hist_msg").attr("value") + " " + text + "'>Benutzer Editieren</a>";
    if(history)
      history_append($(a));

    load_sidebar(target.attr("href"));
    $(target).unblock();
  });
}

function ue_form_srlz(frm){
  var target = $(frm);
  var vars = target.serialize();
  $(target).block();
  $.post(target.attr('action'), vars, function(data){
    switch(data){
      case "0\n":
        clearForm($(target));
        $.growl("Speichern", "Komplett");
      break;
      case "1\n":
        $.growl("Speichern", "Unzureichend ausgefülltes Fomular");
        break;
      case "2\n":
        $.growl("Speichern", "Passwort nicht Identisch");
        break;
      default:
        // FIXME: Error msg sucks
        $.growl("Speichern", "Unerklärlicher Fehler");
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
