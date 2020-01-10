#ifndef TESTING
#   if defined(__cplusplus)
        extern "C" {
#   endif
    typedef void (*constructor)();
    constructor start_ctors;
    constructor end_ctors;
    void callConstructors()
    {
        for(constructor* i = &start_ctors; i != &end_ctors; i++)
            (*i)();
    }
#   if defined(__cplusplus)
        } /* extern "C" */
#   endif
#endif