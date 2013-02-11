// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  var stripe = function() {
    $("li:visible:odd").css("background-color", "#f7f7f7");
    $("li:visible:even").css("background-color", "#ffffff");
  };

  stripe();

  $("#search_input").focus();

  $("#search_input").fastLiveFilter("#search_list", {
    callback: function(total) { stripe(); }
  });

  $("#search_input").keydown(function() {
    setTimeout(function() {
      $("div.task").unhighlight();
      $("div.task").highlight($("#search_input").val());
    }, 50);
  });

  var leftArrow = "<img src=\'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAANElEQVQYV2NkYGD4D8SEACMjVAU+xWA1MIUgNjbFcHlkheiKUeTQFcIUY4hjU4jVY0NBIQA2XwULPNHkwgAAAABJRU5ErkJggg==\'>";
  var downArrow = "<img src=\'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAANklEQVQYV2NkYGD4D8SMQIwXgBSAFIIAXsXICvEqRleIUzE2hVgVk20iTg+R7GuiwpFQWIPlAYx9CQtnBpznAAAAAElFTkSuQmCC\'>";

  $(".task .result").click(function() {
    var output = $(this).parent().find(".output");
    var arrow = $(this).find("img");
    var slideSpeed = "fast";
    if (output.is(":visible")) {
      output.slideUp(slideSpeed);
      arrow.replaceWith(downArrow);
    } else {
      output.slideDown(slideSpeed);
      arrow.replaceWith(leftArrow);
    }
  });

  $("form.button_to").bind("ajax:error", function(xhr, data, status) {
    var response = $.parseJSON(data.responseText);
    var errorMsg = "<div class='msg'>" + downArrow + response.msg + "</div>";
    var task = $(this).closest(".task");
    task.removeClass("success").addClass("error");
    task.find(".result").html(errorMsg).removeClass("success").addClass("error");
    task.find(".output").html("<pre>" + response.stacktrace + "</pre>");
  }).bind("ajax:success", function(xhr, data, status) {
    var task = $(this).closest(".task");
    task.removeClass("error");
    var result = task.find(".result").empty().removeClass("error").removeClass("success");
    var output = task.find(".output").empty();

    if (data.output.length > 0) {
      task.addClass("success");
      result.html("<div class='msg'>" + downArrow + "Click here to see the task output</div>");
      result.addClass("success");
      output.html("<pre>" + data.output + "</pre>");
    }
  });
});