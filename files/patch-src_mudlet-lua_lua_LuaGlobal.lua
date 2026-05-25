--- src/mudlet-lua/lua/LuaGlobal.lua.orig	2026-05-20 20:30:31 UTC
+++ src/mudlet-lua/lua/LuaGlobal.lua
@@ -1,4 +1,46 @@ -- Mudlet Lua packages loader
 -- Mudlet Lua packages loader
+-- === FreeBSD ULTIMATE EARLY LOCALE FIX (Combined) ===
+print("[Mudlet FreeBSD] Installing ULTIMATE early Locale protection in LuaGlobal.lua")
+
+mudlet = mudlet or {}
+mudlet.Locale = mudlet.Locale or {}
+
+-- Comprehensive dummy entries for Geyser / UI
+local dummyEntries = {
+    packageInstallSuccess = { message = "Package '%s' installed successfully." },
+    packageInstallFail    = { message = "Failed to install package '%s': %s" },
+    moduleInstallSuccess  = { message = "Module '%s' installed successfully." },
+    moduleInstallFail     = { message = "Failed to install module '%s': %s" },
+    prefixOk              = { message = "[  OK  ] " },
+    prefixWarn            = { message = "[ WARN ] " },
+    prefixInfo            = { message = "[ INFO ] " },
+    attach                = { message = "Attach" },
+    detach                = { message = "Detach" },
+    lock                  = { message = "Lock" },
+    unlock                = { message = "Unlock" },
+    close                 = { message = "Close" },
+    minimize              = { message = "Minimize" },
+}
+
+for k, v in pairs(dummyEntries) do
+    mudlet.Locale[k] = mudlet.Locale[k] or v
+end
+
+-- Global protection for Geyser AdjustableContainer
+if Geyser and Geyser.AdjustableContainer and Geyser.AdjustableContainer.new then
+    local oldNew = Geyser.AdjustableContainer.new
+    Geyser.AdjustableContainer.new = function(self, ...)
+        local obj = oldNew(self, ...)
+        if not obj.Locale or type(obj.Locale) ~= "table" then
+            obj.Locale = mudlet.Locale
+        end
+        return obj
+    end
+    print("[Mudlet FreeBSD] Geyser AdjustableContainer constructor protected from LuaGlobal")
+end
+
+print("[Mudlet FreeBSD] Early Locale protection completed")
+-- === End ULTIMATE EARLY FIX ===
 
 if package.loaded["rex_pcre2"] then
   rex = require "rex_pcre2"
