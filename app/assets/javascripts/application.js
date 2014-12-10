//= require jquery
//= require jquery_ujs
//= require blogs
//= require users
//= require bootstrap

function ShowCBox(n) {
  var target = document.getElementById('developbox'+n);
  if( target.style.display != 'block' ) {
    target.style.display = 'block';
  }
  else {
    target.style.display = 'none';
  }
}
