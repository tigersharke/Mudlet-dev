--- src/mudlet-lua/lua/geyser/GeyserAdjustableContainer.lua.orig	2026-05-19 02:52:13 UTC
+++ src/mudlet-lua/lua/geyser/GeyserAdjustableContainer.lua
@@ -60,7 +60,7 @@ function Adjustable.Container:setTitle(text, color, fo
 -- @param format A format list to use. 'c' - center, 'l' - left, 'r' - right,  'b' - bold, 'i' - italics, 'u' - underline, 's' - strikethrough,  '##' - font size.  For example, "cb18" specifies center bold 18pt font be used.  Order doesn't matter.
 function Adjustable.Container:setTitle(text, color, format)
     self.titleFormat = format or self.titleFormat or "l"
-    self.titleText = text or self.titleText or string.format("%s - Adjustable Container")
+    self.titleText = text or self.titleText or string.format("%s - Adjustable Container", self.name)
     self.titleTxtColor = color or self.titleTxtColor or "green"
     if self.locked and (self.connectedContainers or self.lockStyle == "standard" or self.lockStyle == "border" or self.lockStyle == "full") then
         return
@@ -102,7 +102,7 @@ function Adjustable.Container:onClick(label, event)
             label:showMenuLabel("attLabel") 
         end
 
-        if not self.customItemsLabel.nestedLabels then
+        if not self.customItemsLabel or not self.customItemsLabel.nestedLabels then
             label:hideMenuLabel("customItemsLabel")
         else
             label:showMenuLabel("customItemsLabel")
@@ -123,10 +123,10 @@ function Adjustable.Container:onRelease (label, event)
         raiseEvent(
           "AdjustableContainerRepositionFinish",
           self.name,
-          self.get_width(),
-          self.get_height(),
-          self.get_x(),
-          self.get_y()
+          self:get_width(),
+          self:get_height(),
+          self:get_x(),
+          self:get_y()
         )
         adjustInfo = {}
     end
@@ -160,14 +160,14 @@ function Adjustable.Container:onMove (label, event)
         self:adjustBorder()
         local x, y = getMousePosition()
         local winw, winh = getMainWindowSize()
-        local x1, y1, w, h = self.get_x(), self.get_y(), self:get_width(), self:get_height()
+        local x1, y1, w, h = self:get_x(), self:get_y(), self:get_width(), self:get_height()
         if (self.container) and (self.container ~= Geyser) then
-            x1,y1 = x1-self.container.get_x(), y1-self.container.get_y()
-            winw, winh = self.container.get_width(), self.container.get_height()
+            x1,y1 = x1-self.container:get_x(), y1-self.container:get_y()
+            winw, winh = self.container:get_width(), self.container:get_height()
         end
         local dx, dy = adjustInfo.x - x, adjustInfo.y - y
         local max, min = math.max, math.min
-        local hasScrollBox = self.windowname and Geyser.parentWindows and Geyser.parentWindows[self.windowname] and Geyser.parentWindows[self.windowname].type == "scrollBox"
+        local hasScrollBox = self.windowname and self.windowname ~= "" and Geyser.parentWindows and Geyser.parentWindows[self.windowname] and Geyser.parentWindows[self.windowname].type == "scrollBox"
         if adjustInfo.move and not self.connectedContainers then
             label:setCursor("ClosedHand")
             local tx, ty = max(0,x1-dx), max(0,y1-dy)
@@ -222,10 +222,10 @@ function Adjustable.Container:validAttachPositions()
 function Adjustable.Container:validAttachPositions()
     local winw, winh = getMainWindowSize()
     local found_positions = {}
-    if  (winh*0.8)-self.get_height()<= self.get_y()  then  found_positions[#found_positions+1] = "bottom" end
-    if  (winw*0.8)-self.get_width() <= self.get_x() then  found_positions[#found_positions+1] = "right" end
-    if self.get_y() <= winh*0.2 then found_positions[#found_positions+1] = "top" end
-    if self.get_x() <= winw*0.2 then found_positions[#found_positions+1] = "left" end
+    if  (winh*0.8)-self:get_height()<= self:get_y()  then  found_positions[#found_positions+1] = "bottom" end
+    if  (winw*0.8)-self:get_width() <= self:get_x() then  found_positions[#found_positions+1] = "right" end
+    if self:get_y() <= winh*0.2 then found_positions[#found_positions+1] = "top" end
+    if self:get_x() <= winw*0.2 then found_positions[#found_positions+1] = "left" end
     return found_positions
 end
 
@@ -245,13 +245,13 @@ function Adjustable.Container:adjustBorder()
     end
 
     if  where == "right" then 
-        self.borderSize = winw+self.attachedMargin-self.get_x()
+        self.borderSize = winw+self.attachedMargin-self:get_x()
     elseif  where == "left"    then
-        self.borderSize =  self.get_width()+self.get_x()+self.attachedMargin
+        self.borderSize =  self:get_width()+self:get_x()+self.attachedMargin
     elseif  where == "bottom"  then 
-        self.borderSize = winh+self.attachedMargin-self.get_y()
+        self.borderSize = winh+self.attachedMargin-self:get_y()
     elseif  where == "top"     then 
-        self.borderSize = self.get_height()+self.get_y()+self.attachedMargin
+        self.borderSize = self:get_height()+self:get_y()+self.attachedMargin
     else
         self.attached = false
         return
@@ -263,7 +263,9 @@ function Adjustable.Container:adjustBorder()
         end
     end
     local funcname = string.format("setBorder%s", string.title(where))
-    _G[funcname](borderSize)
+    if _G[funcname] then
+        _G[funcname](borderSize)
+    end
 end
 
 -- internal function to adjust connected containers
@@ -791,7 +793,7 @@ function Adjustable.Container:load(slot, dir)
     if mytable.windowname ~= self.windowname then
         if mytable.windowname == "main" then
             self:changeContainer(Geyser)
-        else
+        elseif Geyser.parentWindows and Geyser.parentWindows[mytable.windowname] then
             self:changeContainer(Geyser.parentWindows[mytable.windowname])
         end
     end
@@ -849,10 +851,10 @@ function Adjustable.Container:reposition()
     raiseEvent(
       "AdjustableContainerReposition",
       self.name,
-      self.get_width(),
-      self.get_height(),
-      self.get_x(),
-      self.get_y(),
+      self:get_width(),
+      self:get_height(),
+      self:get_x(),
+      self:get_y(),
       adjustInfo.name == self.adjLabel.name and (adjustInfo.move or adjustInfo.right or adjustInfo.left or adjustInfo.top or adjustInfo.bottom)
     )
 end
@@ -914,10 +916,10 @@ function Adjustable.Container:setAbsolute(size_as_abso
 -- @param position_as_absolute bool true to have the position as absolute values
 function Adjustable.Container:setAbsolute(size_as_absolute, position_as_absolute)
     if position_as_absolute then
-        self.x, self.y = self.get_x(), self.get_y()
+        self.x, self.y = self:get_x(), self:get_y()
     end
     if size_as_absolute then
-        self.width, self.height = self.get_width(), self.get_height()
+        self.width, self.height = self:get_width(), self:get_height()
     end
     self:set_constraints(self)
 end
@@ -930,8 +932,8 @@ function Adjustable.Container:setPercent (size_as_perc
     local x, y, w, h = self:get_x(), self:get_y(), self:get_width(), self:get_height()
     local winw, winh = getMainWindowSize()
     if (self.container) and (self.container ~= Geyser) then
-        x,y = x-self.container.get_x(),y-self.container.get_y()
-        winw, winh = self.container.get_width(), self.container.get_height()
+        x,y = x-self.container:get_x(),y-self.container:get_y()
+        winw, winh = self.container:get_width(), self.container:get_height()
     end
     x, y, w, h = make_percent(x/winw), make_percent(y/winh), make_percent(w/winw), make_percent(h/winh)
     if size_as_percent then self:resize(w,h) end
@@ -1085,13 +1087,13 @@ function Adjustable.Container:new(cons,container)
     me.locked =  me.locked or false
 
     me.adjLabelstyle = me.adjLabelstyle..[[ qproperty-alignment: 'AlignLeft | AlignTop';]]
-    me.lockLabel.txt = me.lockLabel.txt or [[<font size="5" face="Noto Emoji">🔒</font>]] .. self.Locale.lock.message
-    me.minLabel.txt = me.minLabel.txt or [[<font size="5" face="Noto Emoji">🗕</font>]] ..self.Locale.min_restore.message
-    me.saveLabel.txt = me.saveLabel.txt or [[<font size="5" face="Noto Emoji">💾</font>]].. self.Locale.save.message
-    me.loadLabel.txt = me.loadLabel.txt or [[<font size="5" face="Noto Emoji">📁</font>]].. self.Locale.load.message
-    me.attLabel.txt  = me.attLabel.txt or [[<font size="5" face="Noto Emoji">⚓</font>]]..self.Locale.attach.message
-    me.lockStylesLabel.txt = me.lockStylesLabel.txt or [[<font size="5" face="Noto Emoji">🖌</font>]]..self.Locale.lockstyle.message
-    me.customItemsLabel.txt = me.customItemsLabel.txt or [[<font size="5" face="Noto Emoji">🖇</font>]]..self.Locale.custom.message
+    me.lockLabel.txt = me.lockLabel.txt or [[<font size="5" face="Noto Emoji">🔒</font>]] .. (self.Locale.lock and self.Locale.lock.message or "Lock")
+    me.minLabel.txt = me.minLabel.txt or [[<font size="5" face="Noto Emoji">🗕</font>]] .. (self.Locale.min_restore and self.Locale.min_restore.message or "Min/Restore")
+    me.saveLabel.txt = me.saveLabel.txt or [[<font size="5" face="Noto Emoji">💾</font>]].. (self.Locale.save and self.Locale.save.message or "Save")
+    me.loadLabel.txt = me.loadLabel.txt or [[<font size="5" face="Noto Emoji">📁</font>]].. (self.Locale.load and self.Locale.load.message or "Load")
+    me.attLabel.txt  = me.attLabel.txt or [[<font size="5" face="Noto Emoji">⚓</font>]].. (self.Locale.attach and self.Locale.attach.message or "Attach")
+    me.lockStylesLabel.txt = me.lockStylesLabel.txt or [[<font size="5" face="Noto Emoji">🖌</font>]].. (self.Locale.lockstyle and self.Locale.lockstyle.message or "Style")
+    me.customItemsLabel.txt = me.customItemsLabel.txt or [[<font size="5" face="Noto Emoji">🖇</font>]].. (self.Locale.custom and self.Locale.custom.message or "Custom")
 
     me.adjLabel:setStyleSheet(me.adjLabelstyle)
     me.exitLabel:setStyleSheet(me.buttonstyle)
