$('.menu-button, #menu').on('mouseover', function(event){
  console.log('hover');
  $('#content').addClass('disabled');
});
$('.menu-button, #menu').on('mouseout', function(event){
  console.log('hover out', event);
  $('#content').removeClass('disabled');
});