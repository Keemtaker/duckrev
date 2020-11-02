$(document).on('turbolinks:load', function(){
  $(".scores_search input").keyup(function() {
    $.get($(".scores_search").attr("action"), $(".scores_search").serialize(), null, "script");
    return false;
  });
})
