window.addEventListener('DOMContentLoaded',init,false);

function init() {
    var y1909 = document.getElementById('y1909')
    var y1929 = document.getElementById('y1929')
    var y1935 = document.getElementById('y1935')
    var y1955 = document.getElementById('y1955')
    y1909.addEventListener('click', project_HS,false)
    y1929.addEventListener('click', project_HS, false)
    y1935.addEventListener('click', project_HS, false)
    y1955.addEventListener('click', project_HS, false)

    var calendar = document.getElementById('calendar')
    var warren = document.getElementById('warrenLetters')
    var siple = document.getElementById('sipleLetter')
    var travel = document.getElementById('travelLetters')
    calendar.addEventListener('click', timeline_HS, false)
    warren.addEventListener('click', timeline_HS, false)
    siple.addEventListener('click', timeline_HS, false)
    travel.addEventListener('click', timeline_HS, false)
}

function switch_status (project_id, project_index){
    var projStatus = 'none'
    var status = ['none', 'block']
    var info = document.getElementsByClassName('timelineInfo')[project_index]
    var timeline = document.getElementsByClassName('timeline')[project_index]
    if (project_id != '') {
        if (project_id.style.display == '' || project_id.style.display == 'none')
            projStatus = 'block'
        project_id.style.display = projStatus
    }
    if (info.style.display == '' || info.style.display == 'none'){
        [status[0], status[1] ] = [status[1], status[0]]
    }
    info.style.display = status[0]
    timeline.style.display = status[1]
}

function project_HS(){
    switch (this.id){
        case 'y1909':
            var calendar = document.getElementById('calendar')
            switch_status(calendar, 0)
            break
        case 'y1929':
            var warren = document.getElementById('warrenLetters')
            switch_status(warren, 1)
            break
        case 'y1935':
            var siple = document.getElementById('sipleLetter')
            switch_status(siple, 2)
            break
        case 'y1955':
            var travel = document.getElementById('travelLetters')
            switch_status(travel, 3)
            break
    }
}

function timeline_HS(){
    switch (this.id){
        case 'calendar':
            switch_status('', 0)
            break
        case 'warrenLetters':
            switch_status('', 1)
            break
        case 'sipleLetter':
            switch_status('', 2)
            break
        case 'travelLetters':
            switch_status('', 3)
            break
    }
}