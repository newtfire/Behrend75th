window.addEventListener('DOMContentLoaded', listen, false)

function listen() {
    var hamburger = document.getElementById("hamburger")
    hamburger.addEventListener('click', openMe, false)
    hamburger.addEventListener('touch', openMe, false)
    var closeX =  document.getElementById("closeMe")
    closeX.addEventListener('click', hideMe, false)
    closeX.addEventListener('touch', hideMe, false)
   
    
}

function openMe() {
    document.getElementsByClassName("sidebar")[0].style.display = "block";
    
}
function hideMe() {
    document.getElementsByClassName("sidebar")[0].style.display = "none";
    
}