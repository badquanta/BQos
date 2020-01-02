#include <locale.h>
const lconv BQlocale={".",",","\003",
".",",","\003",
"","-",
"$"     ,2,1,1,2,2,4,4,
"USD$"  ,2,1,1,2,2,4,4
};

lconv *localeconv(void){
    return &BQlocale;
}