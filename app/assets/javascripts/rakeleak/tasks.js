// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  var stripe = function() {
    $("li:visible:odd").css("background-color", "#f7f7f7");
    $("li:visible:even").css("background-color", "#ffffff");
  };

  var twodigit = function(value) {
    return (value < 10 ? "0" : "") + value;
  };

  var time = function() {
    var date = new Date();
    return twodigit(date.getHours()) + ":" + twodigit(date.getMinutes());
  };

  var timeNode = function() {
    return "<div class='time'>" + time() + "</div>";
  };

  var leftArrow = "<img src=\'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAANElEQVQYV2NkYGD4D8SEACMjVAU+xWA1MIUgNjbFcHlkheiKUeTQFcIUY4hjU4jVY0NBIQA2XwULPNHkwgAAAABJRU5ErkJggg==\'>";
  var downArrow = "<img src=\'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAANklEQVQYV2NkYGD4D8SMQIwXgBSAFIIAXsXICvEqRleIUzE2hVgVk20iTg+R7GuiwpFQWIPlAYx9CQtnBpznAAAAAElFTkSuQmCC\'>";

  stripe();

  $("#search_input").focus();

  $("#search_input").fastLiveFilter("#search_list", {
    callback: function(total) { stripe(); }
  });

  $("#search_input").keydown(function() {
    setTimeout(function() {
      var $task = $("div.task");
      $task.unhighlight();
      $task.highlight($("#search_input").val());
    }, 50);
  });

  $(".env-toggle").click(function() {
    $(".show-link").toggle('fast', function() {});
  });

  $(".task .result").click(function() {
    var $output = $(this).parent().find(".output");
    var $arrow = $(this).find("img");
    var slideSpeed = "fast";
    if ($output.is(":visible")) {
      $output.slideUp(slideSpeed);
      $arrow.replaceWith(downArrow);
    } else {
      $output.slideDown(slideSpeed);
      $arrow.replaceWith(leftArrow);
    }
  });

  $("form").bind("ajax:error", function(xhr, data, status) {
    var response = $.parseJSON(data.responseText);
    var $task = $(this).closest(".task");
    var $result = $task.find(".result");

    // change class from 'success' to 'error' for task and result elements
    $task.removeClass("success").addClass("error");
    $result.removeClass("success").addClass("error");
    // set error message...
    $result.find(".msg").html(timeNode() + downArrow + response.msg);
    // ...and stacktrace
    $task.find(".output").html("<pre>" + response.stacktrace + "</pre>");
  }).bind("ajax:success", function(xhr, data, status) {
    var $task = $(this).closest(".task");
    var $result = $task.find(".result");
    var $output = $task.find(".output");
    var $msg = $result.find(".msg");

    // remove any content & classes which were previously set
    $task.removeClass("error");
    $result.removeClass("error").removeClass("success");
    $output.empty();
    $msg.empty();

    // show task' output if any
    if (data.output.length > 0) {
      $task.addClass("success");
      $msg.html(timeNode() + downArrow + "Click here to see the task output");
      $result.addClass("success");
      $output.html("<pre>" + data.output + "</pre>");
    }
  });
});