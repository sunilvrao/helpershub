$(document).ready(function(){

    Cufon.replace('ul#primary-menu a strong',{textShadow:'1px 1px 1px #000', hover: { textShadow: '1px 1px 1px #000' }})('ul#primary-menu ul a',{textShadow:'1px 1px 1px #000'});

    jQuery('ul.nav').superfish({
        delay:       200,                            // one second delay on mouseout
        animation:   {
            opacity:'show',
            height:'show'
        },  // fade-in and slide-down animation
        speed:       'fast',                          // faster animation speed
        autoArrows:  true,                           // disable generation of arrow mark-up
        dropShadows: false                            // disable drop shadows
    });

    jQuery('ul.nav > li > a.sf-with-ul').parent('li').addClass('sf-ul');

    et_search_bar();

    var $featured_content = jQuery('#slides');

    if ($featured_content.length) {
        $featured_content.cycle({
            timeout: 0,
            speed: 500,
            cleartypeNoBg: true,
            prev:   '#featured a#left-arrow',
            next:   '#featured a#right-arrow'
        });
    }

    function et_search_bar(){
        var $searchform = jQuery('#header-bottom div#search-bar'),
        $searchinput = $searchform.find("input#searchinput"),
        searchvalue = $searchinput.val();

        $searchinput.focus(function(){
            if (jQuery(this).val() === searchvalue) jQuery(this).val("");
        }).blur(function(){
            if (jQuery(this).val() === "") jQuery(this).val(searchvalue);
        });
    };

    et_footer_improvements('#footer .footer-widget');

    function et_footer_improvements($selector){
        var $footer_widget = jQuery($selector);

        if (!($footer_widget.length == 0)) {
            $footer_widget.each(function (index, domEle) {
                if ((index+1)%4 == 0) jQuery(domEle).addClass("last").after("<div class='clear'></div>");
            });
        }
    }
});