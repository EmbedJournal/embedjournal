// Hide Header on on scroll down
var didScroll;
var lastScrollTop = 0;
var delta = 5;
var navbarHeight = $('.s-categoryNav').outerHeight();

$(window).scroll(function(event){
    didScroll = true;
    var st = $(this).scrollTop();

    if(st <= 81) {
        $('.s-categoryNav').removeClass('-fixed');
        $('.s-categoryNav').removeClass('nav-up');
    }
});

setInterval(function() {
    if (didScroll) {
        hasScrolled();
        didScroll = false;
    }
}, 250);

function hasScrolled() {
    var st = $(this).scrollTop();

    // Make sure they scroll more than delta
    if(Math.abs(lastScrollTop - st) <= delta)
        return;
    // If they scrolled down and are past the navbar, add class .nav-up.
    // This is necessary so you never see what is "behind" the navbar.
    if (st > lastScrollTop && st > navbarHeight && st > 81){
        // Scroll Down
        $('.s-categoryNav').removeClass('nav-down').addClass('nav-up');
        // $('.c-aside').removeClass('view-top').addClass('view-bottom');
    } else {
        // Scroll Up
        if(st + $(window).height() < $(document).height() && st > 81) {
            $('.s-categoryNav').removeClass('nav-up').addClass('nav-down');
            // $('.c-aside').removeClass('view-bottom').addClass('view-top');
            $('.s-categoryNav').addClass('-fixed');
        }
    }

    lastScrollTop = st;
}

$(document).ready(function() {
    // jquery code here
    $('.l-main').addClass('-fadeIn');

    $('.js-expand').addClass('-expand');

    $('.js-categoryNav .hasSubmenu > a').click(function(e){
        e.preventDefault();
        $(this).siblings('.submenu').show();
    });

    $(window).scroll(function(){
        if ($(this).scrollTop() > 100) {
            $('.js-toTop').addClass('-show');
        } else {
            $('.js-toTop').removeClass('-show');
        }
    });
    $('.js-toTop').click(function(){
        $("html, body").animate({ scrollTop: 0 }, 600);
        return false;
    });

    $('.gallery').featherlightGallery({
        gallery: {
            fadeIn: 300,
            fadeOut: 300
        },
        openSpeed:    300,
        closeSpeed:   300
    });

    $.featherlight.defaults.afterContent = function() {
        var caption = this.$currentTarget.find('img').attr('alt');
        console.log(caption);
        this.$instance.find('.caption').remove();
        $('<div class="caption">').text(caption).appendTo(this.$instance.find('.featherlight-content'));
    }

    $.featherlightGallery.prototype.afterContent = function() {
        var caption = this.$currentTarget.find('img').attr('alt');
        this.$instance.find('.caption').remove();
        $('<div class="caption">').text(caption).appendTo(this.$instance.find('.featherlight-content'));
    };

});
