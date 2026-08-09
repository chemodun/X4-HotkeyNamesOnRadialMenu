..\..\..\..\XRCatTool.exe -dump -include "compass.xpl" -in "out\hotkey_names_on_radial_menu" -out "steam\hotkey_names_on_radial_menu\subst_01.cat"
..\..\..\..\XRCatTool.exe -dump -exclude "compass.xpl" -exclude "content.xml" -in "out\hotkey_names_on_radial_menu" -out "steam\hotkey_names_on_radial_menu\ext_01.cat"

set /p DUMMY=Hit ENTER to exit...
