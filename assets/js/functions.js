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
    $('.js-checkbox').customCheckbox();
    
    $('#disqus_thread').bind('DOMNodeInserted DOMNodeRemoved', function() {
        $(this).css('padding', 16);
    });

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

    jQuery('.js-content, .js-aside').theiaStickySidebar({
      // Settings
      additionalMarginTop: 80
    });

    $.featherlight.defaults.afterContent = function() {
        var caption = this.$currentTarget.find('img').attr('alt');
        console.log(caption);
        this.$instance.find('.caption').remove();
        $('<div class="caption">').text(caption).appendTo(this.$instance.find('.featherlight-content'));
    }
    $.featherlight.defaults.beforeClose = function() {
        $('body').removeClass('model-open');
        $('body').css('padding-right', 0);
    };
    $.featherlight.defaults.afterOpen = function() {
        $('body').addClass('model-open');
        $('body').css('padding-right', 15);
    };

    $.featherlightGallery.prototype.afterContent = function() {
        var caption = this.$currentTarget.find('img').attr('alt');
        this.$instance.find('.caption').remove();
        $('<div class="caption">').text(caption).appendTo(this.$instance.find('.featherlight-content'));
    };

    $('.js-loadComment').on('click', function(){
        var disqus_shortname = 'embedjournal'; // Replace this value with *your* username.

        // ajax request to load the disqus javascript
        $.ajax({
            type: "GET",
            url: "http://" + disqus_shortname + ".disqus.com/embed.js",
            dataType: "script",
            cache: true
        });

        // hide the button once comments load
        $(this).fadeOut();
    });

    // $(document).on('click', '.js-checkboxTrigger', function() {
    //     triggerCheck();
    // });

});


$.fn.customCheckbox = function() {

    $(this).hide();

    if($(this).is(':checked')) {
        $(this).before('<button class="c-checkbox js-checkboxTrigger" type="button" onclick="triggerCheck(this)"><span class="fa fa-check"></span></button>');
    }
    else {
        $(this).before('<button class="c-checkbox js-checkboxTrigger" type="button" onclick="triggerCheck(this)"></button>');
    }
}

function triggerCheck(e) {

    var checkbox = $(e).siblings('.js-checkbox');

    if(checkbox.is(':checked')) {
        checkbox.prop('checked', false);
        $(e).empty();
    }
    else {
        checkbox.prop('checked', true);
        $(e).append('<span class="fa fa-check"></span>');
    }
}

function insertPostPageAdd() {
    var childCount = $(".b-postContent").children().length;
    var addUnitLarge = '<ins class="adsbygoogle b-addImage postpageAddUnit" style="display:none; width:728px; height:90px" data-ad-client="ca-pub-2839664859161137" data-ad-slot="3313112802"></ins>'
    var addUnitSmall = '<ins class="adsbygoogle" style="display:inline-block;width:320px;height:100px" data-ad-client="ca-pub-2839664859161137" data-ad-slot="3986790400"></ins>'
    var addUnitMedium = '<ins class="adsbygoogle" style="display:inline-block;width:468px;height:60px" data-ad-client="ca-pub-2839664859161137" data-ad-slot="2355280008"></ins>'
    var page_width = document.getElementById('postContent').getBoundingClientRect().width;

    if(childCount > 5) {
        if (page_width >= 728) {
            var addUnit = '<div align="center">' + addUnitLarge + '</div>'
        } else if(page_width >= 468){
            var addUnit = '<div align="center">' + addUnitLarge + '</div>'
        } else {
            var addUnit = '<div align="center">' + addUnitLarge + '</div>'
        }
        $(addUnit).insertAfter('.b-postContent > *:nth-child(4)');
        (adsbygoogle = window.adsbygoogle || []).push({});
    }
}