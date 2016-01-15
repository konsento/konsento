// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//

//--- Angle
//= require_tree ./angle/
//--- Application wide
//= require konsento
//--- Controllers
//= require topics/show
//= require topics/new

(function($, undefined) {
  $(function() {
    var controller = window.Konsento.prototype[gon.controller];

    if (controller !== undefined) {
      var action = gon.action;

      if (action === 'Create') {
        action = 'New'
      }

      if (action === 'Update') {
        action = 'Edit'
      }

      var actionClass = controller.prototype[action]

      if (actionClass !== undefined) {
        window.action_instance = new actionClass(gon.params);
        window.action_instance.run();
      }
    }
  });
})(jQuery);
