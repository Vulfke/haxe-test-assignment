package views;

import hx.widgets.Sizer;
import hx.widgets.FontWeight;
import hx.widgets.FontStyle;
import hx.widgets.Font;
import hx.widgets.Orientation;
import hx.widgets.ScrolledWindow;
import hx.widgets.Stretch;
import hx.widgets.StaticText;
import hx.widgets.BoxSizer;
import hx.widgets.Window;

class TabView extends View {

    public var title(get, set):String;
    public var text(get, set):String;

    public function new(parent:Window, pageXml: Xml) {
        super(parent);

        getPageData(pageXml);
 
        sizer = new BoxSizer(Orientation.VERTICAL);

        var innerSizer = new BoxSizer(Orientation.VERTICAL);
        var frame = createFrame("", innerSizer);

        var scrollview:ScrolledWindow = new ScrolledWindow(frame);
        scrollview.sizer = new BoxSizer(Orientation.VERTICAL);

        innerSizer.add(scrollview, 1, Stretch.EXPAND);
        sizer.add(frame, 1, Stretch.EXPAND);

        scrollview.setScrollbars(10, 10, 0, 0);

        addTitle(scrollview, scrollview.sizer);
        addText(scrollview, scrollview.sizer);

    }

    private function addTitle(window:Window, sizer: Sizer) {
        var label:StaticText = new StaticText(window, title);
        label.font = new Font(16, null, FontStyle.ITALIC, FontWeight.BOLD);
        label.foregroundColour = 0x0000FF;
        label.wrap(600);
        sizer.add(label);
    }

    private function addText(window:Window, sizer:Sizer) {
        var label:StaticText = new StaticText(window, text);
        label.wrap(600);
        sizer.add(label);
    }

    private function getPageData(pageXml: Xml) {
        for(elem in pageXml.elements()) {
            switch(elem.nodeName) {
                case "title":
                    title = xmlExtractValue(elem);
                case "text":
                    text = xmlExtractValue(elem);
                default:
                    continue;
            }
        }
    }
    
    private function xmlExtractValue(xml:Xml):String {
        return xml.firstChild().nodeValue;
    }

    private function get_title() {
        return m_title;
    }

    private function set_title(title) {
        m_title = title;
        return m_title;
    }
    
    private function get_text() {
        return m_text;
    }
    
    private function set_text(text) {
        m_text = text;
        return m_text;
    }

    private var m_title: String;
    private var m_text: String;
}