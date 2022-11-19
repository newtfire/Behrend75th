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
}

function project_HS(){
    var status = 'none'
    switch (this.id){
        case 'y1909':
            var calendar = document.getElementsByClassName('calendar')
            if (calendar[0].style.display == '' || calendar[0].style.display == 'none')
                status= 'block'
            for(var i = 0; i < calendar.length; i++)
                calendar[i].style.display = status
            break
        case 'y1929':
            var warren = document.getElementsByClassName('warrenLetters')
            if (warren[0].style.display == '' || warren[0].style.display == 'none' )
                status= 'block'
            for(var i = 0; i < warren.length; i++)
                warren[i].style.display = status
            break
        case 'y1935':
            var siple = document.getElementsByClassName('sipleLetter')
            if (siple[0].style.display == '' || siple[0].style.display == 'none')
                status= 'block'
            for(var i = 0; i < siple.length; i++)
                siple[i].style.display = status
            break
        case 'y1955':
            var travel = document.getElementsByClassName('travelLetters')
            if (travel[0].style.display == '' || travel[0].style.display == 'none')
                status= 'block'
            for(var i = 0; i < travel.length; i++)
                travel[i].style.display = status
            break
    }
}

