window.addEventListener('DOMContentLoaded',pageLoadUp,false);

function pageLoadUp(){
   var button = document.getElementById("scrollToTop")
   button.addEventListener('click', scrollToTop, true)
 
}
function scrollToTop(){
    var scroll = window.scrollTo(0,0);
    window.scrollTo(0,0);
}
