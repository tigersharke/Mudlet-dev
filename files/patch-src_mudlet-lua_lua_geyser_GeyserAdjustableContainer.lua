--- src/mudlet-lua/lua/geyser/GeyserAdjustableContainer.lua.orig	2026-07-06 15:47:25 UTC
+++ src/mudlet-lua/lua/geyser/GeyserAdjustableContainer.lua
@@ -606,6 +606,11 @@ local function createMenus(self, parent, name, func)
 -- @param onClick function which will be executed onClick
 local function createMenus(self, parent, name, func)
     local label = self.adjLabel
+    -- Extra per-call safety
+    self.Locale = self.Locale or mudlet.Locale or {}
+    self.min_restore = self.min_restore or {}
+    self.max_restore = self.max_restore or {}
+	--end Extra per-call safety
     local menuTxt = self.Locale[name] and self.Locale[name].message or name
     label:addMenuLabel(name, parent)
     label:findMenuElement(parent.."."..name):echo(menuTxt, "nocolor")
@@ -1080,11 +1085,55 @@ function Adjustable.Container:new(cons,container)
     me:createLabels()
     me:createRightClickMenu()
 
+	if getOS() == "freebsd" then
+    -- === FreeBSD CONSTRUCTOR SAFETY NET ===
+    -- This runs every time a new AdjustableContainer is created
+    if not mudlet.Locale or type(mudlet.Locale) ~= "table" then
+        mudlet.Locale = {}
+    end
+
+    me.Locale = me.Locale or mudlet.Locale
+
+    -- Ensure required sub-tables exist
+    me.min_restore = me.min_restore or {}
+    me.max_restore = me.max_restore or {}
+    me.att = me.att or {}
+
+    -- Ensure common translation keys exist
+    local defaultMsgs = {
+        lock     = { message = "Lock" },
+        min_restore = { message = "Minimize" },
+        save     = { message = "Save" },
+        load     = { message = "Load" },
+        attach   = { message = "Attach" },
+        lockstyle = { message = "Lock Style" },
+        custom   = { message = "Custom Items" },
+    }
+    for k, v in pairs(defaultMsgs) do
+        if not me.Locale[k] or type(me.Locale[k]) ~= "table" then
+            me.Locale[k] = v
+        end
+    end
+    -- === End FreeBSD CONSTRUCTOR SAFETY NET ===
+	end
+
     me:globalLockStyles()
     me.minimized =  me.minimized or false
     me.locked =  me.locked or false
 
     me.adjLabelstyle = me.adjLabelstyle..[[ qproperty-alignment: 'AlignLeft | AlignTop';]]
+
+    if getOS() == "freebsd" then
+    -- === FreeBSD Line 1123 Defensive Fix ===
+    if not self.Locale or type(self.Locale) ~= "table" then
+        self.Locale = mudlet.Locale or {}
+    end
+    if not self.min_restore or type(self.min_restore) ~= "table" then
+        self.min_restore = {}
+    end
+    -- === End Line 1123 Fix ===
+	end
+
     me.lockLabel.txt = me.lockLabel.txt or [[<font size="5" face="Noto Emoji">🔒</font>]] .. self.Locale.lock.message
     me.minLabel.txt = me.minLabel.txt or [[<font size="5" face="Noto Emoji">🗕</font>]] ..self.Locale.min_restore.message
     me.saveLabel.txt = me.saveLabel.txt or [[<font size="5" face="Noto Emoji">💾</font>]].. self.Locale.save.message
