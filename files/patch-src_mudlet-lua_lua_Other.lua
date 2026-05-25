--- src/mudlet-lua/lua/Other.lua.orig	2026-05-20 20:30:31 UTC
+++ src/mudlet-lua/lua/Other.lua
@@ -1,6 +1,34 @@ ------------------------------------------------------
 ----------------------------------------------------------------------------------
 --- Mudlet Unsorted Stuff
 ----------------------------------------------------------------------------------
+-- === FreeBSD ULTIMATE WORKAROUND - Comprehensive Dummy Locale ===
+print("[Mudlet FreeBSD] Installing comprehensive dummy Locale table")
+
+mudlet.Locale = mudlet.Locale or {}
+
+local dummyEntries = {
+    packageInstallSuccess = { message = "Package '%s' installed successfully." },
+    packageInstallFail    = { message = "Failed to install package '%s': %s" },
+    moduleInstallSuccess  = { message = "Module '%s' installed successfully." },
+    moduleInstallFail     = { message = "Failed to install module '%s': %s" },
+    prefixOk              = { message = "[  OK  ] " },
+    prefixWarn            = { message = "[ WARN ] " },
+    prefixInfo            = { message = "[ INFO ] " },
+    -- Add common Geyser / UI keys
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
+print("[Mudlet FreeBSD] Comprehensive dummy Locale installed")
+-- === End Ultimate Workaround ===
 
 mudlet = mudlet or {}
 mudlet.supports = {
