function ub_click(){
  $(this).unbind("click");
  $(this).bind("click", ub_uclick);
  $(this).parent().find(".sub").slideDown();
}
function ub_uclick(){
  $(this).parent().find(".sub").slideUp();
  $(this).unbind("click");
  $(this).bind("click", ub_click);
}

function setup_userbox(ub){
  var img = $(ub).find(".uimg");
  var nub = $(ub);
  img.bind("click", ub_click);
}
function fill_ubox_content(id) {
    $.ajax({
      url: "/user/box/" + id,
      success: function(result){
        $("#ub").html(result);
        $("#ub .userbox").corner();
        mk_history_links(('#ub'));
        $("#ub .userbox").highlightFade();
        setup_userbox($('#ub .userbox'));
      }
    });
}

function fill_ubox(target){
  $(target).autocomplete("/user/lookup", {
    width: 260,
    selectFirst: false
  });
  $(target).result(function(ev, item) {
    var email = item[0];
    var id = item[1];
    fill_ubox_content(id);
  });
}


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
      if($("#userlookup").length > 0){
        var ucontent = $("#userlookup").attr("value");
        if(ucontent.length > 0)
          fill_ubox_content($("#lookup_uid").attr("value"));
        fill_ubox($("#userlookup"));
      }
      setup_userbox($('#content'));
      $("#content .popupwindow").popupwindow(profiles);
      load_sidebar(target.attr("href"));
      return false;
    }
  });

  return false;
}

historysize = 5;
function history_append(ele){
    var target = $('#history_inc');
    var href = $(ele).attr("href");
    var dups = $(target).find("a[href='" + href + "']");
    var html = '<li class="column"><a class="alink" href="' + ele.attr("href") +'" title="'+ ele.attr("title") +'">' + ele.attr("title") +'</a></li>';

    target.prepend(html);

    $(target).find("a:first").bind("click", mk_history_link);
    if($(target).find("li").length >= historysize){
        $(target).find("li:gt(" + historysize + ")").remove();
    }

    if(dups.length > 0){
        $(dups).each(function() {
            $(this).parent().remove();
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

function ue_form_srlz(frm, clear){
  var target = $(frm);
  var vars = target.serialize();
  $(target).block();
  $.post(target.attr('action'), vars, function(data){
    switch(data){
      case "0\n":
        if(clear)
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

var profiles =
  {
    window800:
    {
      height:800,
      width:800,
      status:1
    },
    window600:
    {
      height:600,
      width:600,
      status:1,
      resizable:1,
      scrollbars:1
    },
    windowCenter:
    {
      height:300,
      width:400,
      center:1
    },
    windowNotNew:
    {
      height:300,
      width:400,
      center:1,
      createnew:0
    }
  };




google.setOnLoadCallback(function() {
  load_sidebar("/dashboard");
  mk_history_links($("#top"));
  $("#sidebar").corner();
  $(".popupwindow").popupwindow(profiles);

});
