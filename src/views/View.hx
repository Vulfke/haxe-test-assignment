package views;

import hx.widgets.*;
import hx.widgets.styles.*;

class View extends Panel {

    public function new(parent:Window) {
        super(parent);
    }

    private function createFrame(title:String, innerSizer:Sizer, parentWindow:Window = null):Panel {
        if (parentWindow == null) {
            parentWindow = this;
        }

        var frame:Panel = new Panel(parentWindow);
        frame.sizer = new StaticBoxSizer(Orientation.VERTICAL, frame, title);
        frame.sizer.addSizer(innerSizer, 1, Stretch.GROW | Direction.ALL, 5);

        return frame;
    }
    
}
