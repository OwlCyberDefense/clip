$(document).ready( function() {
    var css = $.getParam('css');
	var print = $.getParam('print');

    if(css)
        $("link#style").attr("href","media/css/"+css);
    if(print) {
        $('a').contents().filter(function() {
            return this.nodeType == Node.TEXT_NODE;
        }).unwrap();
        window.print();
		return;
	}
    
    if( $('a#index').hasClass('current') ) {
        $('#tree')
            .addClass('expanded')
            .find('.toggle')
            .css({backgroundPosition: "0 -10px"})
            .nextAll('.hidden')
            .removeClass('hidden')
            .addClass('shown');
        $('#toggle')
            .addClass('expanded')
            .html('Collapse All');
    }
    else
        $(".hidden").hide();

    $('.count').each( function() {
        if($(this).html() == 0)
            $(this).parent('.toggle').removeClass('toggle').css({background: "none", "padding-left": "15px"});
    });

    $(".toggle").click( function() {
        $list = $(this).nextAll('.hidden, .shown'); // Element that is shown/hidden
        $list.toggle();
        if( $list.hasClass('hidden') ) {
            $(this).css({backgroundPosition: "0 -10px"});
            $list.removeClass('hidden').addClass('shown');
        }
        else {
            $list.removeClass('shown').addClass('hidden');
            $list.find('.shown')
                .removeClass('shown')
                .addClass('hidden')
                .hide()
                .parent().children('.toggle')
                    .css({backgroundPosition: "0 3px"});
            $(this).css({backgroundPosition: "0 3px"});
        }
    });

    $("#toggle").click( function() {
        $tree = $("#tree")
        if( $(this).hasClass('expanded') ) {
            if( $tree.hasClass('expanded') ) {
                $tree.removeClass('expanded')
                    .find('.shown')
                    .removeClass('shown')
                    .addClass('hidden')
                    .hide()
                    .parent().children('.toggle')
                        .css({backgroundPosition: "0 3px"});
            }
            $(this).removeClass('expanded');
            $(this).html('Expand All');
        }
        else {
            $tree.addClass('expanded')
                .find('.hidden')
                    .show()
                    .removeClass('hidden')
                    .addClass('shown')
                    .parent().children('.toggle')
                        .css({backgroundPosition: "0 -10px"});
            $(this).addClass('expanded');
            $(this).html('Collapse All');
        }
    });

    $("#print").click( function() {
		var path = window.location.pathname;
        var height = (screen.height)/1.25;
        var width = (screen.width)/2;
        var left = (screen.width)/4;
        var top = (screen.height)/2;
        var params = 'width='+width+', height='+height;
        params += ', top='+top+', left='+left;
        params += ', directories=no, location=no, menubar=no, resizable=no, scrollbars=yes, status=no, toolbar=no';
        var newWin = window.open(path+'?css=print.css&print=true', 'SecState Audit Print', params);
    });

    $("#about").click ( function() {
        var height = (screen.height)/1.5;
        var width = (screen.width)/2;
        var left = (screen.width)/4;
        var top = (screen.height);
        var params = 'width='+width+', height='+height;
        params += ', top='+top+', left='+left;
        params += ', directories=no, location=no, menubar=no, resizable=no, scrollbars=yes, status=no, toolbar=no';
        var newWin = window.open("about.html", 'SecState Help', params);
    });

    $("#help").click ( function() {
        var height = (screen.height)/1.5;
        var width = (screen.width)/2;
        var left = (screen.width)/4;
        var top = (screen.height);
        var params = 'width='+width+', height='+height;
        params += ', top='+top+', left='+left;
        params += ', directories=no, location=no, menubar=no, resizable=no, scrollbars=yes, status=no, toolbar=no';
        var newWin = window.open("help.html", 'SecState Help', params);
    });

});

$.extend({
    getParam: 
        function(name) {
            var dict = [], pair;
            var params = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');

            for(var i=0; i<params.length; i++) {
                pair = params[i].split('=');
                dict.push(pair[0]);
                dict[pair[0]] = pair[1];
            }
			
            return dict[name];
        }
    });
