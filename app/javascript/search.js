$(document).on('turbolinks:load', function(){
  $(".scores_search input").keyup(function() {
    $.get($(".scores_search").attr("action"), $(".scores_search").serialize(), null, "script");
    return false;
  });
})

$(document).on('turbolinks:load', function(){
  $(".scores_search_mobile input").keyup(function() {
    $.get($(".scores_search_mobile").attr("action"), $(".scores_search_mobile").serialize(), null, "script");
    return false;
  });
})
