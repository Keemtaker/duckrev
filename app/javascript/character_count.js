$(document).on('turbolinks:load', function(){

  var maxCharacters = 270;

  $('#count').text(maxCharacters);

  $('#character-count').bind('keyup keydown', function() {
      var count = $('#count');
      var characters = $(this).val().length;

      if (characters > maxCharacters) {
          count.addClass('over');
      } else {
          count.removeClass('over');
      }

      count.text(maxCharacters - characters);
  });
})
