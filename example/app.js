var TiExternalDisplay = require('com.bouncingfish.TiExternalDisplay');

TiExternalDisplay.addEventListener('connected', function(e) {
    console.error('EXTERNAL DISPLAY CONNECTED', e);
    // add view for external display
    TiExternalDisplay.setupExternalView(extView);
});

TiExternalDisplay.addEventListener('disconnected', function(e) {
    console.error('Titanium disconnected');
});

// open a window on device screen
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel({ text: 'DEVICE SCREEN' });
win.add(label);
win.open();


// prepare view for external display
var extView = Ti.UI.createView({
    backgroundColor:'white'
});
extView.addEventListener('postlayout', function(e) {
    console.log('extView postlayout', extView.rect.x, extView.rect.y, extView.rect.width, extView.rect.height);
});

var extLabel = Ti.UI.createLabel({
    text: 'EXTERNAL SCREEN'
});
extLabel.addEventListener('postlayout', function(e) {
    console.log('extLabel postlayout', extLabel.rect.x, extLabel.rect.y, extLabel.rect.width, extLabel.rect.height);
});

extView.add(extLabel);