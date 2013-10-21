
(function($, m) {
  $.fn.extend({
    myPlugin: function(options) {
      var log, settings;
      settings = {
        option1: true,
        option2: false,
        debug: false
      };
      settings = $.extend(settings, options);
      log = function(msg) {
        if (settings.debug) {
          return typeof console !== "undefined" && console !== null ? console.log(msg) : void 0;
        }
      };

      fill_time_gap_between = function( moment1, moment2, $this ) {
        var range = moment.twix(moment1, moment2);

        if ( moment1 === moment2 ) {
          return;
        };
        if ( range.length('days') === 1 ) {
          return;
        };

        var iter = range.iterateInner('days');
        iter.next();
        while(iter.hasNext()) {
          var date = iter.next();
          var $span = $('<a>').html( '<span>' + date.format('MMM') + '</span> ' + date.format('DD') ).attr('href','#');
          var $li = $('<li>').attr('id', date.format('YYYY-MM-DD') ).addClass('count-0').append( $span );
          $this.before( $li );
        };
      };


      return this.each(function() {
        var $this = $(this);
        var earliest = moment().startOf('week');
        var prev = $this.prev();
        if ( prev ) {
          earliest = moment( prev.attr('id') );
        }
        fill_time_gap_between( earliest.format('YYYY-MM-DD'), $this.attr('id'), $this );
      });
    }
  });
})(jQuery, moment);
