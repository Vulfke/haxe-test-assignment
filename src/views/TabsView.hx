package views;

import hx.widgets.Direction;
import hx.widgets.Stretch;
import hx.widgets.Orientation;
import hx.widgets.BoxSizer;
import hx.widgets.Notebook;
import hx.widgets.Window;
import sys.io.File;

class TabsView extends View {
    public function new(parent:Window, configFile: String) {
        super(parent);

        var configFileContent:String;
        var xml: Xml;
        try {
            configFileContent = File.getContent(configFile);
            xml = Xml.parse(configFileContent).firstElement();
        } catch(e:Any) {
            trace(Std.string(e));
            return;
        }

        var tabsNum:Int = -1;
        for(tab in xml.elementsNamed("tabs")) {
            tabsNum = Std.parseInt(tab.get("num"));
        }
        if(tabsNum <= 0) {
            return;
        }

        sizer = new BoxSizer(Orientation.VERTICAL);
        var tabs = new Notebook(this);
        sizer.add(tabs, 3, Stretch.EXPAND | Direction.ALL, 10);

        var tabsCount = 0;
        for(page in xml.elementsNamed('page')) {
            if(tabsCount >= tabsNum) break;
            tabsCount += 1;

            var tab = new TabView(tabs, page);
            tabs.addPage(tab, tab.title, false);
        }

    }
}