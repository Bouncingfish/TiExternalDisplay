# External Display Support for iOS / iPad

Plug in an external display and you can launch a different view / views on the display vs the iPad itself.

Add to your `TiApp.xml` modules section:

```
<modules>
	<module platform="iphone">com.bouncingfish.TiExternalDisplay</module>
</modules>
```

Then use as follows:

```
var TiExternalDisplay = require('com.bouncingfish.TiExternalDisplay');

TiExternalDisplay.addEventListener('connected', function(e) {
    console.error('EXTERNAL DISPLAY CONNECTED', e);
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
```

## Credits

Thanks to [bduyng](https://github.com/bduyng)

## License

Copyright 2020 BouncingFish

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
