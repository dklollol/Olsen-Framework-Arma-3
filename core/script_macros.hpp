#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3
#define QUOTE(var1) #var1

#define FUNC(var1) DOUBLES(FNC,var1)

#define PREP(fncName) FUNC(fncName) = compile preprocessFileLineNumbers QUOTE(core\functions\DOUBLES(fnc,fncName).sqf)

#define DEBUG_LOG(var1) \
if ((typeName var1) != "STRING") then { \
    var1 = str var1; \
}; \
diag_log var1