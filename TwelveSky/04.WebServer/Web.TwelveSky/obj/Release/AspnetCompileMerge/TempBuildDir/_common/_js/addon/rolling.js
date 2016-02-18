// JavaScript Document
$(document).ready(function() {



    $.fn.roate = function( options ) {
        var opts = $.extend( {}, $.fn.roate.defaults, options ),				
				containerBox = [],
				$this = $(this),
				defaultWidth, defaultHeight, curentIndex = 0, distance, childLength, isAnimate = false, timer = null;				
        var pm = {}
        var _init = function() {
            _setDefaultSize();
            _setDistance();
            _setContainerBox();
            if(childLength > 1) {
                _setEventBind();
            } else {
                _displayPlayButton();
            }
        }
				
        , _setDefaultSize = function() {
            defaultWidth  = opts.defaultWidth || $this.children().eq(0).width();
            defaultHeight = opts.defaultHeight || $this.children().eq(0).height();
            childLength   = $this.children().length;
            if ( opts.movement == 'top' ) {
                defaultHeight = defaultHeight * parseInt(opts.scroll,10);
            } else {
                defaultWidth  = defaultWidth * parseInt(opts.scroll,10);
            }
        }
				
        , _setDistance = function() {
            if ( opts.movement == 'top') {
                distance = defaultHeight;
            } else {
                distance = defaultWidth;
            }
        }

        , _setContainerBox = function() {
            $this.children().each(function(i){
                containerBox[ containerBox.length ] = this;
            });
        }
				
        , _setEventBind  = function() {
            $(options.nextButton).bind('click.roate', function(){
                pm.next();
            });
            $(options.prevButton).bind('click.roate', function(){
                pm.prev();
            });
            $(options.nextButton2).bind('click.roate', function(){
                pm.next();
            });
            $(options.prevButton2).bind('click.roate', function(){
                pm.prev();
            });
						
            $this.hover( function(){
                pm.stop();
            }, function(){
                _stopTimer();
            });
        }
				
        , _addCurrent = function() {
            curentIndex++;

            if ( curentIndex >= childLength ) {
                curentIndex = 0;
            }
        }
				, _minusCurrent = function() {
            curentIndex--;
            if ( curentIndex < 0 ) {
                curentIndex = childLength -1;
            }
        }
        , _isAmimate = function() {
            if ( isAnimate ) {
                return true;
            }
            isAnimate = true;
            return false;
        }
				, _stopTimer = function(){
            if ( timer ) {
                clearInterval( timer );
                _displayPlayButton();
            }
        }, _displayPlayButton = function() {
            $(opts.playButton).css('display', 'inline');
            $(opts.stopButton).css('display', 'none');
        }, _displayStopButton = function() {
            $(opts.playButton).css('display', 'none');
            $(opts.stopButton).css('display', 'inline');
        }, _setOpacity = function ( style ) {
              if ( opts.opacity ) {
                style['display'] = 'none';
                style['opacity'] = 1;
            }
            return style;
        };

        pm.next = function() {
            this.nextMovement( $(containerBox[ curentIndex ]) );
        };

        pm.prev = function() {
            this.prevMovement( $(containerBox[ curentIndex ]) );
        };

        pm.nextMovement = function ($el) {
            var moveDistance = $this.offset().left - $el.offset().left - distance;

            if ( _isAmimate() === false ) {
                var moveType = {},setCss = {}
                moveType[opts.movement] = moveDistance;
                if ( opts.opacity) {
                    moveType['opacity'] = 0;
                }
                setCss[opts.movement] = parseInt(moveDistance,10) + parseInt(distance,10);
                setCss = _setOpacity( setCss );
                $this.animate(moveType, opts.duration, function(){
                    $this.children(':last').after($el);
                    $this.css(setCss);
                    if ( opts.opacity ) {
                        $this.fadeIn(opts.duration);
                    }
                    isAnimate = false;
                    _addCurrent();
                });
            }
        }

        pm.prevMovement = function ($el) {
            var moveDistance = $this.offset().left - $el.offset().left + distance;
            if ( _isAmimate() === false ) {
                var moveType = {},setCss = {}
                moveType[opts.movement] = moveDistance;
                if ( opts.opacity ) {
                    moveType['opacity'] = 0;
                }
                setCss[opts.movement] = parseInt(moveDistance,10) - parseInt(distance,10);
                setCss = _setOpacity( setCss );
                if ( opts.movement == 'top' ) {
                    $this.css('top',-defaultHeight);
                    moveType[opts.movement] = 0;
                    $this.children(':first').before($this.children(':last'));
                }
                $this.animate(moveType, opts.duration, function(){
                    if ( opts.movement == 'left' ) {
                        $this.children(':first').before($this.children(':last'));
                    }
                    $this.css(setCss);
                    if ( opts.opacity ) {
                        $this.fadeIn(opts.duration);
                    }
                    _minusCurrent();
                    isAnimate = false;
                });
            }
        }
        _init();
        if ( opts.autoStart && childLength > 1) {
            pm.play();
        }
        return pm;
    };

    $.fn.roate.defaults  = {
        'duration' : '3000',
        'prevButton' : '#prevButton',
        'nextButton' : '#nextButton',
        'movement'  : 'left',
        'scroll'     : 1,
        'autoStart'   : false,
        'interval'   : 1000,
        'opacity'    : 'hide'
    };


/* html
$(document).ready(function(){
	$(".roll_monster ul").roate({
		'interval' : 1000,
		'prevButton' : '#prevButton',
		'nextButton' : '#nextButton',
		'defaultWidth':  '200',
		'movement'  : 'left',
		'opacity' : 'hide'
	});
});
*/




});

