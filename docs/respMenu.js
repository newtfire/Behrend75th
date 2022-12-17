window.addEventListener('DOMContentLoaded', listen, false)

function listen() {
    var hamburger = document.getElementById("hamburger")
    hamburger.addEventListener('click', openMe, false)
    hamburger.addEventListener('touch', openMe, false)
    var closeX = document.getElementById("closeMe")
    closeX.addEventListener('click', hideMe, false)
    closeX.addEventListener('touch', hideMe, false)
    document.getElementsByClassName('document')[0].addEventListener('click', hideMe, false)
    document.getElementsByClassName('document')[0].addEventListener('touch', hideMe, false)
}

function openMe() {
    document.getElementsByClassName("sidebar")[0].classList.add('openSidebar')
    document.getElementById("hamburger").style.visibility = 'hidden'


}
function hideMe() {
    document.getElementsByClassName("sidebar")[0].classList.remove('openSidebar')
    document.getElementById("hamburger").style.visibility = 'visible'

}