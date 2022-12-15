(function ($) {
    "use strict"
    $(function($) {
        let url = window.location.href;
        $('.navbar-nav .nav-item').each(function() {
            if (this.href === url) {
                $(this).closest('.nav-item').addClass('active');
            }
        });
    });

    $(document).ready(function () {
        function toggleNavbarMethod() {
            if ($(window).width() > 992) {
                $('.navbar .dropdown').on('mouseover', function () {
                    $('.dropdown-toggle', this).trigger('click');
                }).on('mouseout', function () {
                    $('.dropdown-toggle', this).trigger('click').blur();
                });
            } else {
                $('.navbar .dropdown').off('mouseover').off('mouseout');
            }
        }
        toggleNavbarMethod();
        $(window).resize(toggleNavbarMethod);
    });
    
    
    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 100) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
        return false;
    });


    // Testimonials carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        dots: true,
        loop: true,
        items: 1
    });

    $.fn.stars = function() {
        return $(this).each(function() {
            const rating = $(this).data("rating");
            const numStars = $(this).data("numStars");
            const fullStar = '<i class="fa fa-star text-primary mr-1"></i>'.repeat(Math.floor(rating));
            const halfStar = (rating%1!== 0) ? '<i class="fas fa-star-half-alt text-primary mr-1"></i>': '';
            const noStar = '<i class="far fa-star text-primary mr-1"></i>'.repeat(Math.floor(numStars-rating));
            $(this).html(`${fullStar}${halfStar}${noStar}`);
        });
    }

    $(function() {
        $('span.stars').stars();
    });
})(jQuery);


