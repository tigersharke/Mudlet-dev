--- src/TLuaInterpreter.cpp.orig	2026-05-25 20:30:41 UTC
+++ src/TLuaInterpreter.cpp
@@ -5988,6 +5988,15 @@ void TLuaInterpreter::loadGlobal()
 #endif
 
     setupLanguageData();
+    // === FreeBSD ports workaround: Force mudlet.Locale very early ===
+    // This runs before any Lua scripts (including Geyser) are loaded
+    luaL_dostring(pGlobalLua, R"lua(
+        mudlet = mudlet or {}
+        mudlet.Locale = mudlet.Locale or {}
+        print("[Mudlet FreeBSD] C++ early Locale initialization successful")
+    )lua");
+    // === End FreeBSD workaround ===
+
 
     const QString executablePath{QCoreApplication::applicationDirPath()};
     // Initialise the list of path and file names so that
