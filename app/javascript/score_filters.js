$(document).on('turbolinks:load', function(){
  $('input[type="checkbox"]').change(function() {
      $.get($(".filters_click").attr("action"), $(".filters_click").serialize(), null, "script");
      return false;
  });
})
