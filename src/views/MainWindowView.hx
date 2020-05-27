package views;

import hx.widgets.EventType;
import hx.widgets.MessageDialog;
import hx.widgets.Direction;
import hx.widgets.Stretch;
import hx.widgets.Bitmap;
import hx.widgets.Window;
import hx.widgets.Button;
import hx.widgets.GridSizer;

class MainWindowView extends View {
    public function new(parent:Window) {
        super(parent);
        sizer = new GridSizer(4, 5, 5);

        for(i in 0...16) {
            var button = createButton(
                i%2==0? "ALERT_BUTTON" : "PICTURE_BUTTON",
                "button" + i);
            sizer.add(button, 1, Stretch.EXPAND | Direction.ALL);
        }
    }

    private function createButton(type:String, name:String):Window {
        return switch(type) {
            case "ALERT_BUTTON": 
                createAlertButton(name);
            case "PICTURE_BUTTON": 
                createPictureButton();
            default: 
                new Button(this, "unknown");
        };   
    }

    private function createAlertButton(name: String): Window {
        var button:Button = new Button(this, name);
        button.bind(EventType.BUTTON, function(e) {
            var dialog:MessageDialog = new MessageDialog(this, "My name is " + name, "Message Dialog");
            var r = dialog.showModal();
        });
        return button;
    }

    private function createPictureButton(): Window {
        var button = new Button(this);
        button.bitmap = Bitmap.fromHaxeResource("haxe-logo-small.png");
        return button;
    }
}