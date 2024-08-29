ResourceLibrary
{
   name = "HUD",
   
   ImageLibrary
   {
      Image{ name="ColorPickerBackgroundAlpha", file="ColorPicker/ColorBackgroundAlpha.png" },
      Image{ name="ColorPickerControlPoint", file="ColorPicker/SVControlPoint.png" },
      Image{ name="ColorPickerHueWheel", file="ColorPicker/hue_wheel.png" },
      Image{ name="ColorPickerHueWheelAlpha", file="ColorPicker/hue_wheel_alpha.png" },
      Image{ name="ColorPickerGradientDiamond", file="ColorPicker/gradient_diamond.png" },

      Image{ name = "LibraryAdd", file = "LibraryAdd.png" },
      Image{ name = "LibraryFilterToggle", file = "LibraryFilterToggle.png" },
      Image{ name = "LibraryRemove", file = "LibraryRemove.png" },
      Image{ name = "LibraryDown", file = "LibraryDown.png" },
      Image{ name = "LibraryHover", file = "LibraryHover.png" },
      Image{ name = "LibraryUp", file = "LibraryUp.png" },
      Image{ name = "LibraryInSceneDown", file = "LibraryInSceneDown.png" },
      Image{ name = "LibraryInSceneHover", file = "LibraryInSceneHover.png" },
      Image{ name = "LibraryInSceneUp", file = "LibraryInSceneUp.png" },

      Image{ name = "StageCallout", file = "StageCallout.png" },
      Image{ name = "NoThumbnail", file = "NoThumbnail.png" },

      Image{ name = "MaterialEditorButtonOn", file = "MaterialEditorButtonOn.png" },
      Image{ name = "MaterialEditorButtonOff", file = "MaterialEditorButtonOff.png" },
      Image{ name = "MaterialEditorControlPoint", file = "MaterialEditorControlPoint.png" },
      Image{ name = "MaterialEditorCrosshairBar", file = "MaterialEditorCrosshairBar.png" },
      Image{ name = "MaterialEditorHeader", file = "MaterialEditorHeader.png" },
      Image{ name = "MaterialEditorNameField", file = "MaterialEditorNameField.png" },
      Image{ name = "MaterialEditorPanel", file = "MaterialEditorPanel.png" },
      Image{ name = "MaterialEditorPrimaryColourLabel", file = "MaterialEditorPrimaryColourLabel.png" },

      Image{ name = "MaterialMiniEditorColourLabel", file = "MaterialMiniEditorColourLabel.png" },
      Image{ name = "MaterialMiniEditorNameField", file = "MaterialMiniEditorNameField.png" },
      Image{ name = "MaterialMiniEditorPanel", file = "MaterialMiniEditorPanel.png" },

      Image{ name = "TextureEditorPanel", file = "TextureEditorPanel.png" },
      Image{ name = "UVEditorForeground", file = "UVEditorForeground.png" },
      Image{ name = "FlyoutLeftHighlight", file = "FlyoutLeftHighlight.png" },
      Image{ name = "FlyoutLeftOpen", file = "FlyoutLeftOpen.png" },

      Image{ name = "StampAddPassive", file = "stampaddpassive.png" },
      Image{ name = "StampAddHover", file = "stampaddhover.png" },
   },

   ImageSet
   {
      name = "MaterialEditorButton",
      ImageItem{ type = "on", name = "MaterialEditorButtonOn" },
      ImageItem{ type = "off", name = "MaterialEditorButtonOff" },
   },

   ImageSet
   {
      name = "MaterialEditorFlyout",
      ImageItem{ type = "unavail", name = "FlyoutLeftOpen" },
      ImageItem{ type = "avail", name = "FlyoutLeftOpen" },
      ImageItem{ type = "hover", name = "FlyoutLeftHighlight" },
   },

   ImageSet
   {
      name = "StampAdd",
      ImageItem{ type = "unavail", name = "StampAddPassive" },
      ImageItem{ type = "avail", name = "StampAddPassive" },
      ImageItem{ type = "hover", name = "StampAddHover" },
   },

   ImageLibrary
   {
      name = "HUD",
      Image{ name = "NavCursorPan", file = "NavCursor_Pan.png" },
      Image{ name = "NavCursorTumble", file = "NavCursor_Tumble.png" },
      Image{ name = "NavCursorZoom", file = "NavCursor_Zoom.png" },
   },

   ImageLibrary
   {
      name = "Cursor",
      Image{ name="ListViewScrollCursor", file="ListViewScrollCursor.png" }
   },

   CursorLibrary
   {
      name = "ListView",
      imageLib = "Cursor",
      
      Cursor{ name="Scroll", image="ListViewScrollCursor", hotspot={1,2} },
   },

   CursorLibrary
   {
      name = "Navigation",
      imageLib = "HUD",
      Cursor{ name = "Pan", image = "NavCursorPan", hotspot = {20,20} },
      Cursor{ name = "Tumble", image = "NavCursorTumble", hotspot = {20,20} },
      Cursor{ name = "Zoom", image = "NavCursorZoom", hotspot = {14,17} },
   },
}
