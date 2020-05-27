package views;

import hx.widgets.*;
import hx.widgets.styles.*;

class LogView extends View {

    private static var m_text:TextCtrl;

    public function new(parent:Window) {
        super(parent);

        sizer = new BoxSizer(Orientation.VERTICAL);
        m_text = new TextCtrl(this, null, TextCtrlStyle.MULTILINE);
        sizer.add(m_text, 1, Stretch.EXPAND | Direction.ALL);
    }

    public static function log(text:String) {
        if (m_text.value.length == 0) {
            m_text.appendText(text);
        }
        else {
            m_text.appendText("\n" + text);
        }
    }

}
