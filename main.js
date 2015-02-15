var hours = (new Date()).getHours();

if (hours < 8 || hours > 19) {
    document.querySelector('html').classList.add("night");
}

if (sessionStorage.getItem('weather')) {
    document.querySelector('html').classList.add(sessionStorage.getItem('weather'))
}

document.querySelector('#sun').addEventListener('click', function() {
    document.querySelector('html').classList.add("sun");
    document.querySelector('html').classList.remove("rain");
    document.querySelector('html').classList.remove("snow");
    sessionStorage.setItem('weather', 'sun');
});

document.querySelector('#rain').addEventListener('click', function() {
    document.querySelector('html').classList.add("rain");
    document.querySelector('html').classList.remove("sun");
    document.querySelector('html').classList.remove("snow");
    sessionStorage.setItem('weather', 'rain');
});

document.querySelector('#snow').addEventListener('click', function() {
    document.querySelector('html').classList.add("snow");
    document.querySelector('html').classList.remove("sun");
    document.querySelector('html').classList.remove("rain");
    sessionStorage.setItem('weather', 'snow');
});