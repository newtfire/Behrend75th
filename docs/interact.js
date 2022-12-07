window.addEventListener('DOMContentLoaded',init,false);

function init() {
    var years = document.querySelectorAll("g[id^='y19']")
    var titles = document.querySelectorAll("text[id$='Title']")
    for(var i = 0; i < years.length; i++){
        years[i].addEventListener('click', project_HS,false)
        titles[i].addEventListener('click', timeline_HS, false)
    }
}

function switch_status (project_id, project_index){
    var projStatus = 'none', status = ['none', 'block']
    var info = document.getElementsByClassName('timelineInfo')[project_index]
    var timeline = document.getElementsByClassName('timeline')[project_index]
    if (project_id != '') {
        if (project_id.style.display == '' || project_id.style.display == 'none')
            projStatus = 'block'
        project_id.style.display = projStatus
    }
    if (info.style.display == '' || info.style.display == 'none'){
        [status[0], status[1]] = [status[1], status[0]]
    }
    [info.style.display, timeline.style.display] = [status[0], status[1]]
}

function project_HS(years){
    var years = Array.prototype.slice.call( document.querySelectorAll("g[id^='y19']")).reverse()
    var proj = document.querySelectorAll("g[id^='proj']")
    for(var i = 0; i < years.length; i++){
        if(years[i].id == this.id){
            var project_index = i
            break
        }
    }
    switch_status(proj[project_index], project_index)
}

function timeline_HS(titles){
    var titles = document.querySelectorAll("text[id$='Title']")
    for(var i = 0; i < titles.length; i++){
        if(titles[i].id == this.id){
            var project_index = i
            break
        }
    }
    switch_status('', project_index)
}