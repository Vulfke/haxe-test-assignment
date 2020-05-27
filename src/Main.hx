import hx.widgets.TaskBarIcon;
import hx.widgets.*;
import hx.widgets.styles.*;
import views.MainWindowView;
import views.TabsView;
import views.LogView;


/*
Note: Images in buttons for ubuntu dont work until you run:
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"
*/
class Main {
    public static function main() {
        var app = new App();
        app.init();

        var frame:Frame = new Frame(null, "Tabs and buttons");

        var taskBarIcon = new TaskBarIcon();
        taskBarIcon.setBitmap(Bitmap.fromHaxeResource("haxe-logo-tiny.png"), "Some tooltip");
        
        var platform:PlatformInfo  = new PlatformInfo();
        if (platform.isWindows) {
            frame.backgroundColour = 0xFFFFFF;
        }

        frame.menuBar = buildMenu();
        frame.sizer = new BoxSizer(Orientation.VERTICAL);
        frame.resize(800, 600);

        var tabs:Notebook = new Notebook(frame);

        if (platform.isMac) {
            tabs.allowIcons = false;
        }

        if (platform.isWindows) {
            tabs.padding = new Size(6, 6);
        }

        frame.sizer.add(tabs, 3, Stretch.EXPAND | Direction.ALL, 10);

        var mainWindowView:MainWindowView = new MainWindowView(tabs);
        tabs.addPage(mainWindowView, "Main Window", false);
    
        var tabsView:TabsView = new TabsView(tabs, Config.TABS_FILE);
        tabs.addPage(tabsView, "Tabs", false);

        setupEvents(frame, tabs, taskBarIcon);
        
        var log:LogView = new LogView(frame);
        log.resize( -1, 100);
        frame.sizer.addSpacer(5);
        frame.sizer.add(log, 1, Stretch.EXPAND | Direction.ALL);

        frame.layout();
        frame.show();

        LogView.log("Ready");

        app.run();
        app.exit();
    }

    private static function buildMenu():MenuBar {
        var menuBar:MenuBar = new MenuBar();
            var file:Menu = new Menu();
                file.append(1000, "Exit");
            menuBar.append(file, "File");

            var menu:Menu = new Menu();
            menu.appendItem(new MenuItem(menu, "Something"));

                var subMenu = new Menu();

                // bitmap must be set before the item is added
                var item1 = new MenuItem(subMenu, "Item 1", 1001);
                item1.bitmap = Bitmap.fromHaxeResource("haxe-logo-small.png");
                subMenu.appendItem(item1);

                subMenu.append(1002, "Item 2");
                subMenu.append(1003, "Item 3");
                subMenu.appendSeparator();
                subMenu.appendCheckItem(1004, "Check 1");
                subMenu.appendCheckItem(1005, "Check 2");
                subMenu.appendCheckItem(1006, "Check 3");
                subMenu.appendSeparator();
                subMenu.appendRadioItem(1007, "Radio 1");
                subMenu.appendRadioItem(1008, "Radio 2");
                subMenu.appendRadioItem(1009, "Radio 3");
            menu.appendSubMenu(subMenu, "Sub Menu");

        menuBar.append(menu, "Test Menu");

        return menuBar;
    }

    private static function setupEvents(frame: Frame, tabs: Notebook, taskBarIcon: TaskBarIcon) {
        frame.bind(EventType.MENU, function(e:Event) {
            LogView.log('Menu event: id=${e.id}');
            if(e.id == 1000) {
                frame.close();
            }
        });
        
        tabs.bind(EventType.NOTEBOOK_PAGE_CHANGED, function(e) {
            e.skip(); // seems if you dont skip the event on osx then nothing shows - presumably this event handler is "stealing" the event
            LogView.log('Notebook page changed: index=${tabs.selection}, text=${tabs.selectionText}');
        });

        frame.bind(EventType.CLOSE_WINDOW, function(e) {
            var closeEvent = e.convertTo(CloseEvent);
            if (closeEvent.canVeto) {
                var dialog:MessageDialog = new MessageDialog(frame, 
                    "Do you wish to minimise this window instead of closing it?", "Close / minimise?",
                    MessageDialogStyle.YES_NO | MessageDialogStyle.CANCEL);

                var r = dialog.showModal();

                switch(r) {
                    case 5101: // cancel
                        closeEvent.veto();
                        e.skip(false);
                        e.stopPropagation();
                        return;
                    case 5103: // yes
                        frame.iconize();
                        closeEvent.veto();
                        e.skip(false);
                        e.stopPropagation();
                        return;
                    default: // no
                }
            }
            taskBarIcon.destroy();
        });
    }
}
